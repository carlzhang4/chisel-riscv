package core

import chisel3._

class If(XLEN:Int) extends Module{
	val io = IO(new Bundle{
		// val start 		= Input(Bool())
		val inst_addr 	= Output(UInt(XLEN.W))
		val pc 			= Output(UInt(XLEN.W))
	})

	val pc = RegInit("h80000000".U(XLEN.W))
	pc := pc + 4.U
	// when(io.start){
	// 	pc := pc + 4.U
	// }.otherwise{
	// 	pc := "h80000000".U
	// }
	

	io.inst_addr 	:= pc >> 3.U
	io.pc 			:= pc
}