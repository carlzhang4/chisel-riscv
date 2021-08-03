package core

import chisel3._
import chisel3.util._

class MemStage(XLEN:Int) extends Module{
	val io = IO(new Bundle{
		val wb_addr		=	Input(UInt(5.W))
		val wb_en		=	Input(Bool())
		val wb_data		=	Input(UInt(XLEN.W))
		val op1 		=	Input(UInt(XLEN.W))
		val op2			=	Input(UInt(XLEN.W))	
		val imm 		=   Input(UInt(XLEN.W))	
		val fu_type		=	Input(FUType())
		val fu_op_type	=	Input(FUOpType())

		val wb_addr_o	=	Output(UInt(5.W))
		val wb_en_o		=	Output(Bool())
		val wb_data_o	=	Output(UInt(XLEN.W))


		val mem_addr_wr	=	Output(UInt(XLEN.W))
		val mem_addr_rd	=	Output(UInt(XLEN.W))
		val mem_en_rd	=	Output(Bool())
		val mem_en_wr	=	Output(Bool())
		val mem_data_wr	=	Output(UInt(XLEN.W))
		val mem_data_rd	=  	Input(UInt(XLEN.W))
		
	})


	val mem_addr_rd	= io.op1 + io.op2
	val mem_addr_wr	= io.op1 + io.imm //sb sh sw

	// val mem_addr = LookupTreeDefault(io.fu_op_type,load_addr,List(
	// 	FUOpType.sb 		->	store_addr,
	// 	FUOpType.sh 		->	store_addr,
	// 	FUOpType.sw 		->	store_addr,		
	// ))

	val mem_en_rd = LookupTreeDefault(io.fu_type,0.U(1.W),List(
		FUType.lsu			->	1.U(1.W),      //res[63:0]		
	))

	val mem_en_wr = LookupTreeDefault(io.fu_op_type,0.U(1.W),List(
		FUOpType.sb 		->	1.U(1.W),
		FUOpType.sh 		->	1.U(1.W),
		FUOpType.sw 		->	1.U(1.W),		
	))

	val mem_data_wr = LookupTreeDefault(io.fu_op_type,0.U(XLEN.W),List(
		FUOpType.sb 		->	ZeroExt(io.op2(7, 0),XLEN),
		FUOpType.sh 		->	ZeroExt(io.op2(15, 0),XLEN),
		FUOpType.sw 		->	ZeroExt(io.op2(31, 0),XLEN),		
	))

	val wb_data_o = LookupTreeDefault(RegNext(io.fu_op_type),RegNext(io.wb_data),List(
		FUOpType.lb			->	(SignExt(io.mem_data_rd(7, 0),XLEN)),      //res[63:0]
		FUOpType.lh 		->	(SignExt(io.mem_data_rd(15, 0),XLEN)), 
		FUOpType.lw 		->	(SignExt(io.mem_data_rd(31, 0),XLEN)), 

		FUOpType.lbu 		->	(ZeroExt(io.mem_data_rd(7, 0),XLEN)),
		FUOpType.lhu 		->	(ZeroExt(io.mem_data_rd(15, 0),XLEN)), 		
	))



	io.wb_addr_o	:=	RegNext(io.wb_addr)
	io.wb_en_o		:=	RegNext(io.wb_en)
	io.wb_data_o	:= 	wb_data_o
	io.mem_en_rd	:= 	mem_en_rd
	io.mem_en_wr	:= 	mem_en_wr
	io.mem_addr_rd	:= 	mem_addr_rd
	io.mem_addr_wr	:= 	mem_addr_wr
	io.mem_data_wr	:= 	mem_data_wr
	
	
}