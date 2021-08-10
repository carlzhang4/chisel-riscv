package core

import chisel3._
import chisel3.util._
import chisel3.util.experimental.BoringUtils


object LookupTree {
  def apply[T <: Data](key: UInt, mapping: Iterable[(UInt, T)]): T =
    Mux1H(mapping.map(p => (p._1 === key, p._2)))
}

object LookupTreeDefault {
  def apply[T <: Data](key: UInt, default: T, mapping: Iterable[(UInt, T)]): T =
    MuxLookup(key, default, mapping.toSeq)
}

class Id(XLEN:Int) extends Module with HasInstType{
	val io = IO(new Bundle{
		val inst			=	Input(UInt(32.W))
		val inst_valid 		=	Input(Bool())
		val pc 				=   Input(UInt(XLEN.W))
		val ctrl			= 	Input(UInt(Define.CTRL_LEN.W))

		val rs1_c			=	Output(UInt(5.W))
		val rs2_c			=	Output(UInt(5.W))
		val rs1_en_c		=	Output(Bool())
		val rs2_en_c		=	Output(Bool())
		val rs1_data		=	Input(UInt(XLEN.W))
		val rs2_data		=	Input(UInt(XLEN.W))

		val rs1_o			=	Output(UInt(5.W))
		val rs2_o			=	Output(UInt(5.W))
		val rs1_en_o		=	Output(Bool())
		val rs2_en_o		=	Output(Bool())

		
		val op1_o				=	Output(UInt(XLEN.W))
		val op2_o				=	Output(UInt(XLEN.W))
		val imm_o				=	Output(UInt(XLEN.W))

		val wb_addr_o 		=	Output(UInt(5.W))
		val wb_en_o			=	Output(Bool())

		val fu_type_o			=	Output(FUType())
		val fu_op_type_o		=	Output(FUOpType())

		val inst_o			=	Output(UInt(32.W))
		val inst_valid_o	=	Output(Bool())
		val pc_o			=	Output(UInt(XLEN.W))

		val jmp_addr		=	Output(UInt(XLEN.W))
	})

	val decode_list = ListLookup(io.inst,Instructions.DecodeDefault,Instructions.DecodeTable)
	val inst_type::fu_type::fu_op_type::Nil	=	decode_list

	val SrcTypeTable = List(
		InstI	->	(SrcType.reg, SrcType.imm),
		InstR	->	(SrcType.reg, SrcType.reg),
		InstS	->	(SrcType.reg, SrcType.reg),
		InstB	->	(SrcType.reg, SrcType.reg),
		InstU	->	(SrcType.pc , SrcType.imm),
		InstJ	->	(SrcType.pc , SrcType.imm),
	)

	val src1_type = LookupTree(inst_type,SrcTypeTable.map(p=>(p._1,p._2._1)))
	val src2_type = LookupTree(inst_type,SrcTypeTable.map(p=>(p._1,p._2._2)))

	

	val imm = LookupTree(inst_type,List(
		InstI	->	SignExt( Cat(io.inst(31,20)) , XLEN),
		InstS	->	SignExt( Cat(io.inst(31,25),io.inst(11,7)) , XLEN),
		InstB	->	SignExt( Cat(io.inst(31),io.inst(7),io.inst(30,25),io.inst(11,8),0.U(1.W)) , XLEN),
		InstU	->	SignExt( Cat(io.inst(31,12),0.U(12.W)) , XLEN),
		InstJ	->	SignExt( Cat(io.inst(31),io.inst(19,12),io.inst(20),io.inst(30,21),0.U(1.W)) , XLEN),
	))
	val is_jalr		=	io.inst === RV32I_Inst.JALR
	val is_branch	=	fu_type === FUType.bru
	
	val rs1_harzard_1 =  io.rs1_en_c && io.wb_addr_o===io.rs1_c
	val rs2_harzard_1 =  io.rs2_en_c && io.wb_addr_o===io.rs2_c

