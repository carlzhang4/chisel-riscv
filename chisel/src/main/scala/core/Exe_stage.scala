package core

import chisel3._
import chisel3.util._

class Exe(XLEN:Int) extends Module with HasInstType{
	val io = IO(new Bundle{
		val op1 		=	Input(UInt(XLEN.W))
		val op2			=	Input(UInt(XLEN.W))
		val imm 		=   Input(UInt(XLEN.W))
		val rd			=	Input(UInt(5.W))
		val fu_type		=	Input(FUType())
		val fu_op_type	=	Input(FUOpType())
		//
		val inst		=	Input(UInt(32.W))
		val pc 			=   Input(UInt(XLEN.W))

		
		val fu_type_o	=	Output(FUType())
		val fu_op_type_o=	Output(FUOpType()) 
		val op1_o 		=  	Output(UInt(XLEN.W))
		val op2_o		=	Output(UInt(XLEN.W))
		val imm_o		=	Output(UInt(XLEN.W))
		val wb_addr		=	Output(UInt(5.W))
		val wb_en		=	Output(Bool())
		val wb_data		=	Output(UInt(XLEN.W))
	})

	val wb_en = LookupTreeDefault(io.fu_op_type,0.U(1.W),List(
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
	))



	val shamt = io.op2(5,0) //for rv64 no word op

	val is_adder_sub = !FUOpType.isAdd(io.fu_op_type)
	val adder_res = (io.op1 +& (io.op2 ^ Fill(XLEN,is_adder_sub))) + is_adder_sub
	val xor_res = (io.op1 ^ io.op2)

	val sltu_res = !adder_res(XLEN)// return if(op1<op2)
	val slt_res = xor_res(XLEN-1) ^ sltu_res //return if(op1.asSInt < op2.asSInt)

	val wb_data = LookupTreeDefault(io.fu_op_type,adder_res,List(
		FUOpType.sll		->	(io.op1 << shamt)(XLEN-1, 0), //res[63:0]
		FUOpType.srl 		->	(io.op1 >> shamt),
		FUOpType.sra 		->	(io.op1.asSInt >> shamt).asUInt,

		FUOpType.or 		->	(io.op1 | io.op2),
		FUOpType.and 		->	(io.op1 & io.op2),
		FUOpType.xor 		->	xor_res,
		FUOpType.slt 		->	ZeroExt(slt_res,XLEN),
		FUOpType.sltu 		->	ZeroExt(sltu_res,XLEN),

		
	))//sub不用写，默认返回adder_res


	io.wb_en			:=	RegNext(wb_en)
	io.wb_data			:=	RegNext(wb_data)
	io.wb_addr			:=	RegNext(io.rd)
	io.fu_op_type_o 	:=	RegNext(io.fu_op_type)
	io.fu_type_o 		:=	RegNext(io.fu_type)
	io.op1_o			:=	RegNext(io.op1)
	io.op2_o			:=	RegNext(io.op2)
	io.imm_o			:=	RegNext(io.imm)
}