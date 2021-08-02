package top

import chisel3._
import chisel3.util._
import difftest._

  class RAMHelper extends BlackBox {
    val io = IO(new Bundle {
      val clk = Input(Clock())
      val en = Input(Bool())
      val rIdx = Input(UInt(64.W))
      val rdata = Output(UInt(64.W))
      val wIdx = Input(UInt(64.W))
      val wdata = Input(UInt(64.W))
      val wmask = Input(UInt(64.W))
      val wen = Input(Bool())
    })
  }




class SimTop extends Module {
  // 规定的端口格式，不多不少，但可以暂时不使用。
  val io = IO(new Bundle {
    val logCtrl = new LogCtrlIO
    val perfInfo = new PerfInfoIO
    val uart = new UARTIO
	// val start = Input(Bool())
	// val wr_en = Input(Bool())
	// val wr_addr = Input(UInt(10.W))
	// val wr_data = Input(UInt(32.W))
  })

  val rcore = Module(new Top(64))

  		// rcore.io.start := io.start
		// rcore.io.wr_en := io.wr_en
		// rcore.io.wr_addr := io.wr_addr
		// rcore.io.wr_data := io.wr_data

  // rvcore 访问内存的端口，下个步骤会说明，此处暂不连接

  // 暂不使用 difftest 给出的端口，但是还是需要初始化合法值
  io.uart.in.valid := false.B
  io.uart.out.valid := false.B
  io.uart.out.ch := 0.U



  val inst_ram = Module(new RAMHelper)
  val data_ram = Module(new RAMHelper)

  inst_ram.io.clk				:= clock
  inst_ram.io.en				:= rcore.io.inst_ram.en
  inst_ram.io.rIdx				:= rcore.io.inst_ram.rIdx - (BigInt("80000000", 16) >> 3).U
  inst_ram.io.wIdx				:= rcore.io.inst_ram.wIdx
  inst_ram.io.wdata				:= rcore.io.inst_ram.wdata
  inst_ram.io.wmask				:= rcore.io.inst_ram.wmask
  inst_ram.io.wen				:= rcore.io.inst_ram.wen
  rcore.io.inst_ram.rdata		:= inst_ram.io.rdata

  data_ram.io.clk				:= clock
  data_ram.io.en				:= rcore.io.data_ram.en
  data_ram.io.rIdx				:= rcore.io.data_ram.rIdx
  data_ram.io.wIdx				:= rcore.io.data_ram.wIdx
  data_ram.io.wdata				:= rcore.io.data_ram.wdata
  data_ram.io.wmask				:= rcore.io.data_ram.wmask
  data_ram.io.wen				:= rcore.io.data_ram.wen
  rcore.io.data_ram.rdata		:= data_ram.io.rdata



}



