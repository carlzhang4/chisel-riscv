module If(
  input  [31:0] io_test_in,
  output [31:0] io_test_out
);
  wire [33:0] _io_test_out_T = io_test_in * 2'h2; // @[If_stage.scala 10:35]
  assign io_test_out = _io_test_out_T[31:0]; // @[If_stage.scala 10:21]
endmodule
module Id(
  input  [31:0] io_test_in,
  output [31:0] io_test_out
);
  wire [33:0] _io_test_out_T = io_test_in * 2'h3; // @[Id_stage.scala 10:35]
  assign io_test_out = _io_test_out_T[31:0]; // @[Id_stage.scala 10:21]
endmodule
module Top(
  input         clock,
  input         reset,
  input  [31:0] io_test_in,
  output [31:0] io_test_out
);
  wire [31:0] m_if_io_test_in; // @[Top.scala 11:26]
  wire [31:0] m_if_io_test_out; // @[Top.scala 11:26]
  wire [31:0] m_id_io_test_in; // @[Top.scala 12:26]
  wire [31:0] m_id_io_test_out; // @[Top.scala 12:26]
  If m_if ( // @[Top.scala 11:26]
    .io_test_in(m_if_io_test_in),
    .io_test_out(m_if_io_test_out)
  );
  Id m_id ( // @[Top.scala 12:26]
    .io_test_in(m_id_io_test_in),
    .io_test_out(m_id_io_test_out)
  );
  assign io_test_out = m_id_io_test_out; // @[Top.scala 15:21]
  assign m_if_io_test_in = io_test_in; // @[Top.scala 13:25]
  assign m_id_io_test_in = m_if_io_test_out; // @[Top.scala 14:25]
endmodule
