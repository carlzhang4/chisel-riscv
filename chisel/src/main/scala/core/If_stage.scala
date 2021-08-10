package core

import chisel3._
import chisel3.util._

class If(XLEN:Int) extends Module with HasInstType{
	val io = IO(new Bundle{
		val pc_c			= Output(UInt(XLEN.W))
		val inst			= Input(UInt(64.W))

		val inst_o			= Output(UInt(32.W))
		val inst_valid_o	= Output(Bool())
		val pc_o 			= Output(UInt(XLEN.W))
		
		val ctrl			= Input(UInt(Define.CTRL_LEN.W))

		val jmp_addr		= Input(UInt(XLEN.W))
	})

	val pc_start = "h80000000".U(XLEN.W)-4.U
	val pc = RegInit(pc_start)

	val word_select	= io.pc_c(2)
	val inst = (Mux(word_select === 1.U, io.inst(63,32), io.inst(31,0)))//
	
	val is_jal = (inst === RV32I_Inst.JAL)
	val jal_addr = SignExt( Cat(inst(31),inst(19,12),inst(20),inst(30,21),0.U(1.W)) , XLEN)

	val pc_r 			=	RegInit(0.U(32.W))
	val inst_r 			=	RegInit(0.U(32.W))
	val inst_valid_r 	=	RegInit(false.B)

	val pc_next	=	Mux(is_jal, pc + jal_addr, pc+4.U)
	when(io.ctrl===0.U){
		pc				:=	pc_next
		pc_r 			:=	pc
		inst_r			:=	inst
		inst_valid_r	:=	(pc >= "h80000000".U(XLEN.W))
		
	}.elsewhen(io.ctrl===1.U){
		pc := pc
		pc_r 			:=	pc_r
		inst_r			:=	inst_r
		inst_valid_r	:=	inst_valid_r
	}.elsewhen(io.ctrl===2.U){//jarl
		pc 				:=	io.jmp_addr
		pc_r 			:=	pc
		inst_r			:=	inst
		inst_valid_r	:=	false.B
	}
	

	io.pc_c			:=	pc
	
	io.pc_o 		:=	pc_r
	io.inst_valid_o	:=	inst_valid_r
	io.inst_o		:=	inst_r
}