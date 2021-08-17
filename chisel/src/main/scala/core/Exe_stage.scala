package core

import chisel3._
import chisel3.util._
import chisel3.util.experimental.BoringUtils

class Exe(XLEN:Int) extends Module with HasInstType{
	val io = IO(new Bundle{
		val rs1 		=	Input(UInt(5.W))
		val rs2 		=	Input(UInt(5.W))
		val rs1_en		=	Input(Bool())
		val rs2_en		=	Input(Bool())

		val by_wb_addr	=	Input(UInt(5.W))//两周期后的前传，一周期的前传就在这个模块内
		val by_wb_en	=	Input(Bool())
		val by_wb_data	=	Input(UInt(XLEN.W))

		val ctrl		= 	Input(UInt(Define.CTRL_LEN.W))

		val op1 		=	Input(UInt(XLEN.W))
		val op2			=	Input(UInt(XLEN.W))
		val imm 		=   Input(UInt(XLEN.W))
		val fu_type		=	Input(FUType())
		val fu_op_type	=	Input(FUOpType())
		//
		val inst			=	Input(UInt(32.W))
		val inst_valid		=	Input(Bool())
		val pc 				=   Input(UInt(XLEN.W))

		val wb_addr			=	Input(UInt(5.W))
		val wb_en 			=	Input(Bool())

		val inst_o			=	Output(UInt(32.W))
		val inst_valid_o	=	Output(Bool())
		val pc_o			=	Output(UInt(XLEN.W))

		val fu_type_o		=	Output(FUType())
		val fu_op_type_o	=	Output(FUOpType()) 
		val op1_o 			=  	Output(UInt(XLEN.W))
		val op2_o			=	Output(UInt(XLEN.W))
		val imm_o			=	Output(UInt(XLEN.W))

		val wb_addr_o		=	Output(UInt(5.W))
		val wb_en_o			=	Output(Bool())
		val wb_data_o		=	Output(UInt(XLEN.W))
	})


	val rs1_harzard_1 = io.inst_valid_o && io.rs1_en && io.wb_en_o && io.rs1===io.wb_addr_o
	val rs2_harzard_1 = io.inst_valid_o && io.rs2_en && io.wb_en_o && io.rs2===io.wb_addr_o

	val rs1_harzard_2 = io.rs1_en && io.by_wb_en && io.rs1===io.by_wb_addr//todo inst_valid时生效
	val rs2_harzard_2 = io.rs2_en && io.by_wb_en && io.rs2===io.by_wb_addr

	val next_inst_rd_en = LookupTreeDefault(RegNext(io.fu_op_type),false.B,List(
		FUOpType.lb			->	true.B,
		FUOpType.lh 		->	true.B,
		FUOpType.lw 		->	true.B,
		FUOpType.ld 		->	true.B,
		FUOpType.lbu 		->	true.B,
		FUOpType.lhu 		->	true.B,
		FUOpType.lwu 		->	true.B,
	))

	val ld_conflict =  next_inst_rd_en && (rs1_harzard_1 || rs2_harzard_1)
	BoringUtils.addSource(ld_conflict,"exe_ld_conflict")

	val stall_reserve = RegNext(io.by_wb_data)
	val rs1_harzard_stall = RegNext(rs1_harzard_2 && (ld_conflict))
	val rs2_harzard_stall = RegNext(rs2_harzard_2 && (ld_conflict))

	val op1 = Mux(rs1_harzard_stall, stall_reserve, Mux(rs1_harzard_1, io.wb_data_o, Mux(rs1_harzard_2, io.by_wb_data, io.op1)))
	val op2 = Mux(rs2_harzard_stall, stall_reserve, Mux(rs2_harzard_1, io.wb_data_o, Mux(rs2_harzard_2, io.by_wb_data, io.op2)))



	val shamt = Mux(FUOpType.isWordOp(io.fu_op_type),op2(4,0), op2(5,0))

	val is_InstS = LookupTreeDefault(io.fu_op_type,false.B,List(
		FUOpType.sb			->	true.B,
		FUOpType.sh 		->	true.B,
		FUOpType.sw 		->	true.B,
		FUOpType.sd 		->	true.B,
	))

	val is_adder_sub = !FUOpType.isAdd(io.fu_op_type)
	val adder_res = (op1 +& (Mux(is_InstS, io.imm, op2) ^ Fill(XLEN,is_adder_sub))) + is_adder_sub
	val xor_res = (op1 ^ op2)

	val sltu_res = !adder_res(XLEN)// return if(op1<op2)
	val slt_res = xor_res(XLEN-1) ^ sltu_res //return if(op1.asSInt < op2.asSInt)

