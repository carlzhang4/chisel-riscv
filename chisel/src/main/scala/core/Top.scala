package top

import core._
import chisel3._
import chisel3.util._

// import difftest._


class RamInterface extends Bundle {

    val en = Input(Bool())
    val rIdx = Input(UInt(64.W))
    val rdata = Output(UInt(64.W))
    val wIdx = Input(UInt(64.W))
    val wdata = Input(UInt(64.W))
    val wmask = Input(UInt(64.W))
    val wen = Input(Bool())

}


class Top(XLEN:Int) extends Module{
	val io = IO(new Bundle{
	val inst_ram = Flipped(new RamInterface)
	val data_ram = Flipped(new RamInterface)
	})

	val m_if 		=	Module(new If(XLEN))
	val m_id 		=	Module(new Id(XLEN))
	val m_exe		=	Module(new Exe(XLEN))
	val m_mem		=	Module(new MemStage(XLEN))
	val m_regfile	=	Module(new Regfile(32,XLEN))
	
	val word_select 			= 	m_if.io.pc(2)
	
	m_id.io.inst 				:=	RegNext(Mux(word_select === 1.U, io.inst_ram.rdata(63,32), io.inst_ram.rdata(31,0)))//
	m_id.io.pc 					:= 	m_if.io.pc
	
	m_regfile.io.r1_addr		:=	m_id.io.rs1
	m_regfile.io.r2_addr		:=	m_id.io.rs2

	m_id.io.rs1_data			:=	m_regfile.io.r1_data
	m_id.io.rs2_data			:=	m_regfile.io.r2_data

	m_exe.io.pc 				:=	m_id.io.pc_o
	m_exe.io.inst 				:=	m_id.io.inst_o
	m_exe.io.op1 				:=	m_id.io.op1
	m_exe.io.op2 				:=	m_id.io.op2
	m_exe.io.imm 				:=	m_id.io.imm
	m_exe.io.rd 				:=	m_id.io.rd
	m_exe.io.fu_op_type 		:=	m_id.io.fu_op_type
	m_exe.io.fu_type 			:=	m_id.io.fu_type

	m_mem.io.wb_addr			:=	m_exe.io.wb_addr
	m_mem.io.wb_en				:=	m_exe.io.wb_en
	m_mem.io.wb_data			:=	m_exe.io.wb_data
	m_mem.io.op1				:=	m_exe.io.op1_o
	m_mem.io.op2				:=	m_exe.io.op2_o
	m_mem.io.imm				:=	m_exe.io.imm_o
	m_mem.io.fu_type			:=	m_exe.io.fu_type_o
	m_mem.io.fu_op_type			:=	m_exe.io.fu_op_type_o


	m_mem.io.mem_data_rd			:= io.data_ram.rdata

	io.inst_ram.rIdx					:=	m_if.io.inst_addr
	io.inst_ram.en 						:=	1.U
	io.inst_ram.wIdx 					:=	m_mem.io.mem_addr_wr
	io.inst_ram.wdata 					:=	m_mem.io.mem_data_wr
	io.inst_ram.wmask 					:=	m_mem.io.mem_data_wr
	io.inst_ram.wen 					:=	m_mem.io.mem_en_wr

	io.data_ram.en 						:= m_mem.io.mem_en_rd
	io.data_ram.rIdx 					:= m_mem.io.mem_addr_rd
	io.data_ram.wIdx 					:= m_mem.io.mem_addr_wr
	io.data_ram.wdata 					:= m_mem.io.mem_data_wr
	io.data_ram.wmask 					:= m_mem.io.mem_data_wr//todo
	io.data_ram.wen 					:= m_mem.io.mem_en_wr




	m_regfile.io.w_addr			:=	m_mem.io.wb_addr_r
	m_regfile.io.w_data			:=	m_mem.io.wb_data_r
	m_regfile.io.w_en			:=	m_mem.io.wb_en_r




	val commit = Module(new difftest.DifftestInstrCommit)
	commit.io.clock := clock
	commit.io.coreid := 0.U
	commit.io.index := 0.U

	commit.io.valid := m_mem.io.wb_en_r
	commit.io.pc := RegNext(RegNext(RegNext(RegNext(RegNext(m_if.io.pc)))))
	commit.io.instr := RegNext(RegNext(RegNext(m_id.io.inst)))
	commit.io.skip := false.B
	commit.io.isRVC := false.B
	commit.io.scFailed := false.B
	commit.io.wen := RegNext(m_mem.io.wb_en_r)
	commit.io.wdata := RegNext(m_mem.io.wb_data_r)
	commit.io.wdest := RegNext(m_mem.io.wb_addr_r)

	val cycleCnt = RegInit(1.U(32.W))
	cycleCnt := cycleCnt + 1.U

	val trap = Module(new difftest.DifftestTrapEvent)
	trap.io.clock    := clock
	trap.io.coreid   := 0.U
	trap.io.valid    := (commit.io.instr === BigInt("0000006b", 16).U)
	trap.io.code     := 0.U // GoodTrap
	trap.io.pc       := commit.io.pc
	trap.io.cycleCnt := cycleCnt
	trap.io.instrCnt := 0.U

}



