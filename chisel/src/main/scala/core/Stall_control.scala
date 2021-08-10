package core

import chisel3._
import chisel3.util._
import chisel3.util.experimental.BoringUtils



class Stall(XLEN:Int) extends Module{
	val io = IO(new Bundle{
		val ctrl_if  	= Output(UInt(Define.CTRL_LEN.W))
		val ctrl_id  	= Output(UInt(Define.CTRL_LEN.W))
		val ctrl_exe  	= Output(UInt(Define.CTRL_LEN.W))
	})

	val ld_conflict = Wire(Bool())
	ld_conflict	:=	false.B
	BoringUtils.addSink(ld_conflict,"exe_ld_conflict")

	val id_alu_conlict = Wire(Bool())
	id_alu_conlict	:=	false.B
	BoringUtils.addSink(id_alu_conlict,"id_alu_conlict")

	val id_load_conflict = Wire(Bool())
	id_load_conflict	:=	false.B
	BoringUtils.addSink(id_load_conflict,"id_load_conflict")

	val jmp = Wire(Bool())
	jmp		:=	false.B
	BoringUtils.addSink(jmp,"id_jmp")

	
	when(ld_conflict){
		io.ctrl_if		:=	1.U
		io.ctrl_id		:=	1.U
		io.ctrl_exe		:=	1.U
	}.elsewhen(id_alu_conlict || id_load_conflict){
		io.ctrl_if		:=	1.U
		io.ctrl_id		:=	2.U
		io.ctrl_exe		:=	0.U
	}.elsewhen(jmp===true.B){
		io.ctrl_if		:=	2.U
		io.ctrl_id		:=	0.U
		io.ctrl_exe		:=	0.U
	}.otherwise{
		io.ctrl_if		:=	0.U
		io.ctrl_id		:=	0.U
		io.ctrl_exe		:=	0.U
	}
	
}