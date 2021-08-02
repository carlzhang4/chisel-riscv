package core

import chisel3._


class Mem_ram(XLEN:Int) extends Module{
	val io = IO(new Bundle{
		val rd_valid 	= Output(Bool())
		val addr 		= Input(UInt(XLEN.W))
		val rd_data 	= Output(UInt(XLEN.W))

		val mem_en 		= Input(Bool())
		val wr_en 		= Input(Bool())
		val wr_data 	= Input(UInt(XLEN.W))
	})

	val mem = SyncReadMem(1024, UInt(32.W))

	val rd_valid  	= Reg(UInt(1.W))

	
	io.rd_valid 	:= rd_valid
	when(io.wr_en & io.mem_en){
		// io.rd_data 		:= 0.U(32.W)
		mem.write(io.addr,io.wr_data)
	}.elsewhen(io.mem_en){
		// io.rd_data  := mem.read(io.addr)
		rd_valid := 1.U
	}.otherwise{
		// io.rd_data 	:= 0.U(32.W)
		rd_valid := 0.U
	}
	io.rd_data  := mem.read(io.addr)


}