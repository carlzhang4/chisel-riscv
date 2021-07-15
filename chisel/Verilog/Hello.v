module Hello(
  input        clock,
  input        reset,
  input  [7:0] io_x,
  input  [7:0] io_y,
  output [7:0] io_out
);
  wire [7:0] _io_out_T = io_x; // @[Hello.scala 17:23]
  wire [262:0] _GEN_0 = {{255{_io_out_T[7]}},_io_out_T}; // @[Hello.scala 17:30]
  wire [262:0] _io_out_T_2 = $signed(_GEN_0) << io_y; // @[Hello.scala 17:39]
  assign io_out = _io_out_T_2[7:0]; // @[Hello.scala 17:15]
  always @(posedge clock) begin
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (~reset) begin
          $fwrite(32'h80000002,"%x\n",5'hf); // @[Hello.scala 22:15]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
