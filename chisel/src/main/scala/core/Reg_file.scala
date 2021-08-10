package top

import core._
import chisel3._

class Regfile(depth:Int,width:Int) extends Module{
	val io = IO(new Bundle{
		val w_addr = Input(UInt(5.W))
		val w_data = Input(UInt(width.W))
		val w_en = Input(Bool())

		val r1_addr = Input(UInt(5.W))
		val r1_data = Output(UInt(width.W))

		val r2_addr = Input(UInt(5.W))
		val r2_data = Output(UInt(width.W))
	})
	val registers = RegInit(VecInit(Seq.fill(32)(0.U(width.W))))

	val r1_conflict = (io.w_en===true.B) && (io.w_addr===io.r1_addr)
	val r2_conflict = (io.w_en===true.B) && (io.w_addr===io.r2_addr)

	io.r1_data		:=	Mux(r1_conflict, io.w_data, registers(io.r1_addr))//write earlier
	io.r2_data		:=	Mux(r2_conflict, io.w_data, registers(io.r2_addr))

	when(io.w_en){
		registers(io.w_addr) := (io.w_data)
	}

	val mod = Module(new difftest.DifftestArchIntRegState)
	mod.io.clock := clock
	mod.io.coreid := 0.U
	mod.io.gpr := (registers)

    val csr = Module(new difftest.DifftestCSRState)
    csr.io.clock := clock
    csr.io.coreid := 0.U
    csr.io.mstatus := 0.U
    csr.io.mcause := 0.U
    csr.io.mepc := 0.U
    csr.io.sstatus := 0.U
    csr.io.scause := 0.U
    csr.io.sepc := 0.U
    csr.io.satp := 0.U
    csr.io.mip := 0.U
    csr.io.mie := 0.U
    csr.io.mscratch := 0.U
    csr.io.sscratch := 0.U
    csr.io.mideleg := 0.U
    csr.io.medeleg := 0.U
    csr.io.mtval:= 0.U
    csr.io.stval:= 0.U
    csr.io.mtvec := 0.U
    csr.io.stvec := 0.U
    csr.io.priviledgeMode := 0.U

	val fp = Module(new difftest.DifftestArchFpRegState)
	fp.io.clock		:=	clock
	fp.io.coreid	:=	0.U
	fp.io.fpr 		:=	RegInit(VecInit(Seq.fill(32)(0.U(width.W))))

}