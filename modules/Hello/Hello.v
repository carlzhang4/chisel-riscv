module Hello(
  input         clock,
  input         reset,
  input  [31:0] io_in,
  output [31:0] io_out
);
  wire [33:0] _io_out_T = io_in * 2'h2; // @[Hello.scala 12:22]
  assign io_out = _io_out_T[31:0]; // @[Hello.scala 12:15]
endmodule
