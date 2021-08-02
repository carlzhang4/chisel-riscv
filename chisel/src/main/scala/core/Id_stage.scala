package core

import chisel3._
import chisel3.util._


object LookupTree {
  def apply[T <: Data](key: UInt, mapping: Iterable[(UInt, T)]): T =
    Mux1H(mapping.map(p => (p._1 === key, p._2)))
}

object LookupTreeDefault {
  def apply[T <: Data](key: UInt, default: T, mapping: Iterable[(UInt, T)]): T =
    MuxLookup(key, default, mapping.toSeq)
}

class Id(XLEN:Int) extends Module with HasInstType{
	val io = IO(new Bundle{
		val inst			=	Input(UInt(32.W))
		val pc 				=   Input(UInt(XLEN.W))

		val rs1				=	Output(UInt(5.W))
		val rs2				=	Output(UInt(5.W))
		val rs1_data		=	Input(UInt(XLEN.W))
		val rs2_data		=	Input(UInt(XLEN.W))
		
		val op1				=	Output(UInt(XLEN.W))
		val op2				=	Output(UInt(XLEN.W))
		val imm				=	Output(UInt(XLEN.W))
		val rd				=	Output(UInt(5.W))
		val fu_type			=	Output(FUType())
		val fu_op_type		=	Output(FUOpType())
/////////////////
		val inst_o			=	Output(UInt(32.W))
		val pc_o			=	Output(UInt(XLEN.W))
	})

	val decode_list = ListLookup(io.inst,Instructions.DecodeDefault,Instructions.DecodeTable)
	val inst_type::fu_type::fu_op_type::Nil	=	decode_list

	val SrcTypeTable = List(
		InstI	->	(SrcType.reg, SrcType.imm),
		InstR	->	(SrcType.reg, SrcType.reg),
		InstS	->	(SrcType.reg, SrcType.reg),
		InstB	->	(SrcType.reg, SrcType.reg),
		InstU	->	(SrcType.pc , SrcType.imm),
		InstJ	->	(SrcType.pc , SrcType.imm),
	)

	val src1_type = LookupTree(inst_type,SrcTypeTable.map(p=>(p._1,p._2._1)))
	val src2_type = LookupTree(inst_type,SrcTypeTable.map(p=>(p._1,p._2._2)))

	

	val imm = LookupTree(inst_type,List(
		InstI	->	SignExt( Cat(io.inst(31,20)) , XLEN),
		InstS	->	SignExt( Cat(io.inst(31,25),io.inst(11,7)) , XLEN),
		InstB	->	SignExt( Cat(io.inst(31),io.inst(7),io.inst(30,25),io.inst(11,8),0.U(1.W)) , XLEN),
		InstU	->	SignExt( Cat(io.inst(31,12),0.U(12.W)) , XLEN),
		InstJ	->	SignExt( Cat(io.inst(31),io.inst(19,12),io.inst(20),io.inst(30,21),0.U(1.W)) , XLEN),
	))


	io.rs1 			:=	(Mux(src1_type === SrcType.pc, 0.U, io.inst(19,15)))
	io.rs2	 		:=	(Mux(src2_type === SrcType.reg, io.inst(24,20), 0.U))

	io.op1			:=	RegNext(Mux(io.inst(6,0) === "b0110111".U, 0.U, (Mux(src1_type === SrcType.pc, io.pc, io.rs1_data))))  //fix LUI
	io.op2			:=	RegNext(Mux(src2_type === SrcType.reg, io.rs2_data, imm))
	
	io.imm			:=	RegNext(imm)
	io.fu_op_type	:=	RegNext(fu_op_type)
	io.fu_type 		:=	RegNext(fu_type)
	io.rd			:=	RegNext(io.inst(11,7))
	io.pc_o 		:=  RegNext(io.pc)
	io.inst_o 		:= 	RegNext(io.inst)
}