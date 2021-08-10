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

		val inst		=	Input(UInt(32.W))
		val inst_valid	=	Input(Bool())
		val pc 			=   Input(UInt(XLEN.W))

		val inst_o			=	Output(UInt(32.W))
		val inst_valid_o	=	Output(Bool())
		val pc_o			=	Output(UInt(XLEN.W))

		val wb_addr_o	=	Output(UInt(5.W))
		val wb_en_o		=	Output(Bool())
		val wb_data_o	=	Output(UInt(XLEN.W))


		val wr_mask =	Output(UInt(XLEN.W))
		val wr_idx	=	Output(UInt(XLEN.W))
		val rd_idx	=	Output(UInt(XLEN.W))
		val rd_en	=	Output(Bool())
		val wr_en	=	Output(Bool())
		val wr_data	=	Output(UInt(XLEN.W))
		val rd_data	=  	Input(UInt(XLEN.W))
		
	})


	val rd_addr	= io.wb_data
	val wr_addr	= io.wb_data //sb sh sw

	val rd_sel	=	rd_addr(2,0)
	val wr_sel	=	wr_addr(2,0)

	val rd_data_b = WireDefault(0.U(8.W))
	val rd_data_h = WireDefault(0.U(16.W))
	val rd_data_w = WireDefault(0.U(32.W))
	val rd_data_d = io.rd_data
	switch(rd_sel){
		is(0.U){rd_data_b := io.rd_data(7,0)}
		is(1.U){rd_data_b := io.rd_data(15,8)}
		is(2.U){rd_data_b := io.rd_data(23,16)}
		is(3.U){rd_data_b := io.rd_data(31,24)}
		is(4.U){rd_data_b := io.rd_data(39,32)}
		is(5.U){rd_data_b := io.rd_data(47,40)}
		is(6.U){rd_data_b := io.rd_data(55,48)}
		is(7.U){rd_data_b := io.rd_data(63,56)}
	}
	switch(rd_sel(2,1)){
		is(0.U){rd_data_h	:= io.rd_data(15,0)}
		is(1.U){rd_data_h	:= io.rd_data(31,16)}
		is(2.U){rd_data_h	:= io.rd_data(47,32)}
		is(3.U){rd_data_h	:= io.rd_data(63,48)}
	}
	switch(rd_sel(2)){
		is(false.B){rd_data_w	:= io.rd_data(31,0)}
		is(true.B) {rd_data_w	:= io.rd_data(63,32)}
	}

	val wr_mask_b	= WireDefault(0.U(64.W))
	val wr_mask_h	= WireDefault(0.U(64.W))
	val wr_mask_w	= WireDefault(0.U(64.W))
	val wr_mask_d	= BigInt("FFFFFFFFFFFFFFFF",16).U

	val wr_mask = LookupTreeDefault(io.fu_op_type,wr_mask_d,List(
		FUOpType.sb 		->	wr_mask_b,
		FUOpType.sh 		->	wr_mask_h,
		FUOpType.sw 		->	wr_mask_w,	
		FUOpType.sd 		->	wr_mask_d,	
	))

	switch(wr_sel){
		is(0.U){wr_mask_b	:= BigInt("00000000000000FF",16).U}
		is(1.U){wr_mask_b	:= BigInt("000000000000FF00",16).U}
		is(2.U){wr_mask_b	:= BigInt("0000000000FF0000",16).U}
		is(3.U){wr_mask_b	:= BigInt("00000000FF000000",16).U}
		is(4.U){wr_mask_b	:= BigInt("000000FF00000000",16).U}
		is(5.U){wr_mask_b	:= BigInt("0000FF0000000000",16).U}
		is(6.U){wr_mask_b	:= BigInt("00FF000000000000",16).U}
		is(7.U){wr_mask_b	:= BigInt("FF00000000000000",16).U}
	}

	switch(wr_sel(2,1)){
		is(0.U){wr_mask_h	:=	BigInt("000000000000FFFF",16).U}
		is(1.U){wr_mask_h	:=	BigInt("00000000FFFF0000",16).U}
		is(2.U){wr_mask_h	:=	BigInt("0000FFFF00000000",16).U}
		is(3.U){wr_mask_h	:=	BigInt("FFFF000000000000",16).U}
	}
	switch(wr_sel(2)){
		is(false.B){wr_mask_w	:=	BigInt("00000000FFFFFFFF",16).U}
		is(true.B) {wr_mask_w	:=	BigInt("FFFFFFFF00000000",16).U}
	}


	val rd_en = LookupTreeDefault(io.fu_op_type,0.U(1.W),List(
		FUOpType.lb			->	1.U(1.W),
		FUOpType.lh 		->	1.U(1.W),
		FUOpType.lw 		->	1.U(1.W),
		FUOpType.ld 		->	1.U(1.W),

		FUOpType.lbu 		->	1.U(1.W),
		FUOpType.lhu 		->	1.U(1.W),
		FUOpType.lwu 		->	1.U(1.W),
	))

	val wr_en = Mux(io.inst_valid===false.B, false.B, LookupTreeDefault(io.fu_op_type,0.U(1.W),List(
		FUOpType.sb 		->	1.U(1.W),
		FUOpType.sh 		->	1.U(1.W),
		FUOpType.sw 		->	1.U(1.W),	
		FUOpType.sd 		->	1.U(1.W),	
	))
	)

	val wr_data = LookupTreeDefault(io.fu_op_type,0.U(XLEN.W),List(
		FUOpType.sb 		->	ZeroExt(io.op2(7, 0),XLEN),
		FUOpType.sh 		->	ZeroExt(io.op2(15, 0),XLEN),
		FUOpType.sw 		->	ZeroExt(io.op2(31, 0),XLEN),
		FUOpType.sd 		->	ZeroExt(io.op2(63, 0),XLEN),		
	))

	val wb_data_o = LookupTreeDefault(io.fu_op_type,io.wb_data,List(
		FUOpType.lb			->	SignExt(rd_data_b,XLEN),      //res[63:0]
		FUOpType.lh 		->	SignExt(rd_data_h,XLEN), 
		FUOpType.lw 		->	SignExt(rd_data_w,XLEN), 
		FUOpType.ld 		->	SignExt(rd_data_d,XLEN), 

		FUOpType.lbu 		->	ZeroExt(rd_data_b,XLEN),
		FUOpType.lhu 		->	ZeroExt(rd_data_h,XLEN), 
		FUOpType.lwu 		->	ZeroExt(rd_data_w,XLEN),		
	))


	io.wb_addr_o	:=	RegNext(io.wb_addr)
	io.wb_en_o		:=	RegNext(io.wb_en)
	io.wb_data_o	:= 	RegNext(wb_data_o)

	io.rd_en		:= 	rd_en
	io.rd_idx		:= 	rd_addr >> 3.U

	io.wr_en		:= 	wr_en
	io.wr_idx		:= 	wr_addr >> 3.U
	io.wr_data		:= 	wr_data
	io.wr_mask		:=	wr_mask
	
	io.pc_o			:=	RegNext(io.pc)
	io.inst_o		:=	RegNext(io.inst)
	io.inst_valid_o	:=	RegNext(io.inst_valid)
	
}