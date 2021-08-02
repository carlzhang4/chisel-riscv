package core

import chisel3._

class Inst_ram() extends Module{
	val io = IO(new Bundle{
		val inst_addr = Input(UInt(10.W))
		val inst = Output(UInt(32.W))

		val wr_en = Input(Bool())
		val wr_addr = Input(UInt(10.W))
		val wr_data = Input(UInt(32.W))
	})

	val mem = SyncReadMem(1024, UInt(32.W))

	io.inst := 0.U(32.W)
	when(io.wr_en){
		mem.write(io.wr_addr,io.wr_data)
	}.otherwise{
		io.inst := mem.read(io.inst_addr)
	}
}