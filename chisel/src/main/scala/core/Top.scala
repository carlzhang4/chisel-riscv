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
	val m_ls		=	Module(new MemStage(XLEN))
	val m_regfile	=	Module(new Regfile(32,XLEN))
	val m_ctrl		=	Module(new Stall(XLEN))
	
	m_if.io.inst 				:=	io.inst_ram.rdata
	m_if.io.jmp_addr			:=	m_id.io.jmp_addr

	m_id.io.inst_valid			:=	m_if.io.inst_valid_o
	m_id.io.inst 				:=	m_if.io.inst_o
	m_id.io.pc 					:= 	m_if.io.pc_o
	
	
	m_id.io.rs1_data			:=	m_regfile.io.r1_data
	m_id.io.rs2_data			:=	m_regfile.io.r2_data

	m_regfile.io.r1_addr		:=	Mux(m_id.io.rs1_en_c===true.B, m_id.io.rs1_c, 0.U)
	m_regfile.io.r2_addr		:=	Mux(m_id.io.rs2_en_c===true.B, m_id.io.rs2_c, 0.U)

	m_exe.io.rs1				:=	m_id.io.rs1_o
	m_exe.io.rs2				:=	m_id.io.rs2_o
	m_exe.io.rs1_en				:=	m_id.io.rs1_en_o
	m_exe.io.rs2_en				:=	m_id.io.rs2_en_o

	m_exe.io.wb_en				:=	m_id.io.wb_en_o
	m_exe.io.wb_addr			:=	m_id.io.wb_addr_o

	m_exe.io.inst_valid			:=	m_id.io.inst_valid_o
	m_exe.io.pc 				:=	m_id.io.pc_o
	m_exe.io.inst 				:=	m_id.io.inst_o
	m_exe.io.op1 				:=	m_id.io.op1_o
	m_exe.io.op2 				:=	m_id.io.op2_o
	m_exe.io.imm 				:=	m_id.io.imm_o
	m_exe.io.fu_op_type 		:=	m_id.io.fu_op_type_o
	m_exe.io.fu_type 			:=	m_id.io.fu_type_o

	m_exe.io.by_wb_addr			:=	m_ls.io.wb_addr_o
	m_exe.io.by_wb_en			:=	m_ls.io.wb_en_o
	m_exe.io.by_wb_data			:=	m_ls.io.wb_data_o

	m_ls.io.wb_addr				:=	m_exe.io.wb_addr_o
	m_ls.io.wb_en				:=	m_exe.io.wb_en_o
	m_ls.io.wb_data				:=	m_exe.io.wb_data_o
	m_ls.io.op1					:=	m_exe.io.op1_o
	m_ls.io.op2					:=	m_exe.io.op2_o
	m_ls.io.imm					:=	m_exe.io.imm_o
	m_ls.io.fu_type				:=	m_exe.io.fu_type_o
	m_ls.io.fu_op_type			:=	m_exe.io.fu_op_type_o
	m_ls.io.pc 					:=	m_exe.io.pc_o
	m_ls.io.inst 				:=	m_exe.io.inst_o
	m_ls.io.inst_valid			:=	m_exe.io.inst_valid_o

	io.data_ram.en 				:= m_ls.io.rd_en
	io.data_ram.rIdx 			:= m_ls.io.rd_idx
	io.data_ram.wIdx 			:= m_ls.io.wr_idx
	io.data_ram.wdata 			:= m_ls.io.wr_data
	io.data_ram.wmask 			:= m_ls.io.wr_mask
	io.data_ram.wen 			:= m_ls.io.wr_en

	m_ls.io.rd_data				:= io.data_ram.rdata


	io.inst_ram.rIdx			:=	m_if.io.pc_c >> 3.U
	io.inst_ram.en 				:=	1.U
	io.inst_ram.wIdx 			:=	m_ls.io.wr_idx
	io.inst_ram.wdata 			:=	m_ls.io.wr_data
	io.inst_ram.wmask 			:=	m_ls.io.wr_mask
	io.inst_ram.wen 			:=	m_ls.io.wr_en



	m_regfile.io.w_addr			:=	(m_ls.io.wb_addr_o)
	m_regfile.io.w_data			:=	(m_ls.io.wb_data_o)
	m_regfile.io.w_en			:=	(m_ls.io.wb_en_o)

	m_if.io.ctrl				:=	m_ctrl.io.ctrl_if
	m_id.io.ctrl				:=	m_ctrl.io.ctrl_id
	m_exe.io.ctrl 				:=	m_ctrl.io.ctrl_exe
	

	val commit = Module(new difftest.DifftestInstrCommit)
	commit.io.clock := clock
	commit.io.coreid := 0.U
	commit.io.index := 0.U

	commit.io.valid		:= RegNext(m_ls.io.inst_valid_o)
	commit.io.pc		:= RegNext(m_ls.io.pc_o)//RegNext((RegNext(RegNext(RegNext(RegNext(m_if.io.pc))))))
	commit.io.instr		:= RegNext(m_ls.io.inst_o)//RegNext(RegNext(RegNext(RegNext(m_id.io.inst))))
	commit.io.skip		:= false.B
	commit.io.isRVC		:= false.B
	commit.io.scFailed	:= false.B
	commit.io.wen		:= RegNext(m_ls.io.wb_en_o)
	commit.io.wdata		:= RegNext(m_ls.io.wb_data_o)
	commit.io.wdest		:= RegNext(m_ls.io.wb_addr_o)

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



