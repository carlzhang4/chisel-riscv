package hello

import chisel3._
import chisel3.util._

object LookupTree {
  def apply[T <: Data](key: UInt, mapping: Iterable[(UInt, T)]): T =
    Mux1H(mapping.map(p => (p._1 === key, p._2)))
}

class Hello() extends Module{
	val io = IO(new Bundle{
		val x = Input(UInt(4.W))
		val y = Input(UInt(4.W))
		val out = Output(UInt(4.W))

		val sltu = Output(UInt(1.W))
		val slt = Output(UInt(1.W))
		val sltu_if = Output(UInt(1.W))
		val slt_if = Output(UInt(1.W))
		
	})
	io.out:=(io.x.asSInt << io.y).asUInt
	val a = io.x
	val b = io.y
	val xor = a^b
	val is_adder_sub = 1.U
	val add = (a+&(b^Fill(4,is_adder_sub)))+is_adder_sub
	
	val sltu = !add(4)
	val slt	 = xor(3) ^ sltu
	val sltu_if = (a<b)
	val slt_if = (a.asSInt < b.asSInt)

	io.sltu		:= sltu
	io.slt		:= slt
	io.sltu_if	:= sltu_if
	io.slt_if	:= slt_if
	when(!(slt=/=slt_if) | (sltu=/=sltu_if)){
		printf("%x %x %x %x %x %x %x\n",a,b,add,slt,slt_if,sltu,sltu_if)
	}
	
	// printf("%x\n",io.out)

}