	val next_pc	=	io.pc + 4.U

	val shift_src = LookupTreeDefault(io.fu_op_type, op1(XLEN-1,0), List(
		FUOpType.srlw		->	ZeroExt(op1(31,0), XLEN),
		FUOpType.sraw		->	SignExt(op1(31,0), XLEN)
	))

	val res = LookupTreeDefault(io.fu_op_type,adder_res,List(
		FUOpType.sll		->	(shift_src << shamt)(XLEN-1, 0), 
		FUOpType.srl 		->	(shift_src >> shamt),
		FUOpType.sra 		->	(shift_src.asSInt >> shamt).asUInt,

		FUOpType.sllw		->	(shift_src << shamt)(XLEN-1, 0), 
		FUOpType.srlw 		->	(shift_src >> shamt),
		FUOpType.sraw 		->	(shift_src.asSInt >> shamt).asUInt,

		FUOpType.or 		->	(op1 | op2),
		FUOpType.and 		->	(op1 & op2),
		FUOpType.xor 		->	xor_res,
		FUOpType.slt 		->	ZeroExt(slt_res,XLEN),
		FUOpType.sltu 		->	ZeroExt(sltu_res,XLEN),

		FUOpType.jal		->	next_pc,
		FUOpType.jalr		->	next_pc,
		FUOpType.lui		->	op2,
	))//sub不用写，默认返回adder_res
	
	val wb_data = Mux(FUOpType.isWordOp(io.fu_op_type), SignExt(res(31,0), 64), res)

	val wb_en_r			=	RegInit(false.B)
	val wb_data_r		=	RegInit(0.U(XLEN.W))
	val wb_addr_r		=	RegInit(0.U(5.W))
	val fu_op_type_o_r	=	RegInit(0.U(FUOpType.width.W))
	val fu_type_o_r 	=	RegInit(0.U(FUType.width.W))
	val op1_o_r			=	RegInit(0.U(XLEN.W))
	val op2_o_r			=	RegInit(0.U(XLEN.W))
	val imm_o_r			=	RegInit(0.U(XLEN.W))
	val pc_o_r			=	RegInit(0.U(XLEN.W))
	val inst_o_r		=	RegInit(0.U(32.W))
	val inst_valid_o_r	=	RegInit(false.B)

	val write_reg_0 = (io.wb_addr===0.U)&&io.wb_en
	when(io.ctrl === 0.U){
		wb_en_r			:=	io.wb_en
		wb_addr_r		:=	io.wb_addr
		wb_data_r		:=	Mux(write_reg_0, 0.U, wb_data)//fix write x0
		fu_op_type_o_r	:=	io.fu_op_type
		fu_type_o_r		:=	io.fu_type
		op1_o_r			:=	op1
		op2_o_r			:=	op2
		imm_o_r			:=	io.imm
		pc_o_r			:=	io.pc
		inst_o_r		:=	io.inst
		inst_valid_o_r	:=	io.inst_valid
	}.elsewhen(io.ctrl === 1.U){
		wb_en_r			:=	false.B//wb_en_r
		wb_data_r		:=	0.U//wb_data_r
		wb_addr_r		:=	0.U//wb_addr_r
		fu_op_type_o_r	:=	0.U//fu_op_type_o_r
		fu_type_o_r		:=	0.U//fu_type_o_r
		op1_o_r			:=	0.U//op1_o_r
		op2_o_r			:=	0.U//op2_o_r
		imm_o_r			:=	0.U//imm_o_r
		pc_o_r			:=	0.U//pc_o_r
		inst_o_r		:=	0.U//inst_o_r
		inst_valid_o_r	:=	false.B
	}

	io.wb_en_o			:=	wb_en_r
	io.wb_data_o		:=	wb_data_r
	io.wb_addr_o		:=	wb_addr_r
	io.fu_op_type_o 	:=	fu_op_type_o_r
	io.fu_type_o 		:=	fu_type_o_r
	io.op1_o			:=	op1_o_r
	io.op2_o			:=	op2_o_r
	io.imm_o			:=	imm_o_r
	io.pc_o				:=	pc_o_r
	io.inst_o			:=	inst_o_r
	io.inst_valid_o		:=	inst_valid_o_r

	BoringUtils.addSource(io.wb_en_o,"exe_wb_en_o")
	BoringUtils.addSource(io.wb_data_o,"exe_wb_data_o")
	BoringUtils.addSource(io.wb_addr_o,"exe_wb_addr_o")
	BoringUtils.addSource(io.inst_valid_o,"exe_inst_valid_o")
}