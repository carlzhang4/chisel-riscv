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
  output [4:0]  io_rs1,
  output [4:0]  io_rs2,
  input  [63:0] io_rs1_data,
  input  [63:0] io_rs2_data,
  output [63:0] io_op1,
  output [63:0] io_op2,
  output [63:0] io_imm,
  output [4:0]  io_rd,
  output [2:0]  io_fu_type,
  output [6:0]  io_fu_op_type
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  wire [31:0] _decode_list_T = io_inst & 32'h7f; // @[Lookup.scala 31:38]
  wire  _decode_list_T_1 = 32'h37 == _decode_list_T; // @[Lookup.scala 31:38]
  wire  _decode_list_T_3 = 32'h17 == _decode_list_T; // @[Lookup.scala 31:38]
  wire  _decode_list_T_5 = 32'h6f == _decode_list_T; // @[Lookup.scala 31:38]
  wire [31:0] _decode_list_T_6 = io_inst & 32'h707f; // @[Lookup.scala 31:38]
  wire  _decode_list_T_7 = 32'h67 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_9 = 32'h63 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_11 = 32'h1063 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_13 = 32'h4063 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_15 = 32'h5063 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_17 = 32'h6063 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_19 = 32'h7063 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_21 = 32'h3 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_23 = 32'h1003 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_25 = 32'h2003 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_27 = 32'h4003 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_29 = 32'h5003 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_31 = 32'h23 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_33 = 32'h1023 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_35 = 32'h2023 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_37 = 32'h13 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_39 = 32'h2013 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_41 = 32'h3013 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_43 = 32'h4013 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_45 = 32'h6013 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_47 = 32'h7013 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire [31:0] _decode_list_T_48 = io_inst & 32'hfe00707f; // @[Lookup.scala 31:38]
  wire  _decode_list_T_49 = 32'h1013 == _decode_list_T_48; // @[Lookup.scala 31:38]
  wire  _decode_list_T_51 = 32'h5013 == _decode_list_T_48; // @[Lookup.scala 31:38]
  wire  _decode_list_T_53 = 32'h40005013 == _decode_list_T_48; // @[Lookup.scala 31:38]
  wire  _decode_list_T_55 = 32'h33 == _decode_list_T_48; // @[Lookup.scala 31:38]
  wire  _decode_list_T_57 = 32'h40000033 == _decode_list_T_48; // @[Lookup.scala 31:38]
  wire  _decode_list_T_59 = 32'h1033 == _decode_list_T_48; // @[Lookup.scala 31:38]
  wire  _decode_list_T_61 = 32'h2033 == _decode_list_T_48; // @[Lookup.scala 31:38]
  wire  _decode_list_T_63 = 32'h3033 == _decode_list_T_48; // @[Lookup.scala 31:38]
  wire  _decode_list_T_65 = 32'h4033 == _decode_list_T_48; // @[Lookup.scala 31:38]
  wire  _decode_list_T_67 = 32'h5033 == _decode_list_T_48; // @[Lookup.scala 31:38]
  wire  _decode_list_T_69 = 32'h40005033 == _decode_list_T_48; // @[Lookup.scala 31:38]
  wire  _decode_list_T_71 = 32'h6033 == _decode_list_T_48; // @[Lookup.scala 31:38]
  wire  _decode_list_T_73 = 32'h7033 == _decode_list_T_48; // @[Lookup.scala 31:38]
  wire [1:0] _decode_list_T_84 = _decode_list_T_53 ? 2'h1 : 2'h2; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_85 = _decode_list_T_51 ? 2'h1 : _decode_list_T_84; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_86 = _decode_list_T_49 ? 2'h1 : _decode_list_T_85; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_87 = _decode_list_T_47 ? 2'h1 : _decode_list_T_86; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_88 = _decode_list_T_45 ? 2'h1 : _decode_list_T_87; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_89 = _decode_list_T_43 ? 2'h1 : _decode_list_T_88; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_90 = _decode_list_T_41 ? 2'h1 : _decode_list_T_89; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_91 = _decode_list_T_39 ? 2'h1 : _decode_list_T_90; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_92 = _decode_list_T_37 ? 2'h1 : _decode_list_T_91; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_93 = _decode_list_T_35 ? 2'h3 : _decode_list_T_92; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_94 = _decode_list_T_33 ? 2'h3 : _decode_list_T_93; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_95 = _decode_list_T_31 ? 2'h3 : _decode_list_T_94; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_96 = _decode_list_T_29 ? 2'h1 : _decode_list_T_95; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_97 = _decode_list_T_27 ? 2'h1 : _decode_list_T_96; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_98 = _decode_list_T_25 ? 2'h1 : _decode_list_T_97; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_99 = _decode_list_T_23 ? 2'h1 : _decode_list_T_98; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_100 = _decode_list_T_21 ? 2'h1 : _decode_list_T_99; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_101 = _decode_list_T_19 ? 3'h4 : {{1'd0}, _decode_list_T_100}; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_102 = _decode_list_T_17 ? 3'h4 : _decode_list_T_101; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_103 = _decode_list_T_15 ? 3'h4 : _decode_list_T_102; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_104 = _decode_list_T_13 ? 3'h4 : _decode_list_T_103; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_105 = _decode_list_T_11 ? 3'h4 : _decode_list_T_104; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_106 = _decode_list_T_9 ? 3'h4 : _decode_list_T_105; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_107 = _decode_list_T_7 ? 3'h1 : _decode_list_T_106; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_108 = _decode_list_T_5 ? 3'h6 : _decode_list_T_107; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_109 = _decode_list_T_3 ? 3'h5 : _decode_list_T_108; // @[Lookup.scala 33:37]
  wire [2:0] decode_list_0 = _decode_list_T_1 ? 3'h5 : _decode_list_T_109; // @[Lookup.scala 33:37]
  wire  _decode_list_T_136 = _decode_list_T_21 | (_decode_list_T_23 | (_decode_list_T_25 | (_decode_list_T_27 | (
    _decode_list_T_29 | (_decode_list_T_31 | (_decode_list_T_33 | _decode_list_T_35)))))); // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_137 = _decode_list_T_19 ? 3'h5 : {{2'd0}, _decode_list_T_136}; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_138 = _decode_list_T_17 ? 3'h5 : _decode_list_T_137; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_139 = _decode_list_T_15 ? 3'h5 : _decode_list_T_138; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_140 = _decode_list_T_13 ? 3'h5 : _decode_list_T_139; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_141 = _decode_list_T_11 ? 3'h5 : _decode_list_T_140; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_142 = _decode_list_T_9 ? 3'h5 : _decode_list_T_141; // @[Lookup.scala 33:37]
  wire [3:0] _decode_list_T_146 = _decode_list_T_73 ? 4'h7 : 4'h8; // @[Lookup.scala 33:37]
  wire [3:0] _decode_list_T_147 = _decode_list_T_71 ? 4'h6 : _decode_list_T_146; // @[Lookup.scala 33:37]
  wire [3:0] _decode_list_T_148 = _decode_list_T_69 ? 4'hd : _decode_list_T_147; // @[Lookup.scala 33:37]
  wire [3:0] _decode_list_T_149 = _decode_list_T_67 ? 4'h5 : _decode_list_T_148; // @[Lookup.scala 33:37]
  wire [3:0] _decode_list_T_150 = _decode_list_T_65 ? 4'h4 : _decode_list_T_149; // @[Lookup.scala 33:37]
  wire [3:0] _decode_list_T_151 = _decode_list_T_63 ? 4'h3 : _decode_list_T_150; // @[Lookup.scala 33:37]
  wire [3:0] _decode_list_T_152 = _decode_list_T_61 ? 4'h2 : _decode_list_T_151; // @[Lookup.scala 33:37]
  wire [3:0] _decode_list_T_153 = _decode_list_T_59 ? 4'h1 : _decode_list_T_152; // @[Lookup.scala 33:37]
  wire [3:0] _decode_list_T_154 = _decode_list_T_57 ? 4'h8 : _decode_list_T_153; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_155 = _decode_list_T_55 ? 7'h40 : {{3'd0}, _decode_list_T_154}; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_156 = _decode_list_T_53 ? 7'hd : _decode_list_T_155; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_157 = _decode_list_T_51 ? 7'h5 : _decode_list_T_156; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_158 = _decode_list_T_49 ? 7'h1 : _decode_list_T_157; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_159 = _decode_list_T_47 ? 7'h7 : _decode_list_T_158; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_160 = _decode_list_T_45 ? 7'h6 : _decode_list_T_159; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_161 = _decode_list_T_43 ? 7'h4 : _decode_list_T_160; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_162 = _decode_list_T_41 ? 7'h3 : _decode_list_T_161; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_163 = _decode_list_T_39 ? 7'h2 : _decode_list_T_162; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_164 = _decode_list_T_37 ? 7'h40 : _decode_list_T_163; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_165 = _decode_list_T_35 ? 7'h27 : _decode_list_T_164; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_166 = _decode_list_T_33 ? 7'h26 : _decode_list_T_165; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_167 = _decode_list_T_31 ? 7'h25 : _decode_list_T_166; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_168 = _decode_list_T_29 ? 7'h24 : _decode_list_T_167; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_169 = _decode_list_T_27 ? 7'h23 : _decode_list_T_168; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_170 = _decode_list_T_25 ? 7'h22 : _decode_list_T_169; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_171 = _decode_list_T_23 ? 7'h21 : _decode_list_T_170; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_172 = _decode_list_T_21 ? 7'h20 : _decode_list_T_171; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_173 = _decode_list_T_19 ? 7'h17 : _decode_list_T_172; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_174 = _decode_list_T_17 ? 7'h16 : _decode_list_T_173; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_175 = _decode_list_T_15 ? 7'h15 : _decode_list_T_174; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_176 = _decode_list_T_13 ? 7'h14 : _decode_list_T_175; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_177 = _decode_list_T_11 ? 7'h11 : _decode_list_T_176; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_178 = _decode_list_T_9 ? 7'h10 : _decode_list_T_177; // @[Lookup.scala 33:37]
  wire  _src1_type_T = 3'h1 == decode_list_0; // @[Id_stage.scala 9:34]
  wire  _src1_type_T_2 = 3'h3 == decode_list_0; // @[Id_stage.scala 9:34]
  wire  _src1_type_T_3 = 3'h4 == decode_list_0; // @[Id_stage.scala 9:34]
  wire  _src1_type_T_4 = 3'h5 == decode_list_0; // @[Id_stage.scala 9:34]
  wire  _src1_type_T_5 = 3'h6 == decode_list_0; // @[Id_stage.scala 9:34]
  wire  src1_type = _src1_type_T_4 | _src1_type_T_5; // @[Mux.scala 27:72]
  wire  src2_type = _src1_type_T | _src1_type_T_4 | _src1_type_T_5; // @[Mux.scala 27:72]
  wire [11:0] imm_lo = io_inst[31:20]; // @[Id_stage.scala 52:53]
  wire  imm_signBit = imm_lo[11]; // @[BitUtil.scala 9:20]
  wire [51:0] imm_hi = imm_signBit ? 52'hfffffffffffff : 52'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _imm_T_1 = {imm_hi,imm_lo}; // @[Cat.scala 30:58]
  wire [6:0] imm_hi_1 = io_inst[31:25]; // @[Id_stage.scala 53:53]
  wire [4:0] imm_lo_1 = io_inst[11:7]; // @[Id_stage.scala 53:68]
  wire [11:0] imm_lo_2 = {imm_hi_1,imm_lo_1}; // @[Cat.scala 30:58]
  wire  imm_signBit_1 = imm_lo_2[11]; // @[BitUtil.scala 9:20]
  wire [51:0] imm_hi_2 = imm_signBit_1 ? 52'hfffffffffffff : 52'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _imm_T_3 = {imm_hi_2,imm_hi_1,imm_lo_1}; // @[Cat.scala 30:58]
  wire  imm_hi_hi_hi = io_inst[31]; // @[Id_stage.scala 54:53]
  wire  imm_hi_hi_lo = io_inst[7]; // @[Id_stage.scala 54:65]
  wire [5:0] imm_hi_lo = io_inst[30:25]; // @[Id_stage.scala 54:76]
  wire [3:0] imm_lo_hi = io_inst[11:8]; // @[Id_stage.scala 54:91]
  wire [12:0] imm_lo_4 = {imm_hi_hi_hi,imm_hi_hi_lo,imm_hi_lo,imm_lo_hi,1'h0}; // @[Cat.scala 30:58]
  wire  imm_signBit_2 = imm_lo_4[12]; // @[BitUtil.scala 9:20]
  wire [50:0] imm_hi_4 = imm_signBit_2 ? 51'h7ffffffffffff : 51'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _imm_T_5 = {imm_hi_4,imm_hi_hi_hi,imm_hi_hi_lo,imm_hi_lo,imm_lo_hi,1'h0}; // @[Cat.scala 30:58]
  wire [19:0] imm_hi_5 = io_inst[31:12]; // @[Id_stage.scala 55:53]
  wire [31:0] imm_lo_5 = {imm_hi_5,12'h0}; // @[Cat.scala 30:58]
  wire  imm_signBit_3 = imm_lo_5[31]; // @[BitUtil.scala 9:20]
  wire [31:0] imm_hi_6 = imm_signBit_3 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _imm_T_7 = {imm_hi_6,imm_hi_5,12'h0}; // @[Cat.scala 30:58]
  wire [7:0] imm_hi_hi_lo_1 = io_inst[19:12]; // @[Id_stage.scala 56:65]
  wire  imm_hi_lo_1 = io_inst[20]; // @[Id_stage.scala 56:80]
  wire [9:0] imm_lo_hi_1 = io_inst[30:21]; // @[Id_stage.scala 56:92]
  wire [20:0] imm_lo_7 = {imm_hi_hi_hi,imm_hi_hi_lo_1,imm_hi_lo_1,imm_lo_hi_1,1'h0}; // @[Cat.scala 30:58]
  wire  imm_signBit_4 = imm_lo_7[20]; // @[BitUtil.scala 9:20]
  wire [42:0] imm_hi_8 = imm_signBit_4 ? 43'h7ffffffffff : 43'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _imm_T_9 = {imm_hi_8,imm_hi_hi_hi,imm_hi_hi_lo_1,imm_hi_lo_1,imm_lo_hi_1,1'h0}; // @[Cat.scala 30:58]
  wire [63:0] _imm_T_15 = _src1_type_T ? _imm_T_1 : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _imm_T_16 = _src1_type_T_2 ? _imm_T_3 : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _imm_T_17 = _src1_type_T_3 ? _imm_T_5 : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _imm_T_18 = _src1_type_T_4 ? _imm_T_7 : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _imm_T_19 = _src1_type_T_5 ? _imm_T_9 : 64'h0; // @[Mux.scala 27:72]
  wire [63:0] _imm_T_20 = _imm_T_15 | _imm_T_16; // @[Mux.scala 27:72]
  wire [63:0] _imm_T_21 = _imm_T_20 | _imm_T_17; // @[Mux.scala 27:72]
  wire [63:0] _imm_T_22 = _imm_T_21 | _imm_T_18; // @[Mux.scala 27:72]
  wire [63:0] imm = _imm_T_22 | _imm_T_19; // @[Mux.scala 27:72]
  wire  _io_rs2_T = ~src2_type; // @[Id_stage.scala 61:56]
  reg [63:0] io_op1_REG; // @[Id_stage.scala 62:48]
  reg [63:0] io_op2_REG; // @[Id_stage.scala 63:48]
  reg [63:0] io_imm_REG; // @[Id_stage.scala 64:48]
  reg [6:0] io_fu_op_type_REG; // @[Id_stage.scala 65:40]
  reg [2:0] io_fu_type_REG; // @[Id_stage.scala 66:48]
  reg [4:0] io_rd_REG; // @[Id_stage.scala 67:48]
  assign io_rs1 = src1_type ? 5'h0 : io_inst[19:15]; // @[Id_stage.scala 60:45]
  assign io_rs2 = ~src2_type ? io_inst[24:20] : 5'h0; // @[Id_stage.scala 61:45]
  assign io_op1 = io_op1_REG; // @[Id_stage.scala 62:33]
  assign io_op2 = io_op2_REG; // @[Id_stage.scala 63:33]
  assign io_imm = io_imm_REG; // @[Id_stage.scala 64:33]
  assign io_rd = io_rd_REG; // @[Id_stage.scala 67:33]
  assign io_fu_type = io_fu_type_REG; // @[Id_stage.scala 66:33]
  assign io_fu_op_type = io_fu_op_type_REG; // @[Id_stage.scala 65:25]
  always @(posedge clock) begin
    io_op1_REG <= io_rs1_data; // @[Id_stage.scala 62:48]
    if (_io_rs2_T) begin // @[Id_stage.scala 63:52]
      io_op2_REG <= io_rs2_data;
    end else begin
      io_op2_REG <= imm;
    end
    io_imm_REG <= _imm_T_22 | _imm_T_19; // @[Mux.scala 27:72]
    if (_decode_list_T_1) begin // @[Lookup.scala 33:37]
      io_fu_op_type_REG <= 7'h40;
    end else if (_decode_list_T_3) begin // @[Lookup.scala 33:37]
      io_fu_op_type_REG <= 7'h40;
    end else if (_decode_list_T_5) begin // @[Lookup.scala 33:37]
      io_fu_op_type_REG <= 7'h58;
    end else if (_decode_list_T_7) begin // @[Lookup.scala 33:37]
      io_fu_op_type_REG <= 7'h5a;
    end else begin
      io_fu_op_type_REG <= _decode_list_T_178;
    end
    if (_decode_list_T_1) begin // @[Lookup.scala 33:37]
      io_fu_type_REG <= 3'h0;
    end else if (_decode_list_T_3) begin // @[Lookup.scala 33:37]
      io_fu_type_REG <= 3'h0;
    end else if (_decode_list_T_5) begin // @[Lookup.scala 33:37]
      io_fu_type_REG <= 3'h5;
    end else if (_decode_list_T_7) begin // @[Lookup.scala 33:37]
      io_fu_type_REG <= 3'h5;
    end else begin
      io_fu_type_REG <= _decode_list_T_142;
    end
    io_rd_REG <= io_inst[11:7]; // @[Id_stage.scala 67:56]
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
  io_op1_REG = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  io_op2_REG = _RAND_1[63:0];
  _RAND_2 = {2{`RANDOM}};
  io_imm_REG = _RAND_2[63:0];
  _RAND_3 = {1{`RANDOM}};
  io_fu_op_type_REG = _RAND_3[6:0];
  _RAND_4 = {1{`RANDOM}};
  io_fu_type_REG = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  io_rd_REG = _RAND_5[4:0];
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
  input  [63:0] io_imm,
  input  [4:0]  io_rd,
  input  [2:0]  io_fu_type,
  input  [6:0]  io_fu_op_type,
  output [2:0]  io_fu_type_o,
  output [6:0]  io_fu_op_type_o,
  output [63:0] io_op1_o,
  output [63:0] io_op2_o,
  output [63:0] io_imm_o,
  output [4:0]  io_wb_addr,
  output        io_wb_en,
  output [63:0] io_wb_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [95:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [63:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  wire [5:0] shamt = io_op2[5:0]; // @[Exe_stage.scala 40:27]
  wire  is_adder_sub = ~io_fu_op_type[6]; // @[Exe_stage.scala 42:28]
  wire [63:0] _adder_res_T_1 = is_adder_sub ? 64'hffffffffffffffff : 64'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _adder_res_T_2 = io_op2 ^ _adder_res_T_1; // @[Exe_stage.scala 43:44]
  wire [64:0] _adder_res_T_3 = io_op1 + _adder_res_T_2; // @[Exe_stage.scala 43:33]
  wire [64:0] _GEN_0 = {{64'd0}, is_adder_sub}; // @[Exe_stage.scala 43:72]
  wire [64:0] adder_res = _adder_res_T_3 + _GEN_0; // @[Exe_stage.scala 43:72]
  wire [63:0] xor_res = io_op1 ^ io_op2; // @[Exe_stage.scala 44:31]
  wire  sltu_res = ~adder_res[64]; // @[Exe_stage.scala 46:24]
  wire  slt_res = xor_res[63] ^ sltu_res; // @[Exe_stage.scala 47:39]
  wire [126:0] _GEN_1 = {{63'd0}, io_op1}; // @[Exe_stage.scala 50:57]
  wire [126:0] _wb_data_T = _GEN_1 << shamt; // @[Exe_stage.scala 50:57]
  wire [63:0] _wb_data_T_2 = io_op1 >> shamt; // @[Exe_stage.scala 51:57]
  wire [63:0] _wb_data_T_5 = $signed(io_op1) >>> shamt; // @[Exe_stage.scala 52:74]
  wire [63:0] _wb_data_T_6 = io_op1 | io_op2; // @[Exe_stage.scala 54:57]
  wire [63:0] _wb_data_T_7 = io_op1 & io_op2; // @[Exe_stage.scala 55:57]
  wire [63:0] _wb_data_T_8 = {63'h0,slt_res}; // @[Cat.scala 30:58]
  wire [63:0] _wb_data_T_9 = {63'h0,sltu_res}; // @[Cat.scala 30:58]
  wire [64:0] _wb_data_T_11 = 7'h1 == io_fu_op_type ? {{1'd0}, _wb_data_T[63:0]} : adder_res; // @[Mux.scala 80:57]
  wire [64:0] _wb_data_T_13 = 7'h5 == io_fu_op_type ? {{1'd0}, _wb_data_T_2} : _wb_data_T_11; // @[Mux.scala 80:57]
  wire [64:0] _wb_data_T_15 = 7'hd == io_fu_op_type ? {{1'd0}, _wb_data_T_5} : _wb_data_T_13; // @[Mux.scala 80:57]
  wire [64:0] _wb_data_T_17 = 7'h6 == io_fu_op_type ? {{1'd0}, _wb_data_T_6} : _wb_data_T_15; // @[Mux.scala 80:57]
  reg  io_wb_en_REG; // @[Exe_stage.scala 63:56]
  reg [64:0] io_wb_data_REG; // @[Exe_stage.scala 64:56]
  reg [4:0] io_wb_addr_REG; // @[Exe_stage.scala 65:56]
  reg [6:0] io_fu_op_type_o_REG; // @[Exe_stage.scala 66:48]
  reg [2:0] io_fu_type_o_REG; // @[Exe_stage.scala 67:48]
  reg [63:0] io_op1_o_REG; // @[Exe_stage.scala 68:56]
  reg [63:0] io_op2_o_REG; // @[Exe_stage.scala 69:56]
  reg [63:0] io_imm_o_REG; // @[Exe_stage.scala 70:56]
  assign io_fu_type_o = io_fu_type_o_REG; // @[Exe_stage.scala 67:33]
  assign io_fu_op_type_o = io_fu_op_type_o_REG; // @[Exe_stage.scala 66:33]
  assign io_op1_o = io_op1_o_REG; // @[Exe_stage.scala 68:41]
  assign io_op2_o = io_op2_o_REG; // @[Exe_stage.scala 69:41]
  assign io_imm_o = io_imm_o_REG; // @[Exe_stage.scala 70:41]
  assign io_wb_addr = io_wb_addr_REG; // @[Exe_stage.scala 65:41]
  assign io_wb_en = io_wb_en_REG; // @[Exe_stage.scala 63:41]
  assign io_wb_data = io_wb_data_REG[63:0]; // @[Exe_stage.scala 64:41]
  always @(posedge clock) begin
    io_wb_en_REG <= 7'h8 == io_fu_op_type | (7'h3 == io_fu_op_type | (7'h2 == io_fu_op_type | (7'h4 == io_fu_op_type | (7'h7
       == io_fu_op_type | (7'h6 == io_fu_op_type | (7'hd == io_fu_op_type | (7'h5 == io_fu_op_type | (7'h1 ==
      io_fu_op_type | 7'h40 == io_fu_op_type)))))))); // @[Mux.scala 80:57]
    if (7'h3 == io_fu_op_type) begin // @[Mux.scala 80:57]
      io_wb_data_REG <= {{1'd0}, _wb_data_T_9};
    end else if (7'h2 == io_fu_op_type) begin // @[Mux.scala 80:57]
      io_wb_data_REG <= {{1'd0}, _wb_data_T_8};
    end else if (7'h4 == io_fu_op_type) begin // @[Mux.scala 80:57]
      io_wb_data_REG <= {{1'd0}, xor_res};
    end else if (7'h7 == io_fu_op_type) begin // @[Mux.scala 80:57]
      io_wb_data_REG <= {{1'd0}, _wb_data_T_7};
    end else begin
      io_wb_data_REG <= _wb_data_T_17;
    end
    io_wb_addr_REG <= io_rd; // @[Exe_stage.scala 65:56]
    io_fu_op_type_o_REG <= io_fu_op_type; // @[Exe_stage.scala 66:48]
    io_fu_type_o_REG <= io_fu_type; // @[Exe_stage.scala 67:48]
    io_op1_o_REG <= io_op1; // @[Exe_stage.scala 68:56]
    io_op2_o_REG <= io_op2; // @[Exe_stage.scala 69:56]
    io_imm_o_REG <= io_imm; // @[Exe_stage.scala 70:56]
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
  io_wb_en_REG = _RAND_0[0:0];
  _RAND_1 = {3{`RANDOM}};
  io_wb_data_REG = _RAND_1[64:0];
  _RAND_2 = {1{`RANDOM}};
  io_wb_addr_REG = _RAND_2[4:0];
  _RAND_3 = {1{`RANDOM}};
  io_fu_op_type_o_REG = _RAND_3[6:0];
  _RAND_4 = {1{`RANDOM}};
  io_fu_type_o_REG = _RAND_4[2:0];
  _RAND_5 = {2{`RANDOM}};
  io_op1_o_REG = _RAND_5[63:0];
  _RAND_6 = {2{`RANDOM}};
  io_op2_o_REG = _RAND_6[63:0];
  _RAND_7 = {2{`RANDOM}};
  io_imm_o_REG = _RAND_7[63:0];
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
  input  [63:0] io_op1,
  input  [63:0] io_op2,
  input  [63:0] io_imm,
  input  [2:0]  io_fu_type,
  input  [6:0]  io_fu_op_type,
  output [4:0]  io_wb_addr_r,
  output        io_wb_en_r,
  output [63:0] io_wb_data_r,
  output [63:0] io_mem_addr,
  output        io_mem_en,
  output        io_mem_wr_en,
  output [63:0] io_mem_data_s,
  input  [63:0] io_mem_data_l,
  input         io_mem_data_en
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire [63:0] load_addr = io_op1 + io_op2; // @[Mem_stage.scala 32:32]
  wire [63:0] _mem_addr_T_1 = io_op1 + io_imm; // @[Mem_stage.scala 41:57]
  wire [63:0] _mem_addr_T_7 = 7'h25 == io_fu_op_type ? _mem_addr_T_1 : load_addr; // @[Mux.scala 80:57]
  wire [63:0] _mem_addr_T_9 = 7'h26 == io_fu_op_type ? _mem_addr_T_1 : _mem_addr_T_7; // @[Mux.scala 80:57]
  wire [7:0] mem_data_s_lo = io_op2[7:0]; // @[Mem_stage.scala 57:63]
  wire [63:0] _mem_data_s_T = {56'h0,mem_data_s_lo}; // @[Cat.scala 30:58]
  wire [15:0] mem_data_s_lo_1 = io_op2[15:0]; // @[Mem_stage.scala 58:63]
  wire [63:0] _mem_data_s_T_1 = {48'h0,mem_data_s_lo_1}; // @[Cat.scala 30:58]
  wire [31:0] mem_data_s_lo_2 = io_op2[31:0]; // @[Mem_stage.scala 59:63]
  wire [63:0] _mem_data_s_T_2 = {32'h0,mem_data_s_lo_2}; // @[Cat.scala 30:58]
  wire [63:0] _mem_data_s_T_4 = 7'h25 == io_fu_op_type ? _mem_data_s_T : 64'h0; // @[Mux.scala 80:57]
  wire [63:0] _mem_data_s_T_6 = 7'h26 == io_fu_op_type ? _mem_data_s_T_1 : _mem_data_s_T_4; // @[Mux.scala 80:57]
  reg [63:0] wb_data_r_REG; // @[Mem_stage.scala 62:64]
  wire [7:0] wb_data_r_lo = io_mem_data_l[7:0]; // @[Mem_stage.scala 63:79]
  wire  wb_data_r_signBit = wb_data_r_lo[7]; // @[BitUtil.scala 9:20]
  wire [55:0] wb_data_r_hi = wb_data_r_signBit ? 56'hffffffffffffff : 56'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _wb_data_r_T_1 = {wb_data_r_hi,wb_data_r_lo}; // @[Cat.scala 30:58]
  wire [15:0] wb_data_r_lo_1 = io_mem_data_l[15:0]; // @[Mem_stage.scala 64:71]
  wire  wb_data_r_signBit_1 = wb_data_r_lo_1[15]; // @[BitUtil.scala 9:20]
  wire [47:0] wb_data_r_hi_1 = wb_data_r_signBit_1 ? 48'hffffffffffff : 48'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _wb_data_r_T_3 = {wb_data_r_hi_1,wb_data_r_lo_1}; // @[Cat.scala 30:58]
  wire [31:0] wb_data_r_lo_2 = io_mem_data_l[31:0]; // @[Mem_stage.scala 65:71]
  wire  wb_data_r_signBit_2 = wb_data_r_lo_2[31]; // @[BitUtil.scala 9:20]
  wire [31:0] wb_data_r_hi_2 = wb_data_r_signBit_2 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _wb_data_r_T_5 = {wb_data_r_hi_2,wb_data_r_lo_2}; // @[Cat.scala 30:58]
  wire [63:0] _wb_data_r_T_6 = {56'h0,wb_data_r_lo}; // @[Cat.scala 30:58]
  wire [63:0] _wb_data_r_T_7 = {48'h0,wb_data_r_lo_1}; // @[Cat.scala 30:58]
  wire [63:0] _wb_data_r_T_9 = 7'h20 == io_fu_op_type ? _wb_data_r_T_1 : wb_data_r_REG; // @[Mux.scala 80:57]
  wire [63:0] _wb_data_r_T_11 = 7'h21 == io_fu_op_type ? _wb_data_r_T_3 : _wb_data_r_T_9; // @[Mux.scala 80:57]
  wire [63:0] _wb_data_r_T_13 = 7'h22 == io_fu_op_type ? _wb_data_r_T_5 : _wb_data_r_T_11; // @[Mux.scala 80:57]
  wire [63:0] _wb_data_r_T_15 = 7'h23 == io_fu_op_type ? _wb_data_r_T_6 : _wb_data_r_T_13; // @[Mux.scala 80:57]
  reg [4:0] io_wb_addr_r_REG; // @[Mem_stage.scala 74:40]
  reg  io_wb_en_r_REG; // @[Mem_stage.scala 75:48]
  assign io_wb_addr_r = io_wb_addr_r_REG; // @[Mem_stage.scala 74:25]
  assign io_wb_en_r = io_wb_en_r_REG; // @[Mem_stage.scala 75:33]
  assign io_wb_data_r = 7'h24 == io_fu_op_type ? _wb_data_r_T_7 : _wb_data_r_T_15; // @[Mux.scala 80:57]
  assign io_mem_addr = 7'h27 == io_fu_op_type ? _mem_addr_T_1 : _mem_addr_T_9; // @[Mux.scala 80:57]
  assign io_mem_en = 3'h1 == io_fu_type; // @[Mux.scala 80:60]
  assign io_mem_wr_en = 7'h27 == io_fu_op_type | (7'h26 == io_fu_op_type | 7'h25 == io_fu_op_type); // @[Mux.scala 80:57]
  assign io_mem_data_s = 7'h27 == io_fu_op_type ? _mem_data_s_T_2 : _mem_data_s_T_6; // @[Mux.scala 80:57]
  always @(posedge clock) begin
    wb_data_r_REG <= io_wb_data; // @[Mem_stage.scala 62:64]
    io_wb_addr_r_REG <= io_wb_addr; // @[Mem_stage.scala 74:40]
    io_wb_en_r_REG <= io_wb_en | io_mem_data_en; // @[Mem_stage.scala 75:58]
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
  wb_data_r_REG = _RAND_0[63:0];
  _RAND_1 = {1{`RANDOM}};
  io_wb_addr_r_REG = _RAND_1[4:0];
  _RAND_2 = {1{`RANDOM}};
  io_wb_en_r_REG = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Mem_ram(
  input         clock,
  output        io_rd_valid,
  input  [63:0] io_addr,
  output [63:0] io_rd_data,
  input         io_mem_en,
  input         io_wr_en,
  input  [63:0] io_wr_data
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] mem [0:1023]; // @[Mem_ram.scala 17:30]
  wire [31:0] mem_io_rd_data_MPORT_data; // @[Mem_ram.scala 17:30]
  wire [9:0] mem_io_rd_data_MPORT_addr; // @[Mem_ram.scala 17:30]
  wire [31:0] mem_MPORT_data; // @[Mem_ram.scala 17:30]
  wire [9:0] mem_MPORT_addr; // @[Mem_ram.scala 17:30]
  wire  mem_MPORT_mask; // @[Mem_ram.scala 17:30]
  wire  mem_MPORT_en; // @[Mem_ram.scala 17:30]
  reg  mem_io_rd_data_MPORT_en_pipe_0;
  reg [9:0] mem_io_rd_data_MPORT_addr_pipe_0;
  reg  rd_valid; // @[Mem_ram.scala 19:30]
  reg  io_rd_valid_REG; // @[Mem_ram.scala 22:35]
  wire  _T = io_wr_en & io_mem_en; // @[Mem_ram.scala 23:23]
  wire [31:0] _GEN_3 = io_mem_en ? mem_io_rd_data_MPORT_data : 32'h0; // @[Mem_ram.scala 25:30 Mem_ram.scala 26:29 Mem_ram.scala 21:33]
  wire [31:0] _GEN_12 = io_wr_en & io_mem_en ? 32'h0 : _GEN_3; // @[Mem_ram.scala 23:35 Mem_ram.scala 21:33]
  assign mem_io_rd_data_MPORT_addr = mem_io_rd_data_MPORT_addr_pipe_0;
  assign mem_io_rd_data_MPORT_data = mem[mem_io_rd_data_MPORT_addr]; // @[Mem_ram.scala 17:30]
  assign mem_MPORT_data = io_wr_data[31:0];
  assign mem_MPORT_addr = io_addr[9:0];
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = io_wr_en & io_mem_en;
  assign io_rd_valid = io_rd_valid_REG; // @[Mem_ram.scala 22:25]
  assign io_rd_data = {{32'd0}, _GEN_12}; // @[Mem_ram.scala 23:35 Mem_ram.scala 21:33]
  always @(posedge clock) begin
    if(mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[Mem_ram.scala 17:30]
    end
    if (_T) begin
      mem_io_rd_data_MPORT_en_pipe_0 <= 1'h0;
    end else begin
      mem_io_rd_data_MPORT_en_pipe_0 <= io_mem_en;
    end
    if (_T ? 1'h0 : io_mem_en) begin
      mem_io_rd_data_MPORT_addr_pipe_0 <= io_addr[9:0];
    end
    if (!(io_wr_en & io_mem_en)) begin // @[Mem_ram.scala 23:35]
      rd_valid <= io_mem_en;
    end
    io_rd_valid_REG <= rd_valid; // @[Mem_ram.scala 22:35]
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
  mem_io_rd_data_MPORT_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_io_rd_data_MPORT_addr_pipe_0 = _RAND_2[9:0];
  _RAND_3 = {1{`RANDOM}};
  rd_valid = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  io_rd_valid_REG = _RAND_4[0:0];
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
  wire [4:0] m_id_io_rs1; // @[Top.scala 19:47]
  wire [4:0] m_id_io_rs2; // @[Top.scala 19:47]
  wire [63:0] m_id_io_rs1_data; // @[Top.scala 19:47]
  wire [63:0] m_id_io_rs2_data; // @[Top.scala 19:47]
  wire [63:0] m_id_io_op1; // @[Top.scala 19:47]
  wire [63:0] m_id_io_op2; // @[Top.scala 19:47]
  wire [63:0] m_id_io_imm; // @[Top.scala 19:47]
  wire [4:0] m_id_io_rd; // @[Top.scala 19:47]
  wire [2:0] m_id_io_fu_type; // @[Top.scala 19:47]
  wire [6:0] m_id_io_fu_op_type; // @[Top.scala 19:47]
  wire  m_exe_clock; // @[Top.scala 20:47]
  wire [63:0] m_exe_io_op1; // @[Top.scala 20:47]
  wire [63:0] m_exe_io_op2; // @[Top.scala 20:47]
  wire [63:0] m_exe_io_imm; // @[Top.scala 20:47]
  wire [4:0] m_exe_io_rd; // @[Top.scala 20:47]
  wire [2:0] m_exe_io_fu_type; // @[Top.scala 20:47]
  wire [6:0] m_exe_io_fu_op_type; // @[Top.scala 20:47]
  wire [2:0] m_exe_io_fu_type_o; // @[Top.scala 20:47]
  wire [6:0] m_exe_io_fu_op_type_o; // @[Top.scala 20:47]
  wire [63:0] m_exe_io_op1_o; // @[Top.scala 20:47]
  wire [63:0] m_exe_io_op2_o; // @[Top.scala 20:47]
  wire [63:0] m_exe_io_imm_o; // @[Top.scala 20:47]
  wire [4:0] m_exe_io_wb_addr; // @[Top.scala 20:47]
  wire  m_exe_io_wb_en; // @[Top.scala 20:47]
  wire [63:0] m_exe_io_wb_data; // @[Top.scala 20:47]
  wire  m_mem_clock; // @[Top.scala 21:47]
  wire [4:0] m_mem_io_wb_addr; // @[Top.scala 21:47]
  wire  m_mem_io_wb_en; // @[Top.scala 21:47]
  wire [63:0] m_mem_io_wb_data; // @[Top.scala 21:47]
  wire [63:0] m_mem_io_op1; // @[Top.scala 21:47]
  wire [63:0] m_mem_io_op2; // @[Top.scala 21:47]
  wire [63:0] m_mem_io_imm; // @[Top.scala 21:47]
  wire [2:0] m_mem_io_fu_type; // @[Top.scala 21:47]
  wire [6:0] m_mem_io_fu_op_type; // @[Top.scala 21:47]
  wire [4:0] m_mem_io_wb_addr_r; // @[Top.scala 21:47]
  wire  m_mem_io_wb_en_r; // @[Top.scala 21:47]
  wire [63:0] m_mem_io_wb_data_r; // @[Top.scala 21:47]
  wire [63:0] m_mem_io_mem_addr; // @[Top.scala 21:47]
  wire  m_mem_io_mem_en; // @[Top.scala 21:47]
  wire  m_mem_io_mem_wr_en; // @[Top.scala 21:47]
  wire [63:0] m_mem_io_mem_data_s; // @[Top.scala 21:47]
  wire [63:0] m_mem_io_mem_data_l; // @[Top.scala 21:47]
  wire  m_mem_io_mem_data_en; // @[Top.scala 21:47]
  wire  m_mem_ram_clock; // @[Top.scala 22:39]
  wire  m_mem_ram_io_rd_valid; // @[Top.scala 22:39]
  wire [63:0] m_mem_ram_io_addr; // @[Top.scala 22:39]
  wire [63:0] m_mem_ram_io_rd_data; // @[Top.scala 22:39]
  wire  m_mem_ram_io_mem_en; // @[Top.scala 22:39]
  wire  m_mem_ram_io_wr_en; // @[Top.scala 22:39]
  wire [63:0] m_mem_ram_io_wr_data; // @[Top.scala 22:39]
  wire  m_regfile_clock; // @[Top.scala 23:39]
  wire [4:0] m_regfile_io_w_addr; // @[Top.scala 23:39]
  wire [63:0] m_regfile_io_w_data; // @[Top.scala 23:39]
  wire  m_regfile_io_w_en; // @[Top.scala 23:39]
  wire [4:0] m_regfile_io_r1_addr; // @[Top.scala 23:39]
  wire [63:0] m_regfile_io_r1_data; // @[Top.scala 23:39]
  wire [4:0] m_regfile_io_r2_addr; // @[Top.scala 23:39]
  wire [63:0] m_regfile_io_r2_data; // @[Top.scala 23:39]
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
    .io_rs1(m_id_io_rs1),
    .io_rs2(m_id_io_rs2),
    .io_rs1_data(m_id_io_rs1_data),
    .io_rs2_data(m_id_io_rs2_data),
    .io_op1(m_id_io_op1),
    .io_op2(m_id_io_op2),
    .io_imm(m_id_io_imm),
    .io_rd(m_id_io_rd),
    .io_fu_type(m_id_io_fu_type),
    .io_fu_op_type(m_id_io_fu_op_type)
  );
  Exe m_exe ( // @[Top.scala 20:47]
    .clock(m_exe_clock),
    .io_op1(m_exe_io_op1),
    .io_op2(m_exe_io_op2),
    .io_imm(m_exe_io_imm),
    .io_rd(m_exe_io_rd),
    .io_fu_type(m_exe_io_fu_type),
    .io_fu_op_type(m_exe_io_fu_op_type),
    .io_fu_type_o(m_exe_io_fu_type_o),
    .io_fu_op_type_o(m_exe_io_fu_op_type_o),
    .io_op1_o(m_exe_io_op1_o),
    .io_op2_o(m_exe_io_op2_o),
    .io_imm_o(m_exe_io_imm_o),
    .io_wb_addr(m_exe_io_wb_addr),
    .io_wb_en(m_exe_io_wb_en),
    .io_wb_data(m_exe_io_wb_data)
  );
  MemStage m_mem ( // @[Top.scala 21:47]
    .clock(m_mem_clock),
    .io_wb_addr(m_mem_io_wb_addr),
    .io_wb_en(m_mem_io_wb_en),
    .io_wb_data(m_mem_io_wb_data),
    .io_op1(m_mem_io_op1),
    .io_op2(m_mem_io_op2),
    .io_imm(m_mem_io_imm),
    .io_fu_type(m_mem_io_fu_type),
    .io_fu_op_type(m_mem_io_fu_op_type),
    .io_wb_addr_r(m_mem_io_wb_addr_r),
    .io_wb_en_r(m_mem_io_wb_en_r),
    .io_wb_data_r(m_mem_io_wb_data_r),
    .io_mem_addr(m_mem_io_mem_addr),
    .io_mem_en(m_mem_io_mem_en),
    .io_mem_wr_en(m_mem_io_mem_wr_en),
    .io_mem_data_s(m_mem_io_mem_data_s),
    .io_mem_data_l(m_mem_io_mem_data_l),
    .io_mem_data_en(m_mem_io_mem_data_en)
  );
  Mem_ram m_mem_ram ( // @[Top.scala 22:39]
    .clock(m_mem_ram_clock),
    .io_rd_valid(m_mem_ram_io_rd_valid),
    .io_addr(m_mem_ram_io_addr),
    .io_rd_data(m_mem_ram_io_rd_data),
    .io_mem_en(m_mem_ram_io_mem_en),
    .io_wr_en(m_mem_ram_io_wr_en),
    .io_wr_data(m_mem_ram_io_wr_data)
  );
  Regfile m_regfile ( // @[Top.scala 23:39]
    .clock(m_regfile_clock),
    .io_w_addr(m_regfile_io_w_addr),
    .io_w_data(m_regfile_io_w_data),
    .io_w_en(m_regfile_io_w_en),
    .io_r1_addr(m_regfile_io_r1_addr),
    .io_r1_data(m_regfile_io_r1_data),
    .io_r2_addr(m_regfile_io_r2_addr),
    .io_r2_data(m_regfile_io_r2_data)
  );
  assign io_wb_data_r = m_mem_io_wb_data_r; // @[Top.scala 67:49]
  assign m_inst_ram_clock = clock;
  assign m_inst_ram_io_inst_addr = m_if_io_inst_addr[9:0]; // @[Top.scala 29:41]
  assign m_inst_ram_io_wr_en = io_wr_en; // @[Top.scala 25:49]
  assign m_inst_ram_io_wr_addr = io_wr_addr; // @[Top.scala 26:41]
  assign m_inst_ram_io_wr_data = io_wr_data; // @[Top.scala 27:41]
  assign m_if_clock = clock;
  assign m_if_io_start = io_start; // @[Top.scala 30:49]
  assign m_id_clock = clock;
  assign m_id_io_inst = m_inst_ram_io_inst; // @[Top.scala 32:49]
  assign m_id_io_rs1_data = m_regfile_io_r1_data; // @[Top.scala 37:49]
  assign m_id_io_rs2_data = m_regfile_io_r2_data; // @[Top.scala 38:49]
  assign m_exe_clock = clock;
  assign m_exe_io_op1 = m_id_io_op1; // @[Top.scala 40:49]
  assign m_exe_io_op2 = m_id_io_op2; // @[Top.scala 41:49]
  assign m_exe_io_imm = m_id_io_imm; // @[Top.scala 42:49]
  assign m_exe_io_rd = m_id_io_rd; // @[Top.scala 43:49]
  assign m_exe_io_fu_type = m_id_io_fu_type; // @[Top.scala 45:49]
  assign m_exe_io_fu_op_type = m_id_io_fu_op_type; // @[Top.scala 44:41]
  assign m_mem_clock = clock;
  assign m_mem_io_wb_addr = m_exe_io_wb_addr; // @[Top.scala 47:49]
  assign m_mem_io_wb_en = m_exe_io_wb_en; // @[Top.scala 48:49]
  assign m_mem_io_wb_data = m_exe_io_wb_data; // @[Top.scala 49:49]
  assign m_mem_io_op1 = m_exe_io_op1_o; // @[Top.scala 50:49]
  assign m_mem_io_op2 = m_exe_io_op2_o; // @[Top.scala 51:49]
  assign m_mem_io_imm = m_exe_io_imm_o; // @[Top.scala 52:49]
  assign m_mem_io_fu_type = m_exe_io_fu_type_o; // @[Top.scala 53:49]
  assign m_mem_io_fu_op_type = m_exe_io_fu_op_type_o; // @[Top.scala 54:49]
  assign m_mem_io_mem_data_l = m_mem_ram_io_rd_data; // @[Top.scala 60:49]
  assign m_mem_io_mem_data_en = m_mem_ram_io_rd_valid; // @[Top.scala 61:41]
  assign m_mem_ram_clock = clock;
  assign m_mem_ram_io_addr = m_mem_io_mem_addr; // @[Top.scala 56:49]
  assign m_mem_ram_io_mem_en = m_mem_io_mem_en; // @[Top.scala 57:49]
  assign m_mem_ram_io_wr_en = m_mem_io_mem_wr_en; // @[Top.scala 58:49]
  assign m_mem_ram_io_wr_data = m_mem_io_mem_data_s; // @[Top.scala 59:41]
  assign m_regfile_clock = clock;
  assign m_regfile_io_w_addr = m_mem_io_wb_addr_r; // @[Top.scala 63:49]
  assign m_regfile_io_w_data = m_mem_io_wb_data_r; // @[Top.scala 64:49]
  assign m_regfile_io_w_en = m_mem_io_wb_en_r; // @[Top.scala 65:49]
  assign m_regfile_io_r1_addr = m_id_io_rs1; // @[Top.scala 34:41]
  assign m_regfile_io_r2_addr = m_id_io_rs2; // @[Top.scala 35:41]
endmodule