	val j_alu_conflict = is_jalr && io.wb_en_o && io.inst_valid_o && rs1_harzard_1
	val b_alu_conflict	=	is_branch && io.wb_en_o && io.inst_valid_o && (rs1_harzard_1 || rs2_harzard_1)
	val id_alu_conlict = j_alu_conflict || b_alu_conflict
	BoringUtils.addSource(id_alu_conlict,"id_alu_conlict")

	

	val by_exe_wb_en_o		= Wire(Bool())
	val by_exe_wb_data_o	= Wire(UInt(XLEN.W))
	val by_exe_wb_addr_o	= Wire(UInt(5.W))
	val by_exe_inst_valid_o = Wire(Bool())
	by_exe_wb_en_o			:=	false.B
	by_exe_wb_data_o		:=	0.U
	by_exe_wb_addr_o		:=	0.U
	by_exe_inst_valid_o		:=	false.B
	BoringUtils.addSink(by_exe_wb_en_o,"exe_wb_en_o")
	BoringUtils.addSink(by_exe_wb_data_o,"exe_wb_data_o")
	BoringUtils.addSink(by_exe_wb_addr_o,"exe_wb_addr_o")
	BoringUtils.addSink(by_exe_inst_valid_o,"exe_inst_valid_o")


	val rs1_harzard_2	=	by_exe_inst_valid_o && io.rs1_en_c && by_exe_wb_en_o && by_exe_wb_addr_o===io.rs1_c
	val rs2_harzard_2	=	by_exe_inst_valid_o && io.rs2_en_c && by_exe_wb_en_o && by_exe_wb_addr_o===io.rs2_c

	val jmp_addr	=	imm + Mux(is_jalr, Mux(rs1_harzard_2, by_exe_wb_data_o, io.rs1_data), io.pc)

	val j_load_conflict = is_jalr && rs1_harzard_2
	val b_load_conflict = is_branch && (rs1_harzard_2 || rs2_harzard_2)
	val id_load_conflict = j_load_conflict || b_load_conflict

	BoringUtils.addSource(id_load_conflict,"id_load_conflict")

	val cmp1	=	Mux(rs1_harzard_2, by_exe_wb_data_o, io.rs1_data)
	val cmp2	=	Mux(rs2_harzard_2, by_exe_wb_data_o, io.rs2_data)

	val beq		=	cmp1===cmp2
	val bne 	=	cmp1=/=cmp2
	val blt		=	cmp1.asSInt < cmp2.asSInt
	val bge 	=	!blt
	val bltu	=	cmp1 < cmp2
	val bgeu	=	!bltu
	val branch_valid =  is_branch && LookupTree(fu_op_type,List(
		FUOpType.beq	->	beq,
		FUOpType.bne	->	bne,
		FUOpType.blt	->	blt,
		FUOpType.bge	->	bge,
		FUOpType.bltu	->	bltu,
		FUOpType.bgeu	->	bgeu,
	)) 
	val jmp = is_jalr || branch_valid
	BoringUtils.addSource(jmp,"id_jmp")

	val wb_en = Mux(io.inst_valid===false.B, 0.U,LookupTreeDefault(fu_op_type,0.U(1.W),List(
		FUOpType.add		->	1.U,
		FUOpType.sll		->	1.U,
		FUOpType.srl		->	1.U,
		FUOpType.sra 		->	1.U,
		FUOpType.or 		->	1.U,
		FUOpType.and 		->	1.U,
		FUOpType.xor 		->	1.U,
		FUOpType.slt 		->	1.U,
		FUOpType.sltu 		->	1.U,
		FUOpType.sub 		->	1.U,
		FUOpType.jal 		->	1.U,
		FUOpType.jalr 		->	1.U,

		FUOpType.lui 		->	1.U,

		FUOpType.lb 		->	1.U,
		FUOpType.lh 		->	1.U,
		FUOpType.lw 		->	1.U,
		FUOpType.ld 		->	1.U,
		FUOpType.lbu 		->	1.U,
		FUOpType.lhu 		->	1.U,
		FUOpType.lwu 		->	1.U,

		FUOpType.addw 		->	1.U,
		FUOpType.subw 		->	1.U,
		FUOpType.sllw 		->	1.U,
		FUOpType.srlw 		->	1.U,
		FUOpType.sraw 		->	1.U,
	))
	)
	//current cycle
	io.rs1_c 			:=	io.inst(19,15)
	io.rs2_c 			:=	io.inst(24,20)
	io.rs1_en_c 		:=	Mux(src1_type === SrcType.pc, false.B, true.B)
	io.rs2_en_c			:=	Mux(src2_type === SrcType.reg, true.B, false.B)

