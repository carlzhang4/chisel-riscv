package top

import hello._
import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}
import firrtl.options.TargetDirAnnotation


object elaborateSimTop extends App {
  (new chisel3.stage.ChiselStage).execute(
    Array("-X", "verilog", "--full-stacktrace"),
    Seq(ChiselGeneratorAnnotation(() => new Top(64)),
      TargetDirAnnotation("Verilog"))
  )
}

object elaborateRegfile extends App {
  (new chisel3.stage.ChiselStage).execute(
    Array("-X", "verilog", "--full-stacktrace"),
    Seq(ChiselGeneratorAnnotation(() => new Regfile(30,32)),
      TargetDirAnnotation("Verilog"))
  )
}

object elaborateHello extends App {
  (new chisel3.stage.ChiselStage).execute(
    Array("-X", "verilog", "--full-stacktrace"),
    Seq(ChiselGeneratorAnnotation(() => new Hello()),
      TargetDirAnnotation("Verilog"))
  )
}

object topMain extends App {
  (new chisel3.stage.ChiselStage).execute(
    Array("-X", "verilog", "--full-stacktrace"),
    Seq(ChiselGeneratorAnnotation(() => new SimTop()),
      TargetDirAnnotation("Verilog"))
  )
}