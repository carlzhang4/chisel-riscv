module Inst_ram(
  input         clock,
  input  [9:0]  io_inst_addr,
  output [31:0] io_inst,
  input         io_wr_en,
  input  [9:0]  io_wr_addr,
  input  [31:0] io_wr_data
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] mem [0:1023]; // @[Inst_ram.scala 15:30]
  wire [31:0] mem_io_inst_MPORT_data; // @[Inst_ram.scala 15:30]
  wire [9:0] mem_io_inst_MPORT_addr; // @[Inst_ram.scala 15:30]
  wire [31:0] mem_MPORT_data; // @[Inst_ram.scala 15:30]
  wire [9:0] mem_MPORT_addr; // @[Inst_ram.scala 15:30]
  wire  mem_MPORT_mask; // @[Inst_ram.scala 15:30]
  wire  mem_MPORT_en; // @[Inst_ram.scala 15:30]
  reg  mem_io_inst_MPORT_en_pipe_0;
  reg [9:0] mem_io_inst_MPORT_addr_pipe_0;
  assign mem_io_inst_MPORT_addr = mem_io_inst_MPORT_addr_pipe_0;
  assign mem_io_inst_MPORT_data = mem[mem_io_inst_MPORT_addr]; // @[Inst_ram.scala 15:30]
  assign mem_MPORT_data = io_wr_data;
  assign mem_MPORT_addr = io_wr_addr;
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = io_wr_en;
  assign io_inst = io_wr_en ? 32'h0 : mem_io_inst_MPORT_data; // @[Inst_ram.scala 18:23 Inst_ram.scala 17:17 Inst_ram.scala 21:25]
  always @(posedge clock) begin
    if(mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[Inst_ram.scala 15:30]
    end
    if (io_wr_en) begin
      mem_io_inst_MPORT_en_pipe_0 <= 1'h0;
    end else begin
      mem_io_inst_MPORT_en_pipe_0 <= 1'h1;
    end
    if (io_wr_en ? 1'h0 : 1'h1) begin
      mem_io_inst_MPORT_addr_pipe_0 <= io_inst_addr;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  mem_io_inst_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_io_inst_MPORT_addr_pipe_0 = _RAND_2[9:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module If(
  input         clock,
  input         io_start,
  output [63:0] io_inst_addr
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] pc; // @[If_stage.scala 11:21]
  wire [63:0] _pc_T_1 = pc + 64'h4; // @[If_stage.scala 13:26]
  assign io_inst_addr = {{2'd0}, pc[63:2]}; // @[If_stage.scala 19:28]
  always @(posedge clock) begin
    if (io_start) begin // @[If_stage.scala 12:23]
      pc <= _pc_T_1; // @[If_stage.scala 13:20]
    end else begin
      pc <= 64'h0; // @[If_stage.scala 15:20]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  pc = _RAND_0[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Id(
  input         clock,
  input  [31:0] io_inst,
  output [4:0]  io_rs1_addr,
  output [4:0]  io_rs2_addr,
  input  [63:0] io_rs1_data,
  input  [63:0] io_rs2_data,
  output [63:0] io_op1,
  output [63:0] io_op2,
  output [4:0]  io_rd_addr,
  output        io_rd_en,
  output [4:0]  io_alu_op_type
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [4:0] io_rd_addr_REG; // @[Id_stage.scala 85:48]
  wire [4:0] opcode = io_inst[6:2]; // @[Id_stage.scala 88:40]
  wire [2:0] funct3 = io_inst[14:12]; // @[Id_stage.scala 92:48]
  wire [6:0] funct7 = io_inst[31:25]; // @[Id_stage.scala 93:48]
  wire [19:0] imm_hi = io_inst[31:12]; // @[Id_stage.scala 96:64]
  wire [31:0] imm_lo = {imm_hi,12'h0}; // @[Cat.scala 30:58]
  wire  imm_signBit = imm_lo[31]; // @[BitUtil.scala 9:20]
  wire [31:0] imm_hi_1 = imm_signBit ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _imm_T_1 = {imm_hi_1,imm_hi,12'h0}; // @[Cat.scala 30:58]
  wire  imm_hi_hi_hi = io_inst[31]; // @[Id_stage.scala 98:64]
  wire [7:0] imm_hi_hi_lo = io_inst[19:12]; // @[Id_stage.scala 98:76]
  wire  imm_hi_lo = io_inst[20]; // @[Id_stage.scala 98:91]
  wire [9:0] imm_lo_hi = io_inst[30:21]; // @[Id_stage.scala 98:103]
  wire [20:0] imm_lo_3 = {imm_hi_hi_hi,imm_hi_hi_lo,imm_hi_lo,imm_lo_hi,1'h0}; // @[Cat.scala 30:58]
  wire  imm_signBit_2 = imm_lo_3[20]; // @[BitUtil.scala 9:20]
  wire [42:0] imm_hi_5 = imm_signBit_2 ? 43'h7ffffffffff : 43'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _imm_T_5 = {imm_hi_5,imm_hi_hi_hi,imm_hi_hi_lo,imm_hi_lo,imm_lo_hi,1'h0}; // @[Cat.scala 30:58]
  wire [11:0] imm_lo_4 = io_inst[31:20]; // @[Id_stage.scala 99:64]
  wire  imm_signBit_3 = imm_lo_4[11]; // @[BitUtil.scala 9:20]
  wire [51:0] imm_hi_6 = imm_signBit_3 ? 52'hfffffffffffff : 52'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _imm_T_7 = {imm_hi_6,imm_lo_4}; // @[Cat.scala 30:58]
  wire  imm_hi_hi_lo_1 = io_inst[7]; // @[Id_stage.scala 100:76]
  wire [5:0] imm_hi_lo_1 = io_inst[30:25]; // @[Id_stage.scala 100:87]
  wire [3:0] imm_lo_hi_1 = io_inst[11:8]; // @[Id_stage.scala 100:102]
  wire [12:0] imm_lo_6 = {imm_hi_hi_hi,imm_hi_hi_lo_1,imm_hi_lo_1,imm_lo_hi_1,1'h0}; // @[Cat.scala 30:58]
  wire  imm_signBit_4 = imm_lo_6[12]; // @[BitUtil.scala 9:20]
  wire [50:0] imm_hi_8 = imm_signBit_4 ? 51'h7ffffffffffff : 51'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _imm_T_9 = {imm_hi_8,imm_hi_hi_hi,imm_hi_hi_lo_1,imm_hi_lo_1,imm_lo_hi_1,1'h0}; // @[Cat.scala 30:58]
  wire [11:0] imm_lo_9 = {funct7,io_inst[11:7]}; // @[Cat.scala 30:58]
  wire  imm_signBit_6 = imm_lo_9[11]; // @[BitUtil.scala 9:20]
  wire [51:0] imm_hi_11 = imm_signBit_6 ? 52'hfffffffffffff : 52'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _imm_T_13 = {imm_hi_11,funct7,io_inst[11:7]}; // @[Cat.scala 30:58]
  wire  _imm_T_16 = 5'hd == opcode; // @[Id_stage.scala 13:34]
  wire  _imm_T_17 = 5'h5 == opcode; // @[Id_stage.scala 13:34]
  wire  _imm_T_18 = 5'h1b == opcode; // @[Id_stage.scala 13:34]
  wire  _imm_T_19 = 5'h19 == opcode; // @[Id_stage.scala 13:34]
  wire  _imm_T_20 = 5'h18 == opcode; // @[Id_stage.scala 13:34]
  wire  _imm_T_21 = 5'h0 == opcode; // @[Id_stage.scala 13:34]
  wire  _imm_T_22 = 5'h8 == opcode; // @[Id_stage.scala 13:34]
  wire  _imm_T_23 = 5'h4 == opcode; // @[Id_stage.scala 13:34]
  wire [63:0] _imm_T_24 = _imm_T_16 ? _imm_T_1 : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _imm_T_25 = _imm_T_17 ? _imm_T_1 : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _imm_T_26 = _imm_T_18 ? _imm_T_5 : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _imm_T_27 = _imm_T_19 ? _imm_T_7 : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _imm_T_28 = _imm_T_20 ? _imm_T_9 : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _imm_T_29 = _imm_T_21 ? _imm_T_7 : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _imm_T_30 = _imm_T_22 ? _imm_T_13 : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _imm_T_31 = _imm_T_23 ? _imm_T_7 : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _imm_T_32 = _imm_T_24 | _imm_T_25; // @[Mux.scala 27:72]
  wire [63:0] _imm_T_33 = _imm_T_32 | _imm_T_26; // @[Mux.scala 27:72]
  wire [63:0] _imm_T_34 = _imm_T_33 | _imm_T_27; // @[Mux.scala 27:72]
  wire [63:0] _imm_T_35 = _imm_T_34 | _imm_T_28; // @[Mux.scala 27:72]
  wire [63:0] _imm_T_36 = _imm_T_35 | _imm_T_29; // @[Mux.scala 27:72]
  wire [63:0] _imm_T_37 = _imm_T_36 | _imm_T_30; // @[Mux.scala 27:72]
  wire [63:0] imm = _imm_T_37 | _imm_T_31; // @[Mux.scala 27:72]
  wire [7:0] _alu_op_type_T = {funct3,opcode}; // @[Cat.scala 30:58]
  wire  _alu_op_type_T_9 = 8'h4 == _alu_op_type_T; // @[Id_stage.scala 13:34]
  wire  _alu_op_type_T_10 = 8'hc == _alu_op_type_T; // @[Id_stage.scala 13:34]
  wire  _alu_op_type_T_11 = 8'h14 == _alu_op_type_T; // @[Id_stage.scala 13:34]
  wire  _alu_op_type_T_12 = 8'h1c == _alu_op_type_T; // @[Id_stage.scala 13:34]
  wire  _alu_op_type_T_13 = 8'h24 == _alu_op_type_T; // @[Id_stage.scala 13:34]
  wire  _alu_op_type_T_14 = 8'h2c == _alu_op_type_T; // @[Id_stage.scala 13:34]
  wire  _alu_op_type_T_15 = 8'h34 == _alu_op_type_T; // @[Id_stage.scala 13:34]
  wire  _alu_op_type_T_16 = 8'h3c == _alu_op_type_T; // @[Id_stage.scala 13:34]
  wire [3:0] _alu_op_type_T_17 = _alu_op_type_T_9 ? 4'ha : 4'h0; // @[Mux.scala 27:72]
  wire [4:0] _alu_op_type_T_18 = _alu_op_type_T_10 ? 5'h10 : 5'h0; // @[Mux.scala 27:72]
  wire [3:0] _alu_op_type_T_19 = _alu_op_type_T_11 ? 4'hb : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _alu_op_type_T_20 = _alu_op_type_T_12 ? 4'hc : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _alu_op_type_T_21 = _alu_op_type_T_13 ? 4'hd : 4'h0; // @[Mux.scala 27:72]
  wire [4:0] _alu_op_type_T_22 = _alu_op_type_T_14 ? 5'h12 : 5'h0; // @[Mux.scala 27:72]
  wire [3:0] _alu_op_type_T_23 = _alu_op_type_T_15 ? 4'he : 4'h0; // @[Mux.scala 27:72]
  wire [3:0] _alu_op_type_T_24 = _alu_op_type_T_16 ? 4'hf : 4'h0; // @[Mux.scala 27:72]
  wire [4:0] _GEN_0 = {{1'd0}, _alu_op_type_T_17}; // @[Mux.scala 27:72]
  wire [4:0] _alu_op_type_T_25 = _GEN_0 | _alu_op_type_T_18; // @[Mux.scala 27:72]
  wire [4:0] _GEN_1 = {{1'd0}, _alu_op_type_T_19}; // @[Mux.scala 27:72]
  wire [4:0] _alu_op_type_T_26 = _alu_op_type_T_25 | _GEN_1; // @[Mux.scala 27:72]
  wire [4:0] _GEN_2 = {{1'd0}, _alu_op_type_T_20}; // @[Mux.scala 27:72]
  wire [4:0] _alu_op_type_T_27 = _alu_op_type_T_26 | _GEN_2; // @[Mux.scala 27:72]
  wire [4:0] _GEN_3 = {{1'd0}, _alu_op_type_T_21}; // @[Mux.scala 27:72]
  wire [4:0] _alu_op_type_T_28 = _alu_op_type_T_27 | _GEN_3; // @[Mux.scala 27:72]
  wire [4:0] _alu_op_type_T_29 = _alu_op_type_T_28 | _alu_op_type_T_22; // @[Mux.scala 27:72]
  wire [4:0] _GEN_4 = {{1'd0}, _alu_op_type_T_23}; // @[Mux.scala 27:72]
  wire [4:0] _alu_op_type_T_30 = _alu_op_type_T_29 | _GEN_4; // @[Mux.scala 27:72]
  wire [4:0] _GEN_5 = {{1'd0}, _alu_op_type_T_24}; // @[Mux.scala 27:72]
  reg [4:0] io_alu_op_type_REG; // @[Id_stage.scala 119:40]
  reg [63:0] io_op1_REG; // @[Id_stage.scala 121:48]
  wire  _op2_T_2 = 5'hc == opcode; // @[Id_stage.scala 13:34]
  wire [63:0] _op2_T_9 = _imm_T_20 ? io_rs2_data : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _op2_T_10 = _imm_T_22 ? io_rs2_data : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _op2_T_11 = _op2_T_2 ? io_rs2_data : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _op2_T_12 = _imm_T_16 ? imm : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _op2_T_13 = _imm_T_17 ? imm : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _op2_T_14 = _imm_T_18 ? imm : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _op2_T_15 = _imm_T_19 ? imm : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _op2_T_16 = _imm_T_22 ? imm : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _op2_T_17 = _imm_T_23 ? imm : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _op2_T_18 = _op2_T_9 | _op2_T_10; // @[Mux.scala 27:72]
  wire [63:0] _op2_T_19 = _op2_T_18 | _op2_T_11; // @[Mux.scala 27:72]
  wire [63:0] _op2_T_20 = _op2_T_19 | _op2_T_12; // @[Mux.scala 27:72]
  wire [63:0] _op2_T_21 = _op2_T_20 | _op2_T_13; // @[Mux.scala 27:72]
  wire [63:0] _op2_T_22 = _op2_T_21 | _op2_T_14; // @[Mux.scala 27:72]
  wire [63:0] _op2_T_23 = _op2_T_22 | _op2_T_15; // @[Mux.scala 27:72]
  wire [63:0] _op2_T_24 = _op2_T_23 | _op2_T_16; // @[Mux.scala 27:72]
  reg [63:0] io_op2_REG; // @[Id_stage.scala 146:48]
  reg  io_rd_en_REG; // @[Id_stage.scala 147:48]
  assign io_rs1_addr = io_inst[19:15]; // @[Id_stage.scala 83:40]
  assign io_rs2_addr = io_inst[24:20]; // @[Id_stage.scala 84:40]
  assign io_op1 = io_op1_REG; // @[Id_stage.scala 121:33]
  assign io_op2 = io_op2_REG; // @[Id_stage.scala 146:33]
  assign io_rd_addr = io_rd_addr_REG; // @[Id_stage.scala 85:33]
  assign io_rd_en = io_rd_en_REG; // @[Id_stage.scala 147:33]
  assign io_alu_op_type = io_alu_op_type_REG; // @[Id_stage.scala 119:25]
  always @(posedge clock) begin
    io_rd_addr_REG <= io_inst[11:7]; // @[Id_stage.scala 85:56]
    io_alu_op_type_REG <= _alu_op_type_T_30 | _GEN_5; // @[Mux.scala 27:72]
    io_op1_REG <= io_rs1_data; // @[Id_stage.scala 121:48]
    io_op2_REG <= _op2_T_24 | _op2_T_17; // @[Mux.scala 27:72]
    io_rd_en_REG <= _imm_T_16 | _imm_T_17 | _imm_T_18 | _imm_T_19 | _imm_T_21 | _imm_T_23 | _op2_T_2; // @[Mux.scala 27:72]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_rd_addr_REG = _RAND_0[4:0];
  _RAND_1 = {1{`RANDOM}};
  io_alu_op_type_REG = _RAND_1[4:0];
  _RAND_2 = {2{`RANDOM}};
  io_op1_REG = _RAND_2[63:0];
  _RAND_3 = {2{`RANDOM}};
  io_op2_REG = _RAND_3[63:0];
  _RAND_4 = {1{`RANDOM}};
  io_rd_en_REG = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Exe(
  input         clock,
  input  [63:0] io_op1,
  input  [63:0] io_op2,
  input  [4:0]  io_rd_addr,
  input  [4:0]  io_alu_op_type,
  input         io_rd_en,
  output [4:0]  io_wb_addr,
  output        io_wb_en,
  output [63:0] io_wb_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  _T = 5'ha == io_alu_op_type; // @[Conditional.scala 37:30]
  reg [63:0] io_wb_data_REG; // @[Exe_stage.scala 24:56]
  reg [4:0] io_wb_addr_REG; // @[Exe_stage.scala 25:56]
  reg  io_wb_en_REG; // @[Exe_stage.scala 28:56]
  assign io_wb_addr = _T ? io_wb_addr_REG : 5'h0; // @[Conditional.scala 40:58 Exe_stage.scala 25:41 Exe_stage.scala 21:25]
  assign io_wb_en = io_wb_en_REG; // @[Exe_stage.scala 28:41]
  assign io_wb_data = _T ? io_wb_data_REG : 64'h0; // @[Conditional.scala 40:58 Exe_stage.scala 24:41 Exe_stage.scala 20:25]
  always @(posedge clock) begin
    io_wb_data_REG <= io_op1 + io_op2; // @[Exe_stage.scala 24:63]
    io_wb_addr_REG <= io_rd_addr; // @[Exe_stage.scala 25:56]
    io_wb_en_REG <= io_rd_en; // @[Exe_stage.scala 28:56]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  io_wb_data_REG = _RAND_0[63:0];
  _RAND_1 = {1{`RANDOM}};
  io_wb_addr_REG = _RAND_1[4:0];
  _RAND_2 = {1{`RANDOM}};
  io_wb_en_REG = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module MemStage(
  input         clock,
  input  [4:0]  io_wb_addr,
  input         io_wb_en,
  input  [63:0] io_wb_data,
  output [4:0]  io_wb_addr_r,
  output        io_wb_en_r,
  output [63:0] io_wb_data_r
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [63:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [4:0] io_wb_addr_r_REG; // @[Mem_stage.scala 16:40]
  reg  io_wb_en_r_REG; // @[Mem_stage.scala 17:48]
  reg [63:0] io_wb_data_r_REG; // @[Mem_stage.scala 18:40]
  assign io_wb_addr_r = io_wb_addr_r_REG; // @[Mem_stage.scala 16:25]
  assign io_wb_en_r = io_wb_en_r_REG; // @[Mem_stage.scala 17:33]
  assign io_wb_data_r = io_wb_data_r_REG; // @[Mem_stage.scala 18:25]
  always @(posedge clock) begin
    io_wb_addr_r_REG <= io_wb_addr; // @[Mem_stage.scala 16:40]
    io_wb_en_r_REG <= io_wb_en; // @[Mem_stage.scala 17:48]
    io_wb_data_r_REG <= io_wb_data; // @[Mem_stage.scala 18:40]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  io_wb_addr_r_REG = _RAND_0[4:0];
  _RAND_1 = {1{`RANDOM}};
  io_wb_en_r_REG = _RAND_1[0:0];
  _RAND_2 = {2{`RANDOM}};
  io_wb_data_r_REG = _RAND_2[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Regfile(
  input         clock,
  input  [4:0]  io_w_addr,
  input  [63:0] io_w_data,
  input         io_w_en,
  input  [4:0]  io_r1_addr,
  output [63:0] io_r1_data,
  input  [4:0]  io_r2_addr,
  output [63:0] io_r2_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [63:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [63:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [63:0] _RAND_11;
  reg [63:0] _RAND_12;
  reg [63:0] _RAND_13;
  reg [63:0] _RAND_14;
  reg [63:0] _RAND_15;
  reg [63:0] _RAND_16;
  reg [63:0] _RAND_17;
  reg [63:0] _RAND_18;
  reg [63:0] _RAND_19;
  reg [63:0] _RAND_20;
  reg [63:0] _RAND_21;
  reg [63:0] _RAND_22;
  reg [63:0] _RAND_23;
  reg [63:0] _RAND_24;
  reg [63:0] _RAND_25;
  reg [63:0] _RAND_26;
  reg [63:0] _RAND_27;
  reg [63:0] _RAND_28;
  reg [63:0] _RAND_29;
  reg [63:0] _RAND_30;
  reg [63:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] registers_0; // @[Reg_file.scala 18:28]
  reg [63:0] registers_1; // @[Reg_file.scala 18:28]
  reg [63:0] registers_2; // @[Reg_file.scala 18:28]
  reg [63:0] registers_3; // @[Reg_file.scala 18:28]
  reg [63:0] registers_4; // @[Reg_file.scala 18:28]
  reg [63:0] registers_5; // @[Reg_file.scala 18:28]
  reg [63:0] registers_6; // @[Reg_file.scala 18:28]
  reg [63:0] registers_7; // @[Reg_file.scala 18:28]
  reg [63:0] registers_8; // @[Reg_file.scala 18:28]
  reg [63:0] registers_9; // @[Reg_file.scala 18:28]
  reg [63:0] registers_10; // @[Reg_file.scala 18:28]
  reg [63:0] registers_11; // @[Reg_file.scala 18:28]
  reg [63:0] registers_12; // @[Reg_file.scala 18:28]
  reg [63:0] registers_13; // @[Reg_file.scala 18:28]
  reg [63:0] registers_14; // @[Reg_file.scala 18:28]
  reg [63:0] registers_15; // @[Reg_file.scala 18:28]
  reg [63:0] registers_16; // @[Reg_file.scala 18:28]
  reg [63:0] registers_17; // @[Reg_file.scala 18:28]
  reg [63:0] registers_18; // @[Reg_file.scala 18:28]
  reg [63:0] registers_19; // @[Reg_file.scala 18:28]
  reg [63:0] registers_20; // @[Reg_file.scala 18:28]
  reg [63:0] registers_21; // @[Reg_file.scala 18:28]
  reg [63:0] registers_22; // @[Reg_file.scala 18:28]
  reg [63:0] registers_23; // @[Reg_file.scala 18:28]
  reg [63:0] registers_24; // @[Reg_file.scala 18:28]
  reg [63:0] registers_25; // @[Reg_file.scala 18:28]
  reg [63:0] registers_26; // @[Reg_file.scala 18:28]
  reg [63:0] registers_27; // @[Reg_file.scala 18:28]
  reg [63:0] registers_28; // @[Reg_file.scala 18:28]
  reg [63:0] registers_29; // @[Reg_file.scala 18:28]
  reg [63:0] registers_30; // @[Reg_file.scala 18:28]
  reg [63:0] registers_31; // @[Reg_file.scala 18:28]
  wire [63:0] _GEN_1 = 5'h1 == io_r1_addr ? registers_1 : registers_0; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_2 = 5'h2 == io_r1_addr ? registers_2 : _GEN_1; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_3 = 5'h3 == io_r1_addr ? registers_3 : _GEN_2; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_4 = 5'h4 == io_r1_addr ? registers_4 : _GEN_3; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_5 = 5'h5 == io_r1_addr ? registers_5 : _GEN_4; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_6 = 5'h6 == io_r1_addr ? registers_6 : _GEN_5; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_7 = 5'h7 == io_r1_addr ? registers_7 : _GEN_6; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_8 = 5'h8 == io_r1_addr ? registers_8 : _GEN_7; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_9 = 5'h9 == io_r1_addr ? registers_9 : _GEN_8; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_10 = 5'ha == io_r1_addr ? registers_10 : _GEN_9; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_11 = 5'hb == io_r1_addr ? registers_11 : _GEN_10; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_12 = 5'hc == io_r1_addr ? registers_12 : _GEN_11; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_13 = 5'hd == io_r1_addr ? registers_13 : _GEN_12; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_14 = 5'he == io_r1_addr ? registers_14 : _GEN_13; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_15 = 5'hf == io_r1_addr ? registers_15 : _GEN_14; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_16 = 5'h10 == io_r1_addr ? registers_16 : _GEN_15; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_17 = 5'h11 == io_r1_addr ? registers_17 : _GEN_16; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_18 = 5'h12 == io_r1_addr ? registers_18 : _GEN_17; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_19 = 5'h13 == io_r1_addr ? registers_19 : _GEN_18; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_20 = 5'h14 == io_r1_addr ? registers_20 : _GEN_19; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_21 = 5'h15 == io_r1_addr ? registers_21 : _GEN_20; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_22 = 5'h16 == io_r1_addr ? registers_22 : _GEN_21; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_23 = 5'h17 == io_r1_addr ? registers_23 : _GEN_22; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_24 = 5'h18 == io_r1_addr ? registers_24 : _GEN_23; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_25 = 5'h19 == io_r1_addr ? registers_25 : _GEN_24; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_26 = 5'h1a == io_r1_addr ? registers_26 : _GEN_25; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_27 = 5'h1b == io_r1_addr ? registers_27 : _GEN_26; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_28 = 5'h1c == io_r1_addr ? registers_28 : _GEN_27; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_29 = 5'h1d == io_r1_addr ? registers_29 : _GEN_28; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_30 = 5'h1e == io_r1_addr ? registers_30 : _GEN_29; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  wire [63:0] _GEN_33 = 5'h1 == io_r2_addr ? registers_1 : registers_0; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_34 = 5'h2 == io_r2_addr ? registers_2 : _GEN_33; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_35 = 5'h3 == io_r2_addr ? registers_3 : _GEN_34; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_36 = 5'h4 == io_r2_addr ? registers_4 : _GEN_35; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_37 = 5'h5 == io_r2_addr ? registers_5 : _GEN_36; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_38 = 5'h6 == io_r2_addr ? registers_6 : _GEN_37; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_39 = 5'h7 == io_r2_addr ? registers_7 : _GEN_38; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_40 = 5'h8 == io_r2_addr ? registers_8 : _GEN_39; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_41 = 5'h9 == io_r2_addr ? registers_9 : _GEN_40; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_42 = 5'ha == io_r2_addr ? registers_10 : _GEN_41; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_43 = 5'hb == io_r2_addr ? registers_11 : _GEN_42; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_44 = 5'hc == io_r2_addr ? registers_12 : _GEN_43; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_45 = 5'hd == io_r2_addr ? registers_13 : _GEN_44; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_46 = 5'he == io_r2_addr ? registers_14 : _GEN_45; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_47 = 5'hf == io_r2_addr ? registers_15 : _GEN_46; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_48 = 5'h10 == io_r2_addr ? registers_16 : _GEN_47; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_49 = 5'h11 == io_r2_addr ? registers_17 : _GEN_48; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_50 = 5'h12 == io_r2_addr ? registers_18 : _GEN_49; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_51 = 5'h13 == io_r2_addr ? registers_19 : _GEN_50; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_52 = 5'h14 == io_r2_addr ? registers_20 : _GEN_51; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_53 = 5'h15 == io_r2_addr ? registers_21 : _GEN_52; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_54 = 5'h16 == io_r2_addr ? registers_22 : _GEN_53; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_55 = 5'h17 == io_r2_addr ? registers_23 : _GEN_54; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_56 = 5'h18 == io_r2_addr ? registers_24 : _GEN_55; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_57 = 5'h19 == io_r2_addr ? registers_25 : _GEN_56; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_58 = 5'h1a == io_r2_addr ? registers_26 : _GEN_57; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_59 = 5'h1b == io_r2_addr ? registers_27 : _GEN_58; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_60 = 5'h1c == io_r2_addr ? registers_28 : _GEN_59; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_61 = 5'h1d == io_r2_addr ? registers_29 : _GEN_60; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_62 = 5'h1e == io_r2_addr ? registers_30 : _GEN_61; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  assign io_r1_data = 5'h1f == io_r1_addr ? registers_31 : _GEN_30; // @[Reg_file.scala 20:20 Reg_file.scala 20:20]
  assign io_r2_data = 5'h1f == io_r2_addr ? registers_31 : _GEN_62; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  always @(posedge clock) begin
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'h0 == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_0 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'h1 == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_1 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'h2 == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_2 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'h3 == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_3 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'h4 == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_4 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'h5 == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_5 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'h6 == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_6 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'h7 == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_7 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'h8 == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_8 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'h9 == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_9 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'ha == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_10 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'hb == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_11 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'hc == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_12 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'hd == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_13 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'he == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_14 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'hf == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_15 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'h10 == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_16 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'h11 == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_17 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'h12 == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_18 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'h13 == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_19 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'h14 == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_20 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'h15 == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_21 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'h16 == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_22 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'h17 == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_23 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'h18 == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_24 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'h19 == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_25 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'h1a == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_26 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'h1b == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_27 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'h1c == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_28 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'h1d == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_29 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'h1e == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_30 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
    if (io_w_en) begin // @[Reg_file.scala 22:22]
      if (5'h1f == io_w_addr) begin // @[Reg_file.scala 23:38]
        registers_31 <= io_w_data; // @[Reg_file.scala 23:38]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  registers_0 = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  registers_1 = _RAND_1[63:0];
  _RAND_2 = {2{`RANDOM}};
  registers_2 = _RAND_2[63:0];
  _RAND_3 = {2{`RANDOM}};
  registers_3 = _RAND_3[63:0];
  _RAND_4 = {2{`RANDOM}};
  registers_4 = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  registers_5 = _RAND_5[63:0];
  _RAND_6 = {2{`RANDOM}};
  registers_6 = _RAND_6[63:0];
  _RAND_7 = {2{`RANDOM}};
  registers_7 = _RAND_7[63:0];
  _RAND_8 = {2{`RANDOM}};
  registers_8 = _RAND_8[63:0];
  _RAND_9 = {2{`RANDOM}};
  registers_9 = _RAND_9[63:0];
  _RAND_10 = {2{`RANDOM}};
  registers_10 = _RAND_10[63:0];
  _RAND_11 = {2{`RANDOM}};
  registers_11 = _RAND_11[63:0];
  _RAND_12 = {2{`RANDOM}};
  registers_12 = _RAND_12[63:0];
  _RAND_13 = {2{`RANDOM}};
  registers_13 = _RAND_13[63:0];
  _RAND_14 = {2{`RANDOM}};
  registers_14 = _RAND_14[63:0];
  _RAND_15 = {2{`RANDOM}};
  registers_15 = _RAND_15[63:0];
  _RAND_16 = {2{`RANDOM}};
  registers_16 = _RAND_16[63:0];
  _RAND_17 = {2{`RANDOM}};
  registers_17 = _RAND_17[63:0];
  _RAND_18 = {2{`RANDOM}};
  registers_18 = _RAND_18[63:0];
  _RAND_19 = {2{`RANDOM}};
  registers_19 = _RAND_19[63:0];
  _RAND_20 = {2{`RANDOM}};
  registers_20 = _RAND_20[63:0];
  _RAND_21 = {2{`RANDOM}};
  registers_21 = _RAND_21[63:0];
  _RAND_22 = {2{`RANDOM}};
  registers_22 = _RAND_22[63:0];
  _RAND_23 = {2{`RANDOM}};
  registers_23 = _RAND_23[63:0];
  _RAND_24 = {2{`RANDOM}};
  registers_24 = _RAND_24[63:0];
  _RAND_25 = {2{`RANDOM}};
  registers_25 = _RAND_25[63:0];
  _RAND_26 = {2{`RANDOM}};
  registers_26 = _RAND_26[63:0];
  _RAND_27 = {2{`RANDOM}};
  registers_27 = _RAND_27[63:0];
  _RAND_28 = {2{`RANDOM}};
  registers_28 = _RAND_28[63:0];
  _RAND_29 = {2{`RANDOM}};
  registers_29 = _RAND_29[63:0];
  _RAND_30 = {2{`RANDOM}};
  registers_30 = _RAND_30[63:0];
  _RAND_31 = {2{`RANDOM}};
  registers_31 = _RAND_31[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Top(
  input         clock,
  input         reset,
  input         io_start,
  input         io_wr_en,
  input  [9:0]  io_wr_addr,
  input  [31:0] io_wr_data,
  output [63:0] io_wb_data_r
);
  wire  m_inst_ram_clock; // @[Top.scala 17:39]
  wire [9:0] m_inst_ram_io_inst_addr; // @[Top.scala 17:39]
  wire [31:0] m_inst_ram_io_inst; // @[Top.scala 17:39]
  wire  m_inst_ram_io_wr_en; // @[Top.scala 17:39]
  wire [9:0] m_inst_ram_io_wr_addr; // @[Top.scala 17:39]
  wire [31:0] m_inst_ram_io_wr_data; // @[Top.scala 17:39]
  wire  m_if_clock; // @[Top.scala 18:47]
  wire  m_if_io_start; // @[Top.scala 18:47]
  wire [63:0] m_if_io_inst_addr; // @[Top.scala 18:47]
  wire  m_id_clock; // @[Top.scala 19:47]
  wire [31:0] m_id_io_inst; // @[Top.scala 19:47]
  wire [4:0] m_id_io_rs1_addr; // @[Top.scala 19:47]
  wire [4:0] m_id_io_rs2_addr; // @[Top.scala 19:47]
  wire [63:0] m_id_io_rs1_data; // @[Top.scala 19:47]
  wire [63:0] m_id_io_rs2_data; // @[Top.scala 19:47]
  wire [63:0] m_id_io_op1; // @[Top.scala 19:47]
  wire [63:0] m_id_io_op2; // @[Top.scala 19:47]
  wire [4:0] m_id_io_rd_addr; // @[Top.scala 19:47]
  wire  m_id_io_rd_en; // @[Top.scala 19:47]
  wire [4:0] m_id_io_alu_op_type; // @[Top.scala 19:47]
  wire  m_exe_clock; // @[Top.scala 20:47]
  wire [63:0] m_exe_io_op1; // @[Top.scala 20:47]
  wire [63:0] m_exe_io_op2; // @[Top.scala 20:47]
  wire [4:0] m_exe_io_rd_addr; // @[Top.scala 20:47]
  wire [4:0] m_exe_io_alu_op_type; // @[Top.scala 20:47]
  wire  m_exe_io_rd_en; // @[Top.scala 20:47]
  wire [4:0] m_exe_io_wb_addr; // @[Top.scala 20:47]
  wire  m_exe_io_wb_en; // @[Top.scala 20:47]
  wire [63:0] m_exe_io_wb_data; // @[Top.scala 20:47]
  wire  m_mem_clock; // @[Top.scala 21:47]
  wire [4:0] m_mem_io_wb_addr; // @[Top.scala 21:47]
  wire  m_mem_io_wb_en; // @[Top.scala 21:47]
  wire [63:0] m_mem_io_wb_data; // @[Top.scala 21:47]
  wire [4:0] m_mem_io_wb_addr_r; // @[Top.scala 21:47]
  wire  m_mem_io_wb_en_r; // @[Top.scala 21:47]
  wire [63:0] m_mem_io_wb_data_r; // @[Top.scala 21:47]
  wire  m_regfile_clock; // @[Top.scala 22:39]
  wire [4:0] m_regfile_io_w_addr; // @[Top.scala 22:39]
  wire [63:0] m_regfile_io_w_data; // @[Top.scala 22:39]
  wire  m_regfile_io_w_en; // @[Top.scala 22:39]
  wire [4:0] m_regfile_io_r1_addr; // @[Top.scala 22:39]
  wire [63:0] m_regfile_io_r1_data; // @[Top.scala 22:39]
  wire [4:0] m_regfile_io_r2_addr; // @[Top.scala 22:39]
  wire [63:0] m_regfile_io_r2_data; // @[Top.scala 22:39]
  Inst_ram m_inst_ram ( // @[Top.scala 17:39]
    .clock(m_inst_ram_clock),
    .io_inst_addr(m_inst_ram_io_inst_addr),
    .io_inst(m_inst_ram_io_inst),
    .io_wr_en(m_inst_ram_io_wr_en),
    .io_wr_addr(m_inst_ram_io_wr_addr),
    .io_wr_data(m_inst_ram_io_wr_data)
  );
  If m_if ( // @[Top.scala 18:47]
    .clock(m_if_clock),
    .io_start(m_if_io_start),
    .io_inst_addr(m_if_io_inst_addr)
  );
  Id m_id ( // @[Top.scala 19:47]
    .clock(m_id_clock),
    .io_inst(m_id_io_inst),
    .io_rs1_addr(m_id_io_rs1_addr),
    .io_rs2_addr(m_id_io_rs2_addr),
    .io_rs1_data(m_id_io_rs1_data),
    .io_rs2_data(m_id_io_rs2_data),
    .io_op1(m_id_io_op1),
    .io_op2(m_id_io_op2),
    .io_rd_addr(m_id_io_rd_addr),
    .io_rd_en(m_id_io_rd_en),
    .io_alu_op_type(m_id_io_alu_op_type)
  );
  Exe m_exe ( // @[Top.scala 20:47]
    .clock(m_exe_clock),
    .io_op1(m_exe_io_op1),
    .io_op2(m_exe_io_op2),
    .io_rd_addr(m_exe_io_rd_addr),
    .io_alu_op_type(m_exe_io_alu_op_type),
    .io_rd_en(m_exe_io_rd_en),
    .io_wb_addr(m_exe_io_wb_addr),
    .io_wb_en(m_exe_io_wb_en),
    .io_wb_data(m_exe_io_wb_data)
  );
  MemStage m_mem ( // @[Top.scala 21:47]
    .clock(m_mem_clock),
    .io_wb_addr(m_mem_io_wb_addr),
    .io_wb_en(m_mem_io_wb_en),
    .io_wb_data(m_mem_io_wb_data),
    .io_wb_addr_r(m_mem_io_wb_addr_r),
    .io_wb_en_r(m_mem_io_wb_en_r),
    .io_wb_data_r(m_mem_io_wb_data_r)
  );
  Regfile m_regfile ( // @[Top.scala 22:39]
    .clock(m_regfile_clock),
    .io_w_addr(m_regfile_io_w_addr),
    .io_w_data(m_regfile_io_w_data),
    .io_w_en(m_regfile_io_w_en),
    .io_r1_addr(m_regfile_io_r1_addr),
    .io_r1_data(m_regfile_io_r1_data),
    .io_r2_addr(m_regfile_io_r2_addr),
    .io_r2_data(m_regfile_io_r2_data)
  );
  assign io_wb_data_r = m_mem_io_wb_data_r; // @[Top.scala 53:49]
  assign m_inst_ram_clock = clock;
  assign m_inst_ram_io_inst_addr = m_if_io_inst_addr[9:0]; // @[Top.scala 28:41]
  assign m_inst_ram_io_wr_en = io_wr_en; // @[Top.scala 24:49]
  assign m_inst_ram_io_wr_addr = io_wr_addr; // @[Top.scala 25:41]
  assign m_inst_ram_io_wr_data = io_wr_data; // @[Top.scala 26:41]
  assign m_if_clock = clock;
  assign m_if_io_start = io_start; // @[Top.scala 29:49]
  assign m_id_clock = clock;
  assign m_id_io_inst = m_inst_ram_io_inst; // @[Top.scala 31:49]
  assign m_id_io_rs1_data = m_regfile_io_r1_data; // @[Top.scala 36:49]
  assign m_id_io_rs2_data = m_regfile_io_r2_data; // @[Top.scala 37:49]
  assign m_exe_clock = clock;
  assign m_exe_io_op1 = m_id_io_op1; // @[Top.scala 39:49]
  assign m_exe_io_op2 = m_id_io_op2; // @[Top.scala 40:49]
  assign m_exe_io_rd_addr = m_id_io_rd_addr; // @[Top.scala 41:49]
  assign m_exe_io_alu_op_type = m_id_io_alu_op_type; // @[Top.scala 43:41]
  assign m_exe_io_rd_en = m_id_io_rd_en; // @[Top.scala 42:49]
  assign m_mem_clock = clock;
  assign m_mem_io_wb_addr = m_exe_io_wb_addr; // @[Top.scala 45:57]
  assign m_mem_io_wb_en = m_exe_io_wb_en; // @[Top.scala 46:57]
  assign m_mem_io_wb_data = m_exe_io_wb_data; // @[Top.scala 47:57]
  assign m_regfile_clock = clock;
  assign m_regfile_io_w_addr = m_mem_io_wb_addr_r; // @[Top.scala 49:49]
  assign m_regfile_io_w_data = m_mem_io_wb_data_r; // @[Top.scala 50:49]
  assign m_regfile_io_w_en = m_mem_io_wb_en_r; // @[Top.scala 51:49]
  assign m_regfile_io_r1_addr = m_id_io_rs1_addr; // @[Top.scala 33:41]
  assign m_regfile_io_r2_addr = m_id_io_rs2_addr; // @[Top.scala 34:41]
endmodule