	//output registers
	val rs1_r 			=	RegInit(0.U(5.W))
	val rs2_r 			=	RegInit(0.U(5.W))
	val rs1_en_r		=	RegInit(false.B)
	val rs2_en_r		=	RegInit(false.B)
	val op1_r			=	RegInit(0.U(XLEN.W))
	val op2_r			=	RegInit(0.U(XLEN.W))

	val imm_r			=	RegInit(0.U(XLEN.W))
	val fu_op_type_r	=	RegInit(0.U(FUOpType.width.W))
	val fu_type_r		=	RegInit(0.U(FUType.width.W))
	val wb_addr_r		=	RegInit(0.U(5.W))
	val wb_en_r			=	RegInit(false.B)
	val pc_o_r			=	RegInit(0.U(XLEN.W))
	val inst_o_r		=	RegInit(0.U(32.W))	
	val inst_valid_o_r	=	RegInit(false.B)

	when(io.ctrl === 0.U){
		rs1_r			:=	io.inst(19,15)
		rs2_r 			:=	io.inst(24,20)
		rs1_en_r 		:=	io.rs1_en_c
		rs2_en_r 		:=	io.rs2_en_c
		op1_r			:=	Mux(io.rs1_en_c === true.B, io.rs1_data, io.pc)
		op2_r			:=	Mux(io.rs2_en_c === true.B, io.rs2_data, imm)
		imm_r			:=	imm
		fu_op_type_r	:=	fu_op_type
		fu_type_r		:=	fu_type
		wb_addr_r		:=	io.inst(11,7)
		wb_en_r			:=	wb_en
		pc_o_r			:=	io.pc
		inst_o_r		:=	io.inst
		inst_valid_o_r	:=	io.inst_valid
		

	}.elsewhen(io.ctrl === 1.U){
		rs1_r 			:=	rs1_r
		rs2_r			:=	rs2_r
		rs1_en_r		:=	rs1_en_r
		rs2_en_r		:=	rs2_en_r
		op1_r			:=	op1_r
		op2_r			:=	op2_r
		imm_r			:=	imm_r
		fu_op_type_r	:=	fu_op_type_r
		fu_type_r		:=	fu_type_r
		wb_addr_r		:=	wb_addr_r
		wb_en_r			:=	wb_en_r
		pc_o_r			:=	pc_o_r
		inst_o_r		:=	inst_o_r
		inst_valid_o_r	:=	inst_valid_o_r
	}.elsewhen(io.ctrl === 2.U){
		rs1_r 			:=	0.U
		rs2_r			:=	0.U
		rs1_en_r		:=	false.B
		rs2_en_r		:=	false.B
		op1_r			:=	0.U
		op2_r			:=	0.U
		imm_r			:=	0.U
		fu_op_type_r	:=	0.U
		fu_type_r		:=	0.U
		wb_addr_r		:=	0.U
		wb_en_r			:=	false.B
		pc_o_r			:=	0.U
		inst_o_r		:=	0.U
		inst_valid_o_r	:=	false.B
	}

	io.rs1_o	 		:=	rs1_r
	io.rs2_o	 		:=	rs2_r
	io.rs1_en_o 		:=	rs1_en_r
	io.rs2_en_o			:=	rs2_en_r

	io.op1_o			:=	op1_r
	io.op2_o			:=	op2_r

	io.imm_o			:=	imm_r
	io.fu_op_type_o		:=	fu_op_type_r
	io.fu_type_o 		:=	fu_type_r
	io.pc_o 		:=  pc_o_r
	io.inst_o 		:= 	inst_o_r
	io.inst_valid_o	:=	inst_valid_o_r

	io.wb_en_o 		:=	wb_en_r
	io.wb_addr_o 	:=	wb_addr_r

	io.jmp_addr	:=	jmp_addr
}