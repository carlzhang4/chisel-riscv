package hello

import chisel3._
import chisel3.tester._
import org.scalatest.FreeSpec
import chisel3.experimental.BundleLiterals._

class HelloSpec extends FreeSpec with ChiselScalatestTester{
	"hello test" in {
		test(new Hello()){dut =>

			var i=0
			var j=0
			for(i <- 0 to 16){
				for(j <- 0 to 16){
					dut.io.x.poke(i.U)
					dut.io.y.poke(j.U)
					dut.clock.step(1)
				}
			}
		}
		println("SUCCESS!!")

	}
}
