module If(
  input         clock,
  input         reset,
  output [63:0] io_pc_c,
  input  [63:0] io_inst,
  output [31:0] io_inst_o,
  output        io_inst_valid_o,
  output [63:0] io_pc_o,
  input  [1:0]  io_ctrl,
  input  [63:0] io_jmp_addr
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire [63:0] pc_start = 64'h80000000 - 64'h4; // @[If_stage.scala 20:45]
  reg [63:0] pc; // @[If_stage.scala 21:25]
  wire  word_select = io_pc_c[2]; // @[If_stage.scala 23:34]
  wire [31:0] inst = word_select ? io_inst[63:32] : io_inst[31:0]; // @[If_stage.scala 24:24]
  wire [31:0] _is_jal_T = inst & 32'h7f; // @[If_stage.scala 26:28]
  wire  is_jal = 32'h6f == _is_jal_T; // @[If_stage.scala 26:28]
  wire  jal_addr_hi_hi_hi = inst[31]; // @[If_stage.scala 27:41]
  wire [7:0] jal_addr_hi_hi_lo = inst[19:12]; // @[If_stage.scala 27:50]
  wire  jal_addr_hi_lo = inst[20]; // @[If_stage.scala 27:62]
  wire [9:0] jal_addr_lo_hi = inst[30:21]; // @[If_stage.scala 27:71]
  wire [20:0] jal_addr_lo_1 = {jal_addr_hi_hi_hi,jal_addr_hi_hi_lo,jal_addr_hi_lo,jal_addr_lo_hi,1'h0}; // @[Cat.scala 30:58]
  wire  jal_addr_signBit = jal_addr_lo_1[20]; // @[BitUtil.scala 9:20]
  wire [42:0] jal_addr_hi_1 = jal_addr_signBit ? 43'h7ffffffffff : 43'h0; // @[Bitwise.scala 72:12]
  wire [63:0] jal_addr = {jal_addr_hi_1,jal_addr_hi_hi_hi,jal_addr_hi_hi_lo,jal_addr_hi_lo,jal_addr_lo_hi,1'h0}; // @[Cat.scala 30:58]
  reg [31:0] pc_r; // @[If_stage.scala 29:56]
  reg [31:0] inst_r; // @[If_stage.scala 30:56]
  reg  inst_valid_r; // @[If_stage.scala 31:48]
  wire [63:0] _pc_next_T_1 = pc + jal_addr; // @[If_stage.scala 33:48]
  wire [63:0] _pc_next_T_3 = pc + 64'h4; // @[If_stage.scala 33:62]
  wire [63:0] _GEN_1 = io_ctrl == 2'h2 ? pc : {{32'd0}, pc_r}; // @[If_stage.scala 45:34 If_stage.scala 47:41 If_stage.scala 29:56]
  wire [63:0] _GEN_5 = io_ctrl == 2'h1 ? {{32'd0}, pc_r} : _GEN_1; // @[If_stage.scala 40:34 If_stage.scala 42:41]
  wire [63:0] _GEN_9 = io_ctrl == 2'h0 ? pc : _GEN_5; // @[If_stage.scala 34:28 If_stage.scala 36:41]
  assign io_pc_c = pc; // @[If_stage.scala 53:33]
  assign io_inst_o = inst_r; // @[If_stage.scala 57:33]
  assign io_inst_valid_o = inst_valid_r; // @[If_stage.scala 56:25]
  assign io_pc_o = {{32'd0}, pc_r}; // @[If_stage.scala 55:33]
  always @(posedge clock) begin
    if (reset) begin // @[If_stage.scala 21:25]
      pc <= pc_start; // @[If_stage.scala 21:25]
    end else if (io_ctrl == 2'h0) begin // @[If_stage.scala 34:28]
      if (is_jal) begin // @[If_stage.scala 33:36]
        pc <= _pc_next_T_1;
      end else begin
        pc <= _pc_next_T_3;
      end
    end else if (!(io_ctrl == 2'h1)) begin // @[If_stage.scala 40:34]
      if (io_ctrl == 2'h2) begin // @[If_stage.scala 45:34]
        pc <= io_jmp_addr; // @[If_stage.scala 46:49]
      end
    end
    if (reset) begin // @[If_stage.scala 29:56]
      pc_r <= 32'h0; // @[If_stage.scala 29:56]
    end else begin
      pc_r <= _GEN_9[31:0];
    end
    if (reset) begin // @[If_stage.scala 30:56]
      inst_r <= 32'h0; // @[If_stage.scala 30:56]
    end else if (io_ctrl == 2'h0) begin // @[If_stage.scala 34:28]
      inst_r <= inst; // @[If_stage.scala 37:41]
    end else if (!(io_ctrl == 2'h1)) begin // @[If_stage.scala 40:34]
      if (io_ctrl == 2'h2) begin // @[If_stage.scala 45:34]
        inst_r <= inst; // @[If_stage.scala 48:41]
      end
    end
    if (reset) begin // @[If_stage.scala 31:48]
      inst_valid_r <= 1'h0; // @[If_stage.scala 31:48]
    end else if (io_ctrl == 2'h0) begin // @[If_stage.scala 34:28]
      inst_valid_r <= pc >= 64'h80000000; // @[If_stage.scala 38:33]
    end else if (!(io_ctrl == 2'h1)) begin // @[If_stage.scala 40:34]
      if (io_ctrl == 2'h2) begin // @[If_stage.scala 45:34]
        inst_valid_r <= 1'h0; // @[If_stage.scala 49:33]
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
  pc = _RAND_0[63:0];
  _RAND_1 = {1{`RANDOM}};
  pc_r = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  inst_r = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  inst_valid_r = _RAND_3[0:0];
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
  input         reset,
  input  [31:0] io_inst,
  input         io_inst_valid,
  input  [63:0] io_pc,
  input  [1:0]  io_ctrl,
  output [4:0]  io_rs1_c,
  output [4:0]  io_rs2_c,
  output        io_rs1_en_c,
  output        io_rs2_en_c,
  input  [63:0] io_rs1_data,
  input  [63:0] io_rs2_data,
  output [4:0]  io_rs1_o,
  output [4:0]  io_rs2_o,
  output        io_rs1_en_o,
  output        io_rs2_en_o,
  output [63:0] io_op1_o,
  output [63:0] io_op2_o,
  output [63:0] io_imm_o,
  output [4:0]  io_wb_addr_o,
  output        io_wb_en_o,
  output [7:0]  io_fu_op_type_o,
  output [31:0] io_inst_o,
  output        io_inst_valid_o,
  output [63:0] io_pc_o,
  output [63:0] io_jmp_addr,
  output        jmp_0,
  input  [4:0]  exe_wb_addr_o,
  output        id_alu_conlict_0,
  output        id_load_conflict_0,
  input  [63:0] exe_wb_data_o,
  input         exe_wb_en_o,
  input         exe_inst_valid_o
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
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
  wire  _decode_list_T_27 = 32'h3003 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_29 = 32'h4003 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_31 = 32'h5003 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_33 = 32'h6003 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_35 = 32'h23 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_37 = 32'h1023 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_39 = 32'h2023 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_41 = 32'h3023 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_43 = 32'h13 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_45 = 32'h2013 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_47 = 32'h3013 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_49 = 32'h4013 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_51 = 32'h6013 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_53 = 32'h7013 == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire [31:0] _decode_list_T_54 = io_inst & 32'hfc00707f; // @[Lookup.scala 31:38]
  wire  _decode_list_T_55 = 32'h1013 == _decode_list_T_54; // @[Lookup.scala 31:38]
  wire  _decode_list_T_57 = 32'h5013 == _decode_list_T_54; // @[Lookup.scala 31:38]
  wire  _decode_list_T_59 = 32'h40005013 == _decode_list_T_54; // @[Lookup.scala 31:38]
  wire [31:0] _decode_list_T_60 = io_inst & 32'hfe00707f; // @[Lookup.scala 31:38]
  wire  _decode_list_T_61 = 32'h33 == _decode_list_T_60; // @[Lookup.scala 31:38]
  wire  _decode_list_T_63 = 32'h40000033 == _decode_list_T_60; // @[Lookup.scala 31:38]
  wire  _decode_list_T_65 = 32'h1033 == _decode_list_T_60; // @[Lookup.scala 31:38]
  wire  _decode_list_T_67 = 32'h2033 == _decode_list_T_60; // @[Lookup.scala 31:38]
  wire  _decode_list_T_69 = 32'h3033 == _decode_list_T_60; // @[Lookup.scala 31:38]
  wire  _decode_list_T_71 = 32'h4033 == _decode_list_T_60; // @[Lookup.scala 31:38]
  wire  _decode_list_T_73 = 32'h5033 == _decode_list_T_60; // @[Lookup.scala 31:38]
  wire  _decode_list_T_75 = 32'h40005033 == _decode_list_T_60; // @[Lookup.scala 31:38]
  wire  _decode_list_T_77 = 32'h6033 == _decode_list_T_60; // @[Lookup.scala 31:38]
  wire  _decode_list_T_79 = 32'h7033 == _decode_list_T_60; // @[Lookup.scala 31:38]
  wire  _decode_list_T_81 = 32'h1b == _decode_list_T_6; // @[Lookup.scala 31:38]
  wire  _decode_list_T_83 = 32'h101b == _decode_list_T_60; // @[Lookup.scala 31:38]
  wire  _decode_list_T_85 = 32'h501b == _decode_list_T_60; // @[Lookup.scala 31:38]
  wire  _decode_list_T_87 = 32'h4000501b == _decode_list_T_60; // @[Lookup.scala 31:38]
  wire  _decode_list_T_89 = 32'h103b == _decode_list_T_60; // @[Lookup.scala 31:38]
  wire  _decode_list_T_91 = 32'h503b == _decode_list_T_60; // @[Lookup.scala 31:38]
  wire  _decode_list_T_93 = 32'h4000503b == _decode_list_T_60; // @[Lookup.scala 31:38]
  wire  _decode_list_T_95 = 32'h3b == _decode_list_T_60; // @[Lookup.scala 31:38]
  wire  _decode_list_T_97 = 32'h4000003b == _decode_list_T_60; // @[Lookup.scala 31:38]
  wire [1:0] _decode_list_T_98 = _decode_list_T_97 ? 2'h2 : 2'h0; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_99 = _decode_list_T_95 ? 2'h2 : _decode_list_T_98; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_100 = _decode_list_T_93 ? 2'h2 : _decode_list_T_99; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_101 = _decode_list_T_91 ? 2'h2 : _decode_list_T_100; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_102 = _decode_list_T_89 ? 2'h2 : _decode_list_T_101; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_103 = _decode_list_T_87 ? 2'h1 : _decode_list_T_102; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_104 = _decode_list_T_85 ? 2'h1 : _decode_list_T_103; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_105 = _decode_list_T_83 ? 2'h1 : _decode_list_T_104; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_106 = _decode_list_T_81 ? 2'h1 : _decode_list_T_105; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_107 = _decode_list_T_79 ? 2'h2 : _decode_list_T_106; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_108 = _decode_list_T_77 ? 2'h2 : _decode_list_T_107; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_109 = _decode_list_T_75 ? 2'h2 : _decode_list_T_108; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_110 = _decode_list_T_73 ? 2'h2 : _decode_list_T_109; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_111 = _decode_list_T_71 ? 2'h2 : _decode_list_T_110; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_112 = _decode_list_T_69 ? 2'h2 : _decode_list_T_111; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_113 = _decode_list_T_67 ? 2'h2 : _decode_list_T_112; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_114 = _decode_list_T_65 ? 2'h2 : _decode_list_T_113; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_115 = _decode_list_T_63 ? 2'h2 : _decode_list_T_114; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_116 = _decode_list_T_61 ? 2'h2 : _decode_list_T_115; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_117 = _decode_list_T_59 ? 2'h1 : _decode_list_T_116; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_118 = _decode_list_T_57 ? 2'h1 : _decode_list_T_117; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_119 = _decode_list_T_55 ? 2'h1 : _decode_list_T_118; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_120 = _decode_list_T_53 ? 2'h1 : _decode_list_T_119; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_121 = _decode_list_T_51 ? 2'h1 : _decode_list_T_120; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_122 = _decode_list_T_49 ? 2'h1 : _decode_list_T_121; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_123 = _decode_list_T_47 ? 2'h1 : _decode_list_T_122; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_124 = _decode_list_T_45 ? 2'h1 : _decode_list_T_123; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_125 = _decode_list_T_43 ? 2'h1 : _decode_list_T_124; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_126 = _decode_list_T_41 ? 2'h3 : _decode_list_T_125; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_127 = _decode_list_T_39 ? 2'h3 : _decode_list_T_126; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_128 = _decode_list_T_37 ? 2'h3 : _decode_list_T_127; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_129 = _decode_list_T_35 ? 2'h3 : _decode_list_T_128; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_130 = _decode_list_T_33 ? 2'h1 : _decode_list_T_129; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_131 = _decode_list_T_31 ? 2'h1 : _decode_list_T_130; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_132 = _decode_list_T_29 ? 2'h1 : _decode_list_T_131; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_133 = _decode_list_T_27 ? 2'h1 : _decode_list_T_132; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_134 = _decode_list_T_25 ? 2'h1 : _decode_list_T_133; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_135 = _decode_list_T_23 ? 2'h1 : _decode_list_T_134; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_136 = _decode_list_T_21 ? 2'h1 : _decode_list_T_135; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_137 = _decode_list_T_19 ? 3'h4 : {{1'd0}, _decode_list_T_136}; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_138 = _decode_list_T_17 ? 3'h4 : _decode_list_T_137; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_139 = _decode_list_T_15 ? 3'h4 : _decode_list_T_138; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_140 = _decode_list_T_13 ? 3'h4 : _decode_list_T_139; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_141 = _decode_list_T_11 ? 3'h4 : _decode_list_T_140; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_142 = _decode_list_T_9 ? 3'h4 : _decode_list_T_141; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_143 = _decode_list_T_7 ? 3'h1 : _decode_list_T_142; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_144 = _decode_list_T_5 ? 3'h6 : _decode_list_T_143; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_145 = _decode_list_T_3 ? 3'h5 : _decode_list_T_144; // @[Lookup.scala 33:37]
  wire [2:0] decode_list_0 = _decode_list_T_1 ? 3'h5 : _decode_list_T_145; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_146 = _decode_list_T_97 ? 2'h0 : 2'h3; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_147 = _decode_list_T_95 ? 2'h0 : _decode_list_T_146; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_148 = _decode_list_T_93 ? 2'h0 : _decode_list_T_147; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_149 = _decode_list_T_91 ? 2'h0 : _decode_list_T_148; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_150 = _decode_list_T_89 ? 2'h0 : _decode_list_T_149; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_151 = _decode_list_T_87 ? 2'h0 : _decode_list_T_150; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_152 = _decode_list_T_85 ? 2'h0 : _decode_list_T_151; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_153 = _decode_list_T_83 ? 2'h0 : _decode_list_T_152; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_154 = _decode_list_T_81 ? 2'h0 : _decode_list_T_153; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_155 = _decode_list_T_79 ? 2'h0 : _decode_list_T_154; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_156 = _decode_list_T_77 ? 2'h0 : _decode_list_T_155; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_157 = _decode_list_T_75 ? 2'h0 : _decode_list_T_156; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_158 = _decode_list_T_73 ? 2'h0 : _decode_list_T_157; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_159 = _decode_list_T_71 ? 2'h0 : _decode_list_T_158; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_160 = _decode_list_T_69 ? 2'h0 : _decode_list_T_159; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_161 = _decode_list_T_67 ? 2'h0 : _decode_list_T_160; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_162 = _decode_list_T_65 ? 2'h0 : _decode_list_T_161; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_163 = _decode_list_T_63 ? 2'h0 : _decode_list_T_162; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_164 = _decode_list_T_61 ? 2'h0 : _decode_list_T_163; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_165 = _decode_list_T_59 ? 2'h0 : _decode_list_T_164; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_166 = _decode_list_T_57 ? 2'h0 : _decode_list_T_165; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_167 = _decode_list_T_55 ? 2'h0 : _decode_list_T_166; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_168 = _decode_list_T_53 ? 2'h0 : _decode_list_T_167; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_169 = _decode_list_T_51 ? 2'h0 : _decode_list_T_168; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_170 = _decode_list_T_49 ? 2'h0 : _decode_list_T_169; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_171 = _decode_list_T_47 ? 2'h0 : _decode_list_T_170; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_172 = _decode_list_T_45 ? 2'h0 : _decode_list_T_171; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_173 = _decode_list_T_43 ? 2'h0 : _decode_list_T_172; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_174 = _decode_list_T_41 ? 2'h1 : _decode_list_T_173; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_175 = _decode_list_T_39 ? 2'h1 : _decode_list_T_174; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_176 = _decode_list_T_37 ? 2'h1 : _decode_list_T_175; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_177 = _decode_list_T_35 ? 2'h1 : _decode_list_T_176; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_178 = _decode_list_T_33 ? 2'h1 : _decode_list_T_177; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_179 = _decode_list_T_31 ? 2'h1 : _decode_list_T_178; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_180 = _decode_list_T_29 ? 2'h1 : _decode_list_T_179; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_181 = _decode_list_T_27 ? 2'h1 : _decode_list_T_180; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_182 = _decode_list_T_25 ? 2'h1 : _decode_list_T_181; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_183 = _decode_list_T_23 ? 2'h1 : _decode_list_T_182; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_184 = _decode_list_T_21 ? 2'h1 : _decode_list_T_183; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_185 = _decode_list_T_19 ? 3'h5 : {{1'd0}, _decode_list_T_184}; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_186 = _decode_list_T_17 ? 3'h5 : _decode_list_T_185; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_187 = _decode_list_T_15 ? 3'h5 : _decode_list_T_186; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_188 = _decode_list_T_13 ? 3'h5 : _decode_list_T_187; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_189 = _decode_list_T_11 ? 3'h5 : _decode_list_T_188; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_190 = _decode_list_T_9 ? 3'h5 : _decode_list_T_189; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_191 = _decode_list_T_7 ? 3'h0 : _decode_list_T_190; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_192 = _decode_list_T_5 ? 3'h0 : _decode_list_T_191; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_193 = _decode_list_T_3 ? 3'h0 : _decode_list_T_192; // @[Lookup.scala 33:37]
  wire [2:0] decode_list_1 = _decode_list_T_1 ? 3'h0 : _decode_list_T_193; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_194 = _decode_list_T_97 ? 7'h61 : 7'h5f; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_195 = _decode_list_T_95 ? 8'he0 : {{1'd0}, _decode_list_T_194}; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_196 = _decode_list_T_93 ? 8'h64 : _decode_list_T_195; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_197 = _decode_list_T_91 ? 8'h63 : _decode_list_T_196; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_198 = _decode_list_T_89 ? 8'h62 : _decode_list_T_197; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_199 = _decode_list_T_87 ? 8'h64 : _decode_list_T_198; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_200 = _decode_list_T_85 ? 8'h63 : _decode_list_T_199; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_201 = _decode_list_T_83 ? 8'h62 : _decode_list_T_200; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_202 = _decode_list_T_81 ? 8'he0 : _decode_list_T_201; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_203 = _decode_list_T_79 ? 8'h7 : _decode_list_T_202; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_204 = _decode_list_T_77 ? 8'h6 : _decode_list_T_203; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_205 = _decode_list_T_75 ? 8'h9 : _decode_list_T_204; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_206 = _decode_list_T_73 ? 8'h5 : _decode_list_T_205; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_207 = _decode_list_T_71 ? 8'h4 : _decode_list_T_206; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_208 = _decode_list_T_69 ? 8'h3 : _decode_list_T_207; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_209 = _decode_list_T_67 ? 8'h2 : _decode_list_T_208; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_210 = _decode_list_T_65 ? 8'h1 : _decode_list_T_209; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_211 = _decode_list_T_63 ? 8'h8 : _decode_list_T_210; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_212 = _decode_list_T_61 ? 8'h80 : _decode_list_T_211; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_213 = _decode_list_T_59 ? 8'h9 : _decode_list_T_212; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_214 = _decode_list_T_57 ? 8'h5 : _decode_list_T_213; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_215 = _decode_list_T_55 ? 8'h1 : _decode_list_T_214; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_216 = _decode_list_T_53 ? 8'h7 : _decode_list_T_215; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_217 = _decode_list_T_51 ? 8'h6 : _decode_list_T_216; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_218 = _decode_list_T_49 ? 8'h4 : _decode_list_T_217; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_219 = _decode_list_T_47 ? 8'h3 : _decode_list_T_218; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_220 = _decode_list_T_45 ? 8'h2 : _decode_list_T_219; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_221 = _decode_list_T_43 ? 8'h80 : _decode_list_T_220; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_222 = _decode_list_T_41 ? 8'haa : _decode_list_T_221; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_223 = _decode_list_T_39 ? 8'ha9 : _decode_list_T_222; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_224 = _decode_list_T_37 ? 8'ha8 : _decode_list_T_223; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_225 = _decode_list_T_35 ? 8'ha7 : _decode_list_T_224; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_226 = _decode_list_T_33 ? 8'ha6 : _decode_list_T_225; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_227 = _decode_list_T_31 ? 8'ha5 : _decode_list_T_226; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_228 = _decode_list_T_29 ? 8'ha4 : _decode_list_T_227; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_229 = _decode_list_T_27 ? 8'ha3 : _decode_list_T_228; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_230 = _decode_list_T_25 ? 8'ha2 : _decode_list_T_229; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_231 = _decode_list_T_23 ? 8'ha1 : _decode_list_T_230; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_232 = _decode_list_T_21 ? 8'ha0 : _decode_list_T_231; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_233 = _decode_list_T_19 ? 8'h45 : _decode_list_T_232; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_234 = _decode_list_T_17 ? 8'h44 : _decode_list_T_233; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_235 = _decode_list_T_15 ? 8'h43 : _decode_list_T_234; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_236 = _decode_list_T_13 ? 8'h42 : _decode_list_T_235; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_237 = _decode_list_T_11 ? 8'h41 : _decode_list_T_236; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_238 = _decode_list_T_9 ? 8'h40 : _decode_list_T_237; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_239 = _decode_list_T_7 ? 8'hc1 : _decode_list_T_238; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_240 = _decode_list_T_5 ? 8'hc0 : _decode_list_T_239; // @[Lookup.scala 33:37]
  wire [7:0] _decode_list_T_241 = _decode_list_T_3 ? 8'h80 : _decode_list_T_240; // @[Lookup.scala 33:37]
  wire [7:0] decode_list_2 = _decode_list_T_1 ? 8'h1f : _decode_list_T_241; // @[Lookup.scala 33:37]
  wire  _src1_type_T = 3'h1 == decode_list_0; // @[Id_stage.scala 10:34]
  wire  _src1_type_T_2 = 3'h3 == decode_list_0; // @[Id_stage.scala 10:34]
  wire  _src1_type_T_3 = 3'h4 == decode_list_0; // @[Id_stage.scala 10:34]
  wire  _src1_type_T_4 = 3'h5 == decode_list_0; // @[Id_stage.scala 10:34]
  wire  _src1_type_T_5 = 3'h6 == decode_list_0; // @[Id_stage.scala 10:34]
  wire  src1_type = _src1_type_T_4 | _src1_type_T_5; // @[Mux.scala 27:72]
  wire  src2_type = _src1_type_T | _src1_type_T_4 | _src1_type_T_5; // @[Mux.scala 27:72]
  wire [11:0] imm_lo = io_inst[31:20]; // @[Id_stage.scala 73:53]
  wire  imm_signBit = imm_lo[11]; // @[BitUtil.scala 9:20]
  wire [51:0] imm_hi = imm_signBit ? 52'hfffffffffffff : 52'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _imm_T_1 = {imm_hi,imm_lo}; // @[Cat.scala 30:58]
  wire [6:0] imm_hi_1 = io_inst[31:25]; // @[Id_stage.scala 74:53]
  wire [4:0] imm_lo_1 = io_inst[11:7]; // @[Id_stage.scala 74:68]
  wire [11:0] imm_lo_2 = {imm_hi_1,imm_lo_1}; // @[Cat.scala 30:58]
  wire  imm_signBit_1 = imm_lo_2[11]; // @[BitUtil.scala 9:20]
  wire [51:0] imm_hi_2 = imm_signBit_1 ? 52'hfffffffffffff : 52'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _imm_T_3 = {imm_hi_2,imm_hi_1,imm_lo_1}; // @[Cat.scala 30:58]
  wire  imm_hi_hi_hi = io_inst[31]; // @[Id_stage.scala 75:53]
  wire  imm_hi_hi_lo = io_inst[7]; // @[Id_stage.scala 75:65]
  wire [5:0] imm_hi_lo = io_inst[30:25]; // @[Id_stage.scala 75:76]
  wire [3:0] imm_lo_hi = io_inst[11:8]; // @[Id_stage.scala 75:91]
  wire [12:0] imm_lo_4 = {imm_hi_hi_hi,imm_hi_hi_lo,imm_hi_lo,imm_lo_hi,1'h0}; // @[Cat.scala 30:58]
  wire  imm_signBit_2 = imm_lo_4[12]; // @[BitUtil.scala 9:20]
  wire [50:0] imm_hi_4 = imm_signBit_2 ? 51'h7ffffffffffff : 51'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _imm_T_5 = {imm_hi_4,imm_hi_hi_hi,imm_hi_hi_lo,imm_hi_lo,imm_lo_hi,1'h0}; // @[Cat.scala 30:58]
  wire [19:0] imm_hi_5 = io_inst[31:12]; // @[Id_stage.scala 76:53]
  wire [31:0] imm_lo_5 = {imm_hi_5,12'h0}; // @[Cat.scala 30:58]
  wire  imm_signBit_3 = imm_lo_5[31]; // @[BitUtil.scala 9:20]
  wire [31:0] imm_hi_6 = imm_signBit_3 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _imm_T_7 = {imm_hi_6,imm_hi_5,12'h0}; // @[Cat.scala 30:58]
  wire [7:0] imm_hi_hi_lo_1 = io_inst[19:12]; // @[Id_stage.scala 77:65]
  wire  imm_hi_lo_1 = io_inst[20]; // @[Id_stage.scala 77:80]
  wire [9:0] imm_lo_hi_1 = io_inst[30:21]; // @[Id_stage.scala 77:92]
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
  wire  is_jalr = io_inst_valid & _decode_list_T_7; // @[Id_stage.scala 79:55]
  wire  is_branch = io_inst_valid & decode_list_1 == 3'h5; // @[Id_stage.scala 80:47]
  wire  rs1_harzard_1 = io_rs1_en_c & io_wb_addr_o == io_rs1_c; // @[Id_stage.scala 82:42]
  wire  rs2_harzard_1 = io_rs2_en_c & io_wb_addr_o == io_rs2_c; // @[Id_stage.scala 83:42]
  wire  j_alu_conflict = is_jalr & io_wb_en_o & io_inst_valid_o & rs1_harzard_1; // @[Id_stage.scala 85:71]
  wire  b_alu_conflict = is_branch & io_wb_en_o & io_inst_valid_o & (rs1_harzard_1 | rs2_harzard_1); // @[Id_stage.scala 86:84]
  wire  id_alu_conlict = j_alu_conflict | b_alu_conflict; // @[Id_stage.scala 87:45]
  wire  rs1_harzard_2 = exe_inst_valid_o & io_rs1_en_c & exe_wb_en_o & exe_wb_addr_o == io_rs1_c; // @[Id_stage.scala 106:94]
  wire  rs2_harzard_2 = exe_inst_valid_o & io_rs2_en_c & exe_wb_en_o & exe_wb_addr_o == io_rs2_c; // @[Id_stage.scala 107:94]
  wire [63:0] _jmp_addr_T = rs1_harzard_2 ? exe_wb_data_o : io_rs1_data; // @[Id_stage.scala 109:55]
  wire [63:0] _jmp_addr_T_1 = is_jalr ? _jmp_addr_T : io_pc; // @[Id_stage.scala 109:42]
  wire  j_load_conflict = is_jalr & rs1_harzard_2; // @[Id_stage.scala 111:39]
  wire  b_load_conflict = is_branch & (rs1_harzard_2 | rs2_harzard_2); // @[Id_stage.scala 112:41]
  wire  id_load_conflict = j_load_conflict | b_load_conflict; // @[Id_stage.scala 113:48]
  wire [63:0] cmp2 = rs2_harzard_2 ? exe_wb_data_o : io_rs2_data; // @[Id_stage.scala 118:36]
  wire  beq = _jmp_addr_T == cmp2; // @[Id_stage.scala 120:37]
  wire  bne = _jmp_addr_T != cmp2; // @[Id_stage.scala 121:37]
  wire [63:0] _blt_T = rs1_harzard_2 ? exe_wb_data_o : io_rs1_data; // @[Id_stage.scala 122:38]
  wire [63:0] _blt_T_1 = rs2_harzard_2 ? exe_wb_data_o : io_rs2_data; // @[Id_stage.scala 122:52]
  wire  blt = $signed(_blt_T) < $signed(_blt_T_1); // @[Id_stage.scala 122:45]
  wire  bge = ~blt; // @[Id_stage.scala 123:33]
  wire  bltu = _jmp_addr_T < cmp2; // @[Id_stage.scala 124:38]
  wire  bgeu = ~bltu; // @[Id_stage.scala 125:33]
  wire  _branch_valid_T = 8'h40 == decode_list_2; // @[Id_stage.scala 10:34]
  wire  _branch_valid_T_1 = 8'h41 == decode_list_2; // @[Id_stage.scala 10:34]
  wire  _branch_valid_T_2 = 8'h42 == decode_list_2; // @[Id_stage.scala 10:34]
  wire  _branch_valid_T_3 = 8'h43 == decode_list_2; // @[Id_stage.scala 10:34]
  wire  _branch_valid_T_4 = 8'h44 == decode_list_2; // @[Id_stage.scala 10:34]
  wire  _branch_valid_T_5 = 8'h45 == decode_list_2; // @[Id_stage.scala 10:34]
  wire  _branch_valid_T_16 = _branch_valid_T & beq | _branch_valid_T_1 & bne | _branch_valid_T_2 & blt |
    _branch_valid_T_3 & bge | _branch_valid_T_4 & bltu | _branch_valid_T_5 & bgeu; // @[Mux.scala 27:72]
  wire  branch_valid = is_branch & _branch_valid_T_16; // @[Id_stage.scala 126:39]
  wire  jmp = is_jalr | branch_valid; // @[Id_stage.scala 134:27]
  wire  _wb_en_T_30 = 8'ha1 == decode_list_2 | (8'ha0 == decode_list_2 | (8'h1f == decode_list_2 | (8'hc1 ==
    decode_list_2 | (8'hc0 == decode_list_2 | (8'h8 == decode_list_2 | (8'h3 == decode_list_2 | (8'h2 == decode_list_2
     | (8'h4 == decode_list_2 | (8'h7 == decode_list_2 | (8'h6 == decode_list_2 | (8'h9 == decode_list_2 | (8'h5 ==
    decode_list_2 | (8'h1 == decode_list_2 | 8'h80 == decode_list_2))))))))))))); // @[Mux.scala 80:57]
  wire  _wb_en_T_50 = 8'h64 == decode_list_2 | (8'h63 == decode_list_2 | (8'h62 == decode_list_2 | (8'h61 ==
    decode_list_2 | (8'he0 == decode_list_2 | (8'ha6 == decode_list_2 | (8'ha5 == decode_list_2 | (8'ha4 ==
    decode_list_2 | (8'ha3 == decode_list_2 | (8'ha2 == decode_list_2 | _wb_en_T_30))))))))); // @[Mux.scala 80:57]
  reg [4:0] rs1_r; // @[Id_stage.scala 175:56]
  reg [4:0] rs2_r; // @[Id_stage.scala 176:56]
  reg  rs1_en_r; // @[Id_stage.scala 177:48]
  reg  rs2_en_r; // @[Id_stage.scala 178:48]
  reg [63:0] op1_r; // @[Id_stage.scala 179:56]
  reg [63:0] op2_r; // @[Id_stage.scala 180:56]
  reg [63:0] imm_r; // @[Id_stage.scala 182:56]
  reg [7:0] fu_op_type_r; // @[Id_stage.scala 183:48]
  reg [4:0] wb_addr_r; // @[Id_stage.scala 185:48]
  reg  wb_en_r; // @[Id_stage.scala 186:56]
  reg [63:0] pc_o_r; // @[Id_stage.scala 187:56]
  reg [31:0] inst_o_r; // @[Id_stage.scala 188:48]
  reg  inst_valid_o_r; // @[Id_stage.scala 189:48]
  assign io_rs1_c = io_inst[19:15]; // @[Id_stage.scala 169:56]
  assign io_rs2_c = io_inst[24:20]; // @[Id_stage.scala 170:56]
  assign io_rs1_en_c = src1_type ? 1'h0 : 1'h1; // @[Id_stage.scala 171:44]
  assign io_rs2_en_c = ~src2_type; // @[Id_stage.scala 172:63]
  assign io_rs1_o = rs1_r; // @[Id_stage.scala 240:41]
  assign io_rs2_o = rs2_r; // @[Id_stage.scala 241:41]
  assign io_rs1_en_o = rs1_en_r; // @[Id_stage.scala 242:33]
  assign io_rs2_en_o = rs2_en_r; // @[Id_stage.scala 243:41]
  assign io_op1_o = op1_r; // @[Id_stage.scala 245:41]
  assign io_op2_o = op2_r; // @[Id_stage.scala 246:41]
  assign io_imm_o = imm_r; // @[Id_stage.scala 248:41]
  assign io_wb_addr_o = wb_addr_r; // @[Id_stage.scala 256:25]
  assign io_wb_en_o = wb_en_r; // @[Id_stage.scala 255:33]
  assign io_fu_op_type_o = fu_op_type_r; // @[Id_stage.scala 249:33]
  assign io_inst_o = inst_o_r; // @[Id_stage.scala 252:33]
  assign io_inst_valid_o = inst_valid_o_r; // @[Id_stage.scala 253:25]
  assign io_pc_o = pc_o_r; // @[Id_stage.scala 251:33]
  assign io_jmp_addr = imm + _jmp_addr_T_1; // @[Id_stage.scala 109:37]
  assign jmp_0 = jmp;
  assign id_alu_conlict_0 = id_alu_conlict;
  assign id_load_conflict_0 = id_load_conflict;
  always @(posedge clock) begin
    if (reset) begin // @[Id_stage.scala 175:56]
      rs1_r <= 5'h0; // @[Id_stage.scala 175:56]
    end else if (io_ctrl == 2'h0) begin // @[Id_stage.scala 191:30]
      rs1_r <= io_inst[19:15]; // @[Id_stage.scala 192:41]
    end else if (!(io_ctrl == 2'h1)) begin // @[Id_stage.scala 208:36]
      if (io_ctrl == 2'h2) begin // @[Id_stage.scala 223:36]
        rs1_r <= 5'h0; // @[Id_stage.scala 224:41]
      end
    end
    if (reset) begin // @[Id_stage.scala 176:56]
      rs2_r <= 5'h0; // @[Id_stage.scala 176:56]
    end else if (io_ctrl == 2'h0) begin // @[Id_stage.scala 191:30]
      rs2_r <= io_inst[24:20]; // @[Id_stage.scala 193:41]
    end else if (!(io_ctrl == 2'h1)) begin // @[Id_stage.scala 208:36]
      if (io_ctrl == 2'h2) begin // @[Id_stage.scala 223:36]
        rs2_r <= 5'h0; // @[Id_stage.scala 225:41]
      end
    end
    if (reset) begin // @[Id_stage.scala 177:48]
      rs1_en_r <= 1'h0; // @[Id_stage.scala 177:48]
    end else if (io_ctrl == 2'h0) begin // @[Id_stage.scala 191:30]
      rs1_en_r <= io_rs1_en_c; // @[Id_stage.scala 194:41]
    end else if (!(io_ctrl == 2'h1)) begin // @[Id_stage.scala 208:36]
      if (io_ctrl == 2'h2) begin // @[Id_stage.scala 223:36]
        rs1_en_r <= 1'h0; // @[Id_stage.scala 226:41]
      end
    end
    if (reset) begin // @[Id_stage.scala 178:48]
      rs2_en_r <= 1'h0; // @[Id_stage.scala 178:48]
    end else if (io_ctrl == 2'h0) begin // @[Id_stage.scala 191:30]
      rs2_en_r <= io_rs2_en_c; // @[Id_stage.scala 195:41]
    end else if (!(io_ctrl == 2'h1)) begin // @[Id_stage.scala 208:36]
      if (io_ctrl == 2'h2) begin // @[Id_stage.scala 223:36]
        rs2_en_r <= 1'h0; // @[Id_stage.scala 227:41]
      end
    end
    if (reset) begin // @[Id_stage.scala 179:56]
      op1_r <= 64'h0; // @[Id_stage.scala 179:56]
    end else if (io_ctrl == 2'h0) begin // @[Id_stage.scala 191:30]
      if (io_rs1_en_c) begin // @[Id_stage.scala 196:52]
        op1_r <= io_rs1_data;
      end else begin
        op1_r <= io_pc;
      end
    end else if (!(io_ctrl == 2'h1)) begin // @[Id_stage.scala 208:36]
      if (io_ctrl == 2'h2) begin // @[Id_stage.scala 223:36]
        op1_r <= 64'h0; // @[Id_stage.scala 228:41]
      end
    end
    if (reset) begin // @[Id_stage.scala 180:56]
      op2_r <= 64'h0; // @[Id_stage.scala 180:56]
    end else if (io_ctrl == 2'h0) begin // @[Id_stage.scala 191:30]
      if (io_rs2_en_c) begin // @[Id_stage.scala 197:52]
        op2_r <= io_rs2_data;
      end else begin
        op2_r <= imm;
      end
    end else if (!(io_ctrl == 2'h1)) begin // @[Id_stage.scala 208:36]
      if (io_ctrl == 2'h2) begin // @[Id_stage.scala 223:36]
        op2_r <= 64'h0; // @[Id_stage.scala 229:41]
      end
    end
    if (reset) begin // @[Id_stage.scala 182:56]
      imm_r <= 64'h0; // @[Id_stage.scala 182:56]
    end else if (io_ctrl == 2'h0) begin // @[Id_stage.scala 191:30]
      imm_r <= imm; // @[Id_stage.scala 198:41]
    end else if (!(io_ctrl == 2'h1)) begin // @[Id_stage.scala 208:36]
      if (io_ctrl == 2'h2) begin // @[Id_stage.scala 223:36]
        imm_r <= 64'h0; // @[Id_stage.scala 230:41]
      end
    end
    if (reset) begin // @[Id_stage.scala 183:48]
      fu_op_type_r <= 8'h0; // @[Id_stage.scala 183:48]
    end else if (io_ctrl == 2'h0) begin // @[Id_stage.scala 191:30]
      if (_decode_list_T_1) begin // @[Lookup.scala 33:37]
        fu_op_type_r <= 8'h1f;
      end else if (_decode_list_T_3) begin // @[Lookup.scala 33:37]
        fu_op_type_r <= 8'h80;
      end else begin
        fu_op_type_r <= _decode_list_T_240;
      end
    end else if (!(io_ctrl == 2'h1)) begin // @[Id_stage.scala 208:36]
      if (io_ctrl == 2'h2) begin // @[Id_stage.scala 223:36]
        fu_op_type_r <= 8'h0; // @[Id_stage.scala 231:33]
      end
    end
    if (reset) begin // @[Id_stage.scala 185:48]
      wb_addr_r <= 5'h0; // @[Id_stage.scala 185:48]
    end else if (io_ctrl == 2'h0) begin // @[Id_stage.scala 191:30]
      wb_addr_r <= imm_lo_1; // @[Id_stage.scala 201:41]
    end else if (!(io_ctrl == 2'h1)) begin // @[Id_stage.scala 208:36]
      if (io_ctrl == 2'h2) begin // @[Id_stage.scala 223:36]
        wb_addr_r <= 5'h0; // @[Id_stage.scala 233:41]
      end
    end
    if (reset) begin // @[Id_stage.scala 186:56]
      wb_en_r <= 1'h0; // @[Id_stage.scala 186:56]
    end else if (io_ctrl == 2'h0) begin // @[Id_stage.scala 191:30]
      if (~io_inst_valid) begin // @[Id_stage.scala 137:24]
        wb_en_r <= 1'h0;
      end else begin
        wb_en_r <= _wb_en_T_50;
      end
    end else if (!(io_ctrl == 2'h1)) begin // @[Id_stage.scala 208:36]
      if (io_ctrl == 2'h2) begin // @[Id_stage.scala 223:36]
        wb_en_r <= 1'h0; // @[Id_stage.scala 234:41]
      end
    end
    if (reset) begin // @[Id_stage.scala 187:56]
      pc_o_r <= 64'h0; // @[Id_stage.scala 187:56]
    end else if (io_ctrl == 2'h0) begin // @[Id_stage.scala 191:30]
      pc_o_r <= io_pc; // @[Id_stage.scala 203:41]
    end else if (!(io_ctrl == 2'h1)) begin // @[Id_stage.scala 208:36]
      if (io_ctrl == 2'h2) begin // @[Id_stage.scala 223:36]
        pc_o_r <= 64'h0; // @[Id_stage.scala 235:41]
      end
    end
    if (reset) begin // @[Id_stage.scala 188:48]
      inst_o_r <= 32'h0; // @[Id_stage.scala 188:48]
    end else if (io_ctrl == 2'h0) begin // @[Id_stage.scala 191:30]
      inst_o_r <= io_inst; // @[Id_stage.scala 204:41]
    end else if (!(io_ctrl == 2'h1)) begin // @[Id_stage.scala 208:36]
      if (io_ctrl == 2'h2) begin // @[Id_stage.scala 223:36]
        inst_o_r <= 32'h0; // @[Id_stage.scala 236:41]
      end
    end
    if (reset) begin // @[Id_stage.scala 189:48]
      inst_valid_o_r <= 1'h0; // @[Id_stage.scala 189:48]
    end else if (io_ctrl == 2'h0) begin // @[Id_stage.scala 191:30]
      inst_valid_o_r <= io_inst_valid; // @[Id_stage.scala 205:33]
    end else if (!(io_ctrl == 2'h1)) begin // @[Id_stage.scala 208:36]
      if (io_ctrl == 2'h2) begin // @[Id_stage.scala 223:36]
        inst_valid_o_r <= 1'h0; // @[Id_stage.scala 237:33]
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
  _RAND_0 = {1{`RANDOM}};
  rs1_r = _RAND_0[4:0];
  _RAND_1 = {1{`RANDOM}};
  rs2_r = _RAND_1[4:0];
  _RAND_2 = {1{`RANDOM}};
  rs1_en_r = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  rs2_en_r = _RAND_3[0:0];
  _RAND_4 = {2{`RANDOM}};
  op1_r = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  op2_r = _RAND_5[63:0];
  _RAND_6 = {2{`RANDOM}};
  imm_r = _RAND_6[63:0];
  _RAND_7 = {1{`RANDOM}};
  fu_op_type_r = _RAND_7[7:0];
  _RAND_8 = {1{`RANDOM}};
  wb_addr_r = _RAND_8[4:0];
  _RAND_9 = {1{`RANDOM}};
  wb_en_r = _RAND_9[0:0];
  _RAND_10 = {2{`RANDOM}};
  pc_o_r = _RAND_10[63:0];
  _RAND_11 = {1{`RANDOM}};
  inst_o_r = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  inst_valid_o_r = _RAND_12[0:0];
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
  input         reset,
  input  [4:0]  io__rs1,
  input  [4:0]  io__rs2,
  input         io__rs1_en,
  input         io__rs2_en,
  input  [4:0]  io__by_wb_addr,
  input         io__by_wb_en,
  input  [63:0] io__by_wb_data,
  input  [1:0]  io__ctrl,
  input  [63:0] io__op1,
  input  [63:0] io__op2,
  input  [63:0] io__imm,
  input  [7:0]  io__fu_op_type,
  input  [31:0] io__inst,
  input         io__inst_valid,
  input  [63:0] io__pc,
  input  [4:0]  io__wb_addr,
  input         io__wb_en,
  output [31:0] io__inst_o,
  output        io__inst_valid_o,
  output [63:0] io__pc_o,
  output [7:0]  io__fu_op_type_o,
  output [63:0] io__op2_o,
  output [4:0]  io__wb_addr_o,
  output        io__wb_en_o,
  output [63:0] io__wb_data_o,
  output [4:0]  io_wb_addr_o,
  output [63:0] io_wb_data_o,
  output        io_wb_en_o,
  output        io_inst_valid_o,
  output        ld_conflict_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [63:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
`endif // RANDOMIZE_REG_INIT
  wire  rs1_harzard_1 = io__inst_valid_o & io__rs1_en & io__wb_en_o & io__rs1 == io__wb_addr_o; // @[Exe_stage.scala 49:72]
  wire  rs2_harzard_1 = io__inst_valid_o & io__rs2_en & io__wb_en_o & io__rs2 == io__wb_addr_o; // @[Exe_stage.scala 50:72]
  wire  rs1_harzard_2 = io__rs1_en & io__by_wb_en & io__rs1 == io__by_wb_addr; // @[Exe_stage.scala 52:54]
  wire  rs2_harzard_2 = io__rs2_en & io__by_wb_en & io__rs2 == io__by_wb_addr; // @[Exe_stage.scala 53:54]
  reg [7:0] next_inst_rd_en_REG; // @[Exe_stage.scala 55:56]
  wire  next_inst_rd_en = 8'ha6 == next_inst_rd_en_REG | (8'ha5 == next_inst_rd_en_REG | (8'ha4 == next_inst_rd_en_REG
     | (8'ha3 == next_inst_rd_en_REG | (8'ha2 == next_inst_rd_en_REG | (8'ha1 == next_inst_rd_en_REG | 8'ha0 ==
    next_inst_rd_en_REG))))); // @[Mux.scala 80:57]
  wire  ld_conflict = next_inst_rd_en & (rs1_harzard_1 | rs2_harzard_1); // @[Exe_stage.scala 65:44]
  reg [63:0] stall_reserve; // @[Exe_stage.scala 68:36]
  reg  rs1_harzard_stall; // @[Exe_stage.scala 69:40]
  reg  rs2_harzard_stall; // @[Exe_stage.scala 70:40]
  wire [63:0] _op1_T = rs1_harzard_2 ? io__by_wb_data : io__op1; // @[Exe_stage.scala 72:93]
  wire [63:0] _op1_T_1 = rs1_harzard_1 ? io__wb_data_o : _op1_T; // @[Exe_stage.scala 72:60]
  wire [63:0] op1 = rs1_harzard_stall ? stall_reserve : _op1_T_1; // @[Exe_stage.scala 72:22]
  wire [63:0] _op2_T = rs2_harzard_2 ? io__by_wb_data : io__op2; // @[Exe_stage.scala 73:93]
  wire [63:0] _op2_T_1 = rs2_harzard_1 ? io__wb_data_o : _op2_T; // @[Exe_stage.scala 73:60]
  wire [63:0] op2 = rs2_harzard_stall ? stall_reserve : _op2_T_1; // @[Exe_stage.scala 73:22]
  wire  _shamt_T_2 = io__fu_op_type[5] & io__fu_op_type[6]; // @[ISA.scala 88:43]
  wire [5:0] shamt = _shamt_T_2 ? {{1'd0}, op2[4:0]} : op2[5:0]; // @[Exe_stage.scala 77:24]
  wire  is_InstS = 8'haa == io__fu_op_type | (8'ha9 == io__fu_op_type | (8'ha8 == io__fu_op_type | 8'ha7 ==
    io__fu_op_type)); // @[Mux.scala 80:57]
  wire  is_adder_sub = ~io__fu_op_type[7]; // @[Exe_stage.scala 86:28]
  wire [63:0] _adder_res_T = is_InstS ? io__imm : op2; // @[Exe_stage.scala 87:37]
  wire [63:0] _adder_res_T_2 = is_adder_sub ? 64'hffffffffffffffff : 64'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _adder_res_T_3 = _adder_res_T ^ _adder_res_T_2; // @[Exe_stage.scala 87:61]
  wire [64:0] _adder_res_T_4 = op1 + _adder_res_T_3; // @[Exe_stage.scala 87:30]
  wire [64:0] _GEN_22 = {{64'd0}, is_adder_sub}; // @[Exe_stage.scala 87:89]
  wire [64:0] adder_res = _adder_res_T_4 + _GEN_22; // @[Exe_stage.scala 87:89]
  wire [63:0] xor_res = op1 ^ op2; // @[Exe_stage.scala 88:28]
  wire  sltu_res = ~adder_res[64]; // @[Exe_stage.scala 90:24]
  wire  slt_res = xor_res[63] ^ sltu_res; // @[Exe_stage.scala 91:39]
  wire [63:0] next_pc = io__pc + 64'h4; // @[Exe_stage.scala 93:39]
  wire [31:0] shift_src_lo = op1[31:0]; // @[Exe_stage.scala 96:60]
  wire [63:0] _shift_src_T_1 = {32'h0,shift_src_lo}; // @[Cat.scala 30:58]
  wire  shift_src_signBit = shift_src_lo[31]; // @[BitUtil.scala 9:20]
  wire [31:0] shift_src_hi = shift_src_signBit ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _shift_src_T_3 = {shift_src_hi,shift_src_lo}; // @[Cat.scala 30:58]
  wire [63:0] _shift_src_T_5 = 8'h63 == io__fu_op_type ? _shift_src_T_1 : op1; // @[Mux.scala 80:57]
  wire [63:0] shift_src = 8'h64 == io__fu_op_type ? _shift_src_T_3 : _shift_src_T_5; // @[Mux.scala 80:57]
  wire [126:0] _GEN_23 = {{63'd0}, shift_src}; // @[Exe_stage.scala 101:60]
  wire [126:0] _res_T = _GEN_23 << shamt; // @[Exe_stage.scala 101:60]
  wire [63:0] _res_T_2 = shift_src >> shamt; // @[Exe_stage.scala 102:60]
  wire [63:0] _res_T_3 = 8'h64 == io__fu_op_type ? _shift_src_T_3 : _shift_src_T_5; // @[Exe_stage.scala 103:60]
  wire [63:0] _res_T_5 = $signed(_res_T_3) >>> shamt; // @[Exe_stage.scala 103:77]
  wire [63:0] _res_T_12 = op1 | op2; // @[Exe_stage.scala 109:54]
  wire [63:0] _res_T_13 = op1 & op2; // @[Exe_stage.scala 110:54]
  wire [63:0] _res_T_14 = {63'h0,slt_res}; // @[Cat.scala 30:58]
  wire [63:0] _res_T_15 = {63'h0,sltu_res}; // @[Cat.scala 30:58]
  wire [64:0] _res_T_17 = 8'h1 == io__fu_op_type ? {{1'd0}, _res_T[63:0]} : adder_res; // @[Mux.scala 80:57]
  wire [64:0] _res_T_19 = 8'h5 == io__fu_op_type ? {{1'd0}, _res_T_2} : _res_T_17; // @[Mux.scala 80:57]
  wire [64:0] _res_T_21 = 8'h9 == io__fu_op_type ? {{1'd0}, _res_T_5} : _res_T_19; // @[Mux.scala 80:57]
  wire [64:0] _res_T_23 = 8'h62 == io__fu_op_type ? {{1'd0}, _res_T[63:0]} : _res_T_21; // @[Mux.scala 80:57]
  wire [64:0] _res_T_25 = 8'h63 == io__fu_op_type ? {{1'd0}, _res_T_2} : _res_T_23; // @[Mux.scala 80:57]
  wire [64:0] _res_T_27 = 8'h64 == io__fu_op_type ? {{1'd0}, _res_T_5} : _res_T_25; // @[Mux.scala 80:57]
  wire [64:0] _res_T_29 = 8'h6 == io__fu_op_type ? {{1'd0}, _res_T_12} : _res_T_27; // @[Mux.scala 80:57]
  wire [64:0] _res_T_31 = 8'h7 == io__fu_op_type ? {{1'd0}, _res_T_13} : _res_T_29; // @[Mux.scala 80:57]
  wire [64:0] _res_T_33 = 8'h4 == io__fu_op_type ? {{1'd0}, xor_res} : _res_T_31; // @[Mux.scala 80:57]
  wire [64:0] _res_T_35 = 8'h2 == io__fu_op_type ? {{1'd0}, _res_T_14} : _res_T_33; // @[Mux.scala 80:57]
  wire [64:0] _res_T_37 = 8'h3 == io__fu_op_type ? {{1'd0}, _res_T_15} : _res_T_35; // @[Mux.scala 80:57]
  wire [64:0] _res_T_39 = 8'hc0 == io__fu_op_type ? {{1'd0}, next_pc} : _res_T_37; // @[Mux.scala 80:57]
  wire [64:0] _res_T_41 = 8'hc1 == io__fu_op_type ? {{1'd0}, next_pc} : _res_T_39; // @[Mux.scala 80:57]
  wire [64:0] res = 8'h1f == io__fu_op_type ? {{1'd0}, op2} : _res_T_41; // @[Mux.scala 80:57]
  wire [31:0] wb_data_lo = res[31:0]; // @[Exe_stage.scala 120:72]
  wire  wb_data_signBit = wb_data_lo[31]; // @[BitUtil.scala 9:20]
  wire [31:0] wb_data_hi = wb_data_signBit ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _wb_data_T_4 = {wb_data_hi,wb_data_lo}; // @[Cat.scala 30:58]
  wire [64:0] wb_data = _shamt_T_2 ? {{1'd0}, _wb_data_T_4} : res; // @[Exe_stage.scala 120:26]
  reg  wb_en_r; // @[Exe_stage.scala 122:56]
  reg [63:0] wb_data_r; // @[Exe_stage.scala 123:48]
  reg [4:0] wb_addr_r; // @[Exe_stage.scala 124:48]
  reg [7:0] fu_op_type_o_r; // @[Exe_stage.scala 125:48]
  reg [63:0] op2_o_r; // @[Exe_stage.scala 128:56]
  reg [63:0] pc_o_r; // @[Exe_stage.scala 130:56]
  reg [31:0] inst_o_r; // @[Exe_stage.scala 131:48]
  reg  inst_valid_o_r; // @[Exe_stage.scala 132:48]
  wire  write_reg_0 = io__wb_addr == 5'h0 & io__wb_en; // @[Exe_stage.scala 134:45]
  wire [64:0] _wb_data_r_T = write_reg_0 ? 65'h0 : wb_data; // @[Exe_stage.scala 138:52]
  wire [63:0] _GEN_1 = io__ctrl == 2'h1 ? 64'h0 : wb_data_r; // @[Exe_stage.scala 147:36 Exe_stage.scala 149:41 Exe_stage.scala 123:48]
  wire [64:0] _GEN_13 = io__ctrl == 2'h0 ? _wb_data_r_T : {{1'd0}, _GEN_1}; // @[Exe_stage.scala 135:30 Exe_stage.scala 138:41]
  assign io__inst_o = inst_o_r; // @[Exe_stage.scala 170:41]
  assign io__inst_valid_o = inst_valid_o_r; // @[Exe_stage.scala 171:33]
  assign io__pc_o = pc_o_r; // @[Exe_stage.scala 169:41]
  assign io__fu_op_type_o = fu_op_type_o_r; // @[Exe_stage.scala 164:33]
  assign io__op2_o = op2_o_r; // @[Exe_stage.scala 167:41]
  assign io__wb_addr_o = wb_addr_r; // @[Exe_stage.scala 163:33]
  assign io__wb_en_o = wb_en_r; // @[Exe_stage.scala 161:41]
  assign io__wb_data_o = wb_data_r; // @[Exe_stage.scala 162:33]
  assign io_wb_addr_o = io__wb_addr_o;
  assign io_wb_data_o = io__wb_data_o;
  assign io_wb_en_o = io__wb_en_o;
  assign io_inst_valid_o = io__inst_valid_o;
  assign ld_conflict_0 = ld_conflict;
  always @(posedge clock) begin
    next_inst_rd_en_REG <= io__fu_op_type; // @[Exe_stage.scala 55:56]
    stall_reserve <= io__by_wb_data; // @[Exe_stage.scala 68:36]
    rs1_harzard_stall <= rs1_harzard_2 & ld_conflict & ~rs1_harzard_1; // @[Exe_stage.scala 69:70]
    rs2_harzard_stall <= rs2_harzard_2 & ld_conflict & ~rs2_harzard_1; // @[Exe_stage.scala 70:70]
    if (reset) begin // @[Exe_stage.scala 122:56]
      wb_en_r <= 1'h0; // @[Exe_stage.scala 122:56]
    end else if (io__ctrl == 2'h0) begin // @[Exe_stage.scala 135:30]
      wb_en_r <= io__wb_en; // @[Exe_stage.scala 136:41]
    end else if (io__ctrl == 2'h1) begin // @[Exe_stage.scala 147:36]
      wb_en_r <= 1'h0; // @[Exe_stage.scala 148:41]
    end
    if (reset) begin // @[Exe_stage.scala 123:48]
      wb_data_r <= 64'h0; // @[Exe_stage.scala 123:48]
    end else begin
      wb_data_r <= _GEN_13[63:0];
    end
    if (reset) begin // @[Exe_stage.scala 124:48]
      wb_addr_r <= 5'h0; // @[Exe_stage.scala 124:48]
    end else if (io__ctrl == 2'h0) begin // @[Exe_stage.scala 135:30]
      wb_addr_r <= io__wb_addr; // @[Exe_stage.scala 137:41]
    end else if (io__ctrl == 2'h1) begin // @[Exe_stage.scala 147:36]
      wb_addr_r <= 5'h0; // @[Exe_stage.scala 150:41]
    end
    if (reset) begin // @[Exe_stage.scala 125:48]
      fu_op_type_o_r <= 8'h0; // @[Exe_stage.scala 125:48]
    end else if (io__ctrl == 2'h0) begin // @[Exe_stage.scala 135:30]
      fu_op_type_o_r <= io__fu_op_type; // @[Exe_stage.scala 139:33]
    end else if (io__ctrl == 2'h1) begin // @[Exe_stage.scala 147:36]
      fu_op_type_o_r <= 8'h0; // @[Exe_stage.scala 151:33]
    end
    if (reset) begin // @[Exe_stage.scala 128:56]
      op2_o_r <= 64'h0; // @[Exe_stage.scala 128:56]
    end else if (io__ctrl == 2'h0) begin // @[Exe_stage.scala 135:30]
      if (rs2_harzard_stall) begin // @[Exe_stage.scala 73:22]
        op2_o_r <= stall_reserve;
      end else if (rs2_harzard_1) begin // @[Exe_stage.scala 73:60]
        op2_o_r <= io__wb_data_o;
      end else begin
        op2_o_r <= _op2_T;
      end
    end else if (io__ctrl == 2'h1) begin // @[Exe_stage.scala 147:36]
      op2_o_r <= 64'h0; // @[Exe_stage.scala 154:41]
    end
    if (reset) begin // @[Exe_stage.scala 130:56]
      pc_o_r <= 64'h0; // @[Exe_stage.scala 130:56]
    end else if (io__ctrl == 2'h0) begin // @[Exe_stage.scala 135:30]
      pc_o_r <= io__pc; // @[Exe_stage.scala 144:41]
    end else if (io__ctrl == 2'h1) begin // @[Exe_stage.scala 147:36]
      pc_o_r <= 64'h0; // @[Exe_stage.scala 156:41]
    end
    if (reset) begin // @[Exe_stage.scala 131:48]
      inst_o_r <= 32'h0; // @[Exe_stage.scala 131:48]
    end else if (io__ctrl == 2'h0) begin // @[Exe_stage.scala 135:30]
      inst_o_r <= io__inst; // @[Exe_stage.scala 145:41]
    end else if (io__ctrl == 2'h1) begin // @[Exe_stage.scala 147:36]
      inst_o_r <= 32'h0; // @[Exe_stage.scala 157:41]
    end
    if (reset) begin // @[Exe_stage.scala 132:48]
      inst_valid_o_r <= 1'h0; // @[Exe_stage.scala 132:48]
    end else if (io__ctrl == 2'h0) begin // @[Exe_stage.scala 135:30]
      inst_valid_o_r <= io__inst_valid; // @[Exe_stage.scala 146:33]
    end else if (io__ctrl == 2'h1) begin // @[Exe_stage.scala 147:36]
      inst_valid_o_r <= 1'h0; // @[Exe_stage.scala 158:33]
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
  _RAND_0 = {1{`RANDOM}};
  next_inst_rd_en_REG = _RAND_0[7:0];
  _RAND_1 = {2{`RANDOM}};
  stall_reserve = _RAND_1[63:0];
  _RAND_2 = {1{`RANDOM}};
  rs1_harzard_stall = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  rs2_harzard_stall = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  wb_en_r = _RAND_4[0:0];
  _RAND_5 = {2{`RANDOM}};
  wb_data_r = _RAND_5[63:0];
  _RAND_6 = {1{`RANDOM}};
  wb_addr_r = _RAND_6[4:0];
  _RAND_7 = {1{`RANDOM}};
  fu_op_type_o_r = _RAND_7[7:0];
  _RAND_8 = {2{`RANDOM}};
  op2_o_r = _RAND_8[63:0];
  _RAND_9 = {2{`RANDOM}};
  pc_o_r = _RAND_9[63:0];
  _RAND_10 = {1{`RANDOM}};
  inst_o_r = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  inst_valid_o_r = _RAND_11[0:0];
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
  input  [63:0] io_op2,
  input  [7:0]  io_fu_op_type,
  input  [31:0] io_inst,
  input         io_inst_valid,
  input  [63:0] io_pc,
  output [31:0] io_inst_o,
  output        io_inst_valid_o,
  output [63:0] io_pc_o,
  output [4:0]  io_wb_addr_o,
  output        io_wb_en_o,
  output [63:0] io_wb_data_o,
  output [63:0] io_wr_mask,
  output [63:0] io_wr_idx,
  output [63:0] io_rd_idx,
  output        io_rd_en,
  output        io_wr_en,
  output [63:0] io_wr_data,
  input  [63:0] io_rd_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [63:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [63:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [63:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [63:0] _RAND_14;
  reg [63:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
`endif // RANDOMIZE_REG_INIT
  wire  store_test_clock; // @[Mem_stage.scala 168:32]
  wire [7:0] store_test_coreid; // @[Mem_stage.scala 168:32]
  wire [7:0] store_test_index; // @[Mem_stage.scala 168:32]
  wire  store_test_valid; // @[Mem_stage.scala 168:32]
  wire [63:0] store_test_storeAddr; // @[Mem_stage.scala 168:32]
  wire [63:0] store_test_storeData; // @[Mem_stage.scala 168:32]
  wire [7:0] store_test_storeMask; // @[Mem_stage.scala 168:32]
  wire [2:0] rd_sel = io_wb_data[2:0]; // @[Mem_stage.scala 44:40]
  wire  _T = 3'h0 == rd_sel; // @[Conditional.scala 37:30]
  wire  _T_1 = 3'h1 == rd_sel; // @[Conditional.scala 37:30]
  wire  _T_2 = 3'h2 == rd_sel; // @[Conditional.scala 37:30]
  wire  _T_3 = 3'h3 == rd_sel; // @[Conditional.scala 37:30]
  wire  _T_4 = 3'h4 == rd_sel; // @[Conditional.scala 37:30]
  wire  _T_5 = 3'h5 == rd_sel; // @[Conditional.scala 37:30]
  wire  _T_6 = 3'h6 == rd_sel; // @[Conditional.scala 37:30]
  wire  _T_7 = 3'h7 == rd_sel; // @[Conditional.scala 37:30]
  wire [7:0] _GEN_0 = _T_7 ? io_rd_data[63:56] : 8'h0; // @[Conditional.scala 39:67 Mem_stage.scala 59:35]
  wire [7:0] _GEN_1 = _T_6 ? io_rd_data[55:48] : _GEN_0; // @[Conditional.scala 39:67 Mem_stage.scala 58:35]
  wire [7:0] _GEN_2 = _T_5 ? io_rd_data[47:40] : _GEN_1; // @[Conditional.scala 39:67 Mem_stage.scala 57:35]
  wire [7:0] _GEN_3 = _T_4 ? io_rd_data[39:32] : _GEN_2; // @[Conditional.scala 39:67 Mem_stage.scala 56:35]
  wire [7:0] _GEN_4 = _T_3 ? io_rd_data[31:24] : _GEN_3; // @[Conditional.scala 39:67 Mem_stage.scala 55:35]
  wire [7:0] _GEN_5 = _T_2 ? io_rd_data[23:16] : _GEN_4; // @[Conditional.scala 39:67 Mem_stage.scala 54:35]
  wire [7:0] _GEN_6 = _T_1 ? io_rd_data[15:8] : _GEN_5; // @[Conditional.scala 39:67 Mem_stage.scala 53:35]
  wire [7:0] rd_data_b = _T ? io_rd_data[7:0] : _GEN_6; // @[Conditional.scala 40:58 Mem_stage.scala 52:35]
  wire  _T_9 = 2'h0 == rd_sel[2:1]; // @[Conditional.scala 37:30]
  wire  _T_10 = 2'h1 == rd_sel[2:1]; // @[Conditional.scala 37:30]
  wire  _T_11 = 2'h2 == rd_sel[2:1]; // @[Conditional.scala 37:30]
  wire  _T_12 = 2'h3 == rd_sel[2:1]; // @[Conditional.scala 37:30]
  wire [15:0] _GEN_8 = _T_12 ? io_rd_data[63:48] : 16'h0; // @[Conditional.scala 39:67 Mem_stage.scala 65:41]
  wire [15:0] _GEN_9 = _T_11 ? io_rd_data[47:32] : _GEN_8; // @[Conditional.scala 39:67 Mem_stage.scala 64:41]
  wire [15:0] _GEN_10 = _T_10 ? io_rd_data[31:16] : _GEN_9; // @[Conditional.scala 39:67 Mem_stage.scala 63:41]
  wire [15:0] rd_data_h = _T_9 ? io_rd_data[15:0] : _GEN_10; // @[Conditional.scala 40:58 Mem_stage.scala 62:41]
  wire  _T_14 = ~rd_sel[2]; // @[Conditional.scala 37:30]
  wire [31:0] _GEN_12 = rd_sel[2] ? io_rd_data[63:32] : 32'h0; // @[Conditional.scala 39:67 Mem_stage.scala 69:41]
  wire [31:0] rd_data_w = _T_14 ? io_rd_data[31:0] : _GEN_12; // @[Conditional.scala 40:58 Mem_stage.scala 68:41]
  wire [7:0] value_b = io_op2[7:0]; // @[Mem_stage.scala 86:29]
  wire [15:0] value_h = io_op2[15:0]; // @[Mem_stage.scala 87:29]
  wire [31:0] value_w = io_op2[31:0]; // @[Mem_stage.scala 88:29]
  wire [63:0] _GEN_14 = _T_7 ? 64'hff00000000000000 : 64'h0; // @[Conditional.scala 39:67 Mem_stage.scala 116:41]
  wire [63:0] _GEN_17 = _T_6 ? 64'hff000000000000 : _GEN_14; // @[Conditional.scala 39:67 Mem_stage.scala 115:41]
  wire [63:0] _GEN_20 = _T_5 ? 64'hff0000000000 : _GEN_17; // @[Conditional.scala 39:67 Mem_stage.scala 114:41]
  wire [63:0] _GEN_23 = _T_4 ? 64'hff00000000 : _GEN_20; // @[Conditional.scala 39:67 Mem_stage.scala 113:41]
  wire [63:0] _GEN_26 = _T_3 ? 64'hff000000 : _GEN_23; // @[Conditional.scala 39:67 Mem_stage.scala 112:41]
  wire [63:0] _GEN_29 = _T_2 ? 64'hff0000 : _GEN_26; // @[Conditional.scala 39:67 Mem_stage.scala 111:41]
  wire [63:0] _GEN_32 = _T_1 ? 64'hff00 : _GEN_29; // @[Conditional.scala 39:67 Mem_stage.scala 110:41]
  wire [63:0] wr_mask_b = _T ? 64'hff : _GEN_32; // @[Conditional.scala 40:58 Mem_stage.scala 109:41]
  wire [63:0] _wr_mask_T_1 = 8'ha7 == io_fu_op_type ? wr_mask_b : 64'hffffffffffffffff; // @[Mux.scala 80:57]
  wire [63:0] _GEN_38 = _T_12 ? 64'hffff000000000000 : 64'h0; // @[Conditional.scala 39:67 Mem_stage.scala 123:41]
  wire [63:0] _GEN_41 = _T_11 ? 64'hffff00000000 : _GEN_38; // @[Conditional.scala 39:67 Mem_stage.scala 122:41]
  wire [63:0] _GEN_44 = _T_10 ? 64'hffff0000 : _GEN_41; // @[Conditional.scala 39:67 Mem_stage.scala 121:41]
  wire [63:0] wr_mask_h = _T_9 ? 64'hffff : _GEN_44; // @[Conditional.scala 40:58 Mem_stage.scala 120:41]
  wire [63:0] _wr_mask_T_3 = 8'ha8 == io_fu_op_type ? wr_mask_h : _wr_mask_T_1; // @[Mux.scala 80:57]
  wire [63:0] _GEN_50 = rd_sel[2] ? 64'hffffffff00000000 : 64'h0; // @[Conditional.scala 39:67 Mem_stage.scala 127:41]
  wire [63:0] wr_mask_w = _T_14 ? 64'hffffffff : _GEN_50; // @[Conditional.scala 40:58 Mem_stage.scala 126:41]
  wire [63:0] _wr_mask_T_5 = 8'ha9 == io_fu_op_type ? wr_mask_w : _wr_mask_T_3; // @[Mux.scala 80:57]
  wire [7:0] _GEN_15 = _T_7 ? 8'h80 : 8'h0; // @[Conditional.scala 39:67 Mem_stage.scala 116:105]
  wire [7:0] _GEN_18 = _T_6 ? 8'h40 : _GEN_15; // @[Conditional.scala 39:67 Mem_stage.scala 115:105]
  wire [7:0] _GEN_21 = _T_5 ? 8'h20 : _GEN_18; // @[Conditional.scala 39:67 Mem_stage.scala 114:105]
  wire [7:0] _GEN_24 = _T_4 ? 8'h10 : _GEN_21; // @[Conditional.scala 39:67 Mem_stage.scala 113:105]
  wire [7:0] _GEN_27 = _T_3 ? 8'h8 : _GEN_24; // @[Conditional.scala 39:67 Mem_stage.scala 112:105]
  wire [7:0] _GEN_30 = _T_2 ? 8'h4 : _GEN_27; // @[Conditional.scala 39:67 Mem_stage.scala 111:105]
  wire [7:0] _GEN_33 = _T_1 ? 8'h2 : _GEN_30; // @[Conditional.scala 39:67 Mem_stage.scala 110:105]
  wire [7:0] store_mask_b = _T ? 8'h1 : _GEN_33; // @[Conditional.scala 40:58 Mem_stage.scala 109:105]
  wire [7:0] _GEN_39 = _T_12 ? 8'hc0 : 8'h0; // @[Conditional.scala 39:67 Mem_stage.scala 123:105]
  wire [7:0] _GEN_42 = _T_11 ? 8'h30 : _GEN_39; // @[Conditional.scala 39:67 Mem_stage.scala 122:105]
  wire [7:0] _GEN_45 = _T_10 ? 8'hc : _GEN_42; // @[Conditional.scala 39:67 Mem_stage.scala 121:105]
  wire [7:0] store_mask_h = _T_9 ? 8'h3 : _GEN_45; // @[Conditional.scala 40:58 Mem_stage.scala 120:105]
  wire [7:0] _GEN_51 = rd_sel[2] ? 8'hf0 : 8'h0; // @[Conditional.scala 39:67 Mem_stage.scala 127:105]
  wire [7:0] store_mask_w = _T_14 ? 8'hf : _GEN_51; // @[Conditional.scala 40:58 Mem_stage.scala 126:105]
  wire [63:0] _wr_data_b_T = {56'h0,value_b}; // @[Cat.scala 30:58]
  wire [63:0] _wr_data_b_T_1 = {48'h0,value_b,8'h0}; // @[Cat.scala 30:58]
  wire [63:0] _wr_data_b_T_2 = {40'h0,value_b,16'h0}; // @[Cat.scala 30:58]
  wire [63:0] _wr_data_b_T_3 = {32'h0,value_b,24'h0}; // @[Cat.scala 30:58]
  wire [63:0] _wr_data_b_T_4 = {24'h0,value_b,32'h0}; // @[Cat.scala 30:58]
  wire [63:0] _wr_data_b_T_5 = {16'h0,value_b,40'h0}; // @[Cat.scala 30:58]
  wire [63:0] _wr_data_b_T_6 = {8'h0,value_b,48'h0}; // @[Cat.scala 30:58]
  wire [63:0] _wr_data_b_T_7 = {value_b,56'h0}; // @[Cat.scala 30:58]
  wire [63:0] _GEN_16 = _T_7 ? _wr_data_b_T_7 : 64'h0; // @[Conditional.scala 39:67 Mem_stage.scala 116:161]
  wire [63:0] _GEN_19 = _T_6 ? _wr_data_b_T_6 : _GEN_16; // @[Conditional.scala 39:67 Mem_stage.scala 115:161]
  wire [63:0] _GEN_22 = _T_5 ? _wr_data_b_T_5 : _GEN_19; // @[Conditional.scala 39:67 Mem_stage.scala 114:161]
  wire [63:0] _GEN_25 = _T_4 ? _wr_data_b_T_4 : _GEN_22; // @[Conditional.scala 39:67 Mem_stage.scala 113:161]
  wire [63:0] _GEN_28 = _T_3 ? _wr_data_b_T_3 : _GEN_25; // @[Conditional.scala 39:67 Mem_stage.scala 112:161]
  wire [63:0] _GEN_31 = _T_2 ? _wr_data_b_T_2 : _GEN_28; // @[Conditional.scala 39:67 Mem_stage.scala 111:161]
  wire [63:0] _GEN_34 = _T_1 ? _wr_data_b_T_1 : _GEN_31; // @[Conditional.scala 39:67 Mem_stage.scala 110:161]
  wire [63:0] wr_data_b = _T ? _wr_data_b_T : _GEN_34; // @[Conditional.scala 40:58 Mem_stage.scala 109:161]
  wire [63:0] _wr_data_h_T = {48'h0,value_h}; // @[Cat.scala 30:58]
  wire [63:0] _wr_data_h_T_1 = {32'h0,value_h,16'h0}; // @[Cat.scala 30:58]
  wire [63:0] _wr_data_h_T_2 = {16'h0,value_h,32'h0}; // @[Cat.scala 30:58]
  wire [63:0] _wr_data_h_T_3 = {value_h,48'h0}; // @[Cat.scala 30:58]
  wire [63:0] _GEN_40 = _T_12 ? _wr_data_h_T_3 : 64'h0; // @[Conditional.scala 39:67 Mem_stage.scala 123:161]
  wire [63:0] _GEN_43 = _T_11 ? _wr_data_h_T_2 : _GEN_40; // @[Conditional.scala 39:67 Mem_stage.scala 122:161]
  wire [63:0] _GEN_46 = _T_10 ? _wr_data_h_T_1 : _GEN_43; // @[Conditional.scala 39:67 Mem_stage.scala 121:161]
  wire [63:0] wr_data_h = _T_9 ? _wr_data_h_T : _GEN_46; // @[Conditional.scala 40:58 Mem_stage.scala 120:161]
  wire [63:0] _wr_data_w_T = {32'h0,value_w}; // @[Cat.scala 30:58]
  wire [63:0] _wr_data_w_T_1 = {value_w,32'h0}; // @[Cat.scala 30:58]
  wire [63:0] _GEN_52 = rd_sel[2] ? _wr_data_w_T_1 : 64'h0; // @[Conditional.scala 39:67 Mem_stage.scala 127:153]
  wire [63:0] wr_data_w = _T_14 ? _wr_data_w_T : _GEN_52; // @[Conditional.scala 40:58 Mem_stage.scala 126:153]
  wire  _wr_en_T_8 = 8'haa == io_fu_op_type | (8'ha9 == io_fu_op_type | (8'ha8 == io_fu_op_type | 8'ha7 == io_fu_op_type
    )); // @[Mux.scala 80:57]
  wire [63:0] _wr_data_T_1 = 8'ha7 == io_fu_op_type ? wr_data_b : 64'h0; // @[Mux.scala 80:57]
  wire [63:0] _wr_data_T_3 = 8'ha8 == io_fu_op_type ? wr_data_h : _wr_data_T_1; // @[Mux.scala 80:57]
  wire [63:0] _wr_data_T_5 = 8'ha9 == io_fu_op_type ? wr_data_w : _wr_data_T_3; // @[Mux.scala 80:57]
  wire  wb_data_o_signBit = rd_data_b[7]; // @[BitUtil.scala 9:20]
  wire [55:0] wb_data_o_hi = wb_data_o_signBit ? 56'hffffffffffffff : 56'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _wb_data_o_T_1 = {wb_data_o_hi,rd_data_b}; // @[Cat.scala 30:58]
  wire  wb_data_o_signBit_1 = rd_data_h[15]; // @[BitUtil.scala 9:20]
  wire [47:0] wb_data_o_hi_1 = wb_data_o_signBit_1 ? 48'hffffffffffff : 48'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _wb_data_o_T_3 = {wb_data_o_hi_1,rd_data_h}; // @[Cat.scala 30:58]
  wire  wb_data_o_signBit_2 = rd_data_w[31]; // @[BitUtil.scala 9:20]
  wire [31:0] wb_data_o_hi_2 = wb_data_o_signBit_2 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _wb_data_o_T_5 = {wb_data_o_hi_2,rd_data_w}; // @[Cat.scala 30:58]
  wire [63:0] _wb_data_o_T_7 = {56'h0,rd_data_b}; // @[Cat.scala 30:58]
  wire [63:0] _wb_data_o_T_8 = {48'h0,rd_data_h}; // @[Cat.scala 30:58]
  wire [63:0] _wb_data_o_T_9 = {32'h0,rd_data_w}; // @[Cat.scala 30:58]
  wire [63:0] _wb_data_o_T_11 = 8'ha0 == io_fu_op_type ? _wb_data_o_T_1 : io_wb_data; // @[Mux.scala 80:57]
  wire [63:0] _wb_data_o_T_13 = 8'ha1 == io_fu_op_type ? _wb_data_o_T_3 : _wb_data_o_T_11; // @[Mux.scala 80:57]
  wire [63:0] _wb_data_o_T_15 = 8'ha2 == io_fu_op_type ? _wb_data_o_T_5 : _wb_data_o_T_13; // @[Mux.scala 80:57]
  reg  REG; // @[Mem_stage.scala 172:61]
  reg  REG_1; // @[Mem_stage.scala 172:53]
  reg  REG_2; // @[Mem_stage.scala 172:45]
  reg [63:0] REG_3; // @[Mem_stage.scala 173:61]
  reg [63:0] REG_4; // @[Mem_stage.scala 173:53]
  reg [63:0] REG_5; // @[Mem_stage.scala 173:45]
  reg [63:0] REG_6; // @[Mem_stage.scala 174:61]
  reg [63:0] REG_7; // @[Mem_stage.scala 174:53]
  reg [63:0] REG_8; // @[Mem_stage.scala 174:45]
  reg [63:0] REG_9; // @[Mem_stage.scala 175:61]
  reg [63:0] REG_10; // @[Mem_stage.scala 175:53]
  reg [63:0] REG_11; // @[Mem_stage.scala 175:45]
  reg [4:0] io_wb_addr_o_REG; // @[Mem_stage.scala 177:40]
  reg  io_wb_en_o_REG; // @[Mem_stage.scala 178:48]
  reg [63:0] io_wb_data_o_REG; // @[Mem_stage.scala 179:40]
  reg [63:0] io_pc_o_REG; // @[Mem_stage.scala 189:48]
  reg [31:0] io_inst_o_REG; // @[Mem_stage.scala 190:48]
  reg  io_inst_valid_o_REG; // @[Mem_stage.scala 191:40]
  DifftestStoreEvent store_test ( // @[Mem_stage.scala 168:32]
    .clock(store_test_clock),
    .coreid(store_test_coreid),
    .index(store_test_index),
    .valid(store_test_valid),
    .storeAddr(store_test_storeAddr),
    .storeData(store_test_storeData),
    .storeMask(store_test_storeMask)
  );
  assign io_inst_o = io_inst_o_REG; // @[Mem_stage.scala 190:33]
  assign io_inst_valid_o = io_inst_valid_o_REG; // @[Mem_stage.scala 191:25]
  assign io_pc_o = io_pc_o_REG; // @[Mem_stage.scala 189:33]
  assign io_wb_addr_o = io_wb_addr_o_REG; // @[Mem_stage.scala 177:25]
  assign io_wb_en_o = io_wb_en_o_REG; // @[Mem_stage.scala 178:33]
  assign io_wb_data_o = io_wb_data_o_REG; // @[Mem_stage.scala 179:25]
  assign io_wr_mask = 8'haa == io_fu_op_type ? 64'hffffffffffffffff : _wr_mask_T_5; // @[Mux.scala 80:57]
  assign io_wr_idx = {{3'd0}, io_wb_data[63:3]}; // @[Mem_stage.scala 185:49]
  assign io_rd_idx = {{3'd0}, io_wb_data[63:3]}; // @[Mem_stage.scala 182:49]
  assign io_rd_en = 8'ha6 == io_fu_op_type | (8'ha5 == io_fu_op_type | (8'ha4 == io_fu_op_type | (8'ha3 == io_fu_op_type
     | (8'ha2 == io_fu_op_type | (8'ha1 == io_fu_op_type | 8'ha0 == io_fu_op_type))))); // @[Mux.scala 80:57]
  assign io_wr_en = ~io_inst_valid ? 1'h0 : _wr_en_T_8; // @[Mem_stage.scala 142:24]
  assign io_wr_data = 8'haa == io_fu_op_type ? io_op2 : _wr_data_T_5; // @[Mux.scala 80:57]
  assign store_test_clock = clock; // @[Mem_stage.scala 169:35]
  assign store_test_coreid = 8'h0; // @[Mem_stage.scala 170:35]
  assign store_test_index = 8'h0; // @[Mem_stage.scala 171:35]
  assign store_test_valid = REG_2; // @[Mem_stage.scala 172:35]
  assign store_test_storeAddr = REG_5; // @[Mem_stage.scala 173:35]
  assign store_test_storeData = REG_8; // @[Mem_stage.scala 174:35]
  assign store_test_storeMask = REG_11[7:0]; // @[Mem_stage.scala 175:35]
  always @(posedge clock) begin
    if (~io_inst_valid) begin // @[Mem_stage.scala 142:24]
      REG <= 1'h0;
    end else begin
      REG <= _wr_en_T_8;
    end
    REG_1 <= REG; // @[Mem_stage.scala 172:53]
    REG_2 <= REG_1; // @[Mem_stage.scala 172:45]
    REG_3 <= io_wb_data; // @[Mem_stage.scala 173:61]
    REG_4 <= REG_3; // @[Mem_stage.scala 173:53]
    REG_5 <= REG_4; // @[Mem_stage.scala 173:45]
    if (8'haa == io_fu_op_type) begin // @[Mux.scala 80:57]
      REG_6 <= io_op2;
    end else if (8'ha9 == io_fu_op_type) begin // @[Mux.scala 80:57]
      if (_T_14) begin // @[Conditional.scala 40:58]
        REG_6 <= _wr_data_w_T; // @[Mem_stage.scala 126:153]
      end else if (rd_sel[2]) begin // @[Conditional.scala 39:67]
        REG_6 <= _wr_data_w_T_1; // @[Mem_stage.scala 127:153]
      end else begin
        REG_6 <= 64'h0;
      end
    end else if (8'ha8 == io_fu_op_type) begin // @[Mux.scala 80:57]
      if (_T_9) begin // @[Conditional.scala 40:58]
        REG_6 <= _wr_data_h_T; // @[Mem_stage.scala 120:161]
      end else begin
        REG_6 <= _GEN_46;
      end
    end else if (8'ha7 == io_fu_op_type) begin // @[Mux.scala 80:57]
      REG_6 <= wr_data_b;
    end else begin
      REG_6 <= 64'h0;
    end
    REG_7 <= REG_6; // @[Mem_stage.scala 174:53]
    REG_8 <= REG_7; // @[Mem_stage.scala 174:45]
    if (8'haa == io_fu_op_type) begin // @[Mux.scala 80:57]
      REG_9 <= 64'hff;
    end else if (8'ha9 == io_fu_op_type) begin // @[Mux.scala 80:57]
      REG_9 <= {{56'd0}, store_mask_w};
    end else if (8'ha8 == io_fu_op_type) begin // @[Mux.scala 80:57]
      REG_9 <= {{56'd0}, store_mask_h};
    end else if (8'ha7 == io_fu_op_type) begin // @[Mux.scala 80:57]
      REG_9 <= {{56'd0}, store_mask_b};
    end else begin
      REG_9 <= 64'hffffffffffffffff;
    end
    REG_10 <= REG_9; // @[Mem_stage.scala 175:53]
    REG_11 <= REG_10; // @[Mem_stage.scala 175:45]
    io_wb_addr_o_REG <= io_wb_addr; // @[Mem_stage.scala 177:40]
    io_wb_en_o_REG <= io_wb_en; // @[Mem_stage.scala 178:48]
    if (8'ha6 == io_fu_op_type) begin // @[Mux.scala 80:57]
      io_wb_data_o_REG <= _wb_data_o_T_9;
    end else if (8'ha5 == io_fu_op_type) begin // @[Mux.scala 80:57]
      io_wb_data_o_REG <= _wb_data_o_T_8;
    end else if (8'ha4 == io_fu_op_type) begin // @[Mux.scala 80:57]
      io_wb_data_o_REG <= _wb_data_o_T_7;
    end else if (8'ha3 == io_fu_op_type) begin // @[Mux.scala 80:57]
      io_wb_data_o_REG <= io_rd_data;
    end else begin
      io_wb_data_o_REG <= _wb_data_o_T_15;
    end
    io_pc_o_REG <= io_pc; // @[Mem_stage.scala 189:48]
    io_inst_o_REG <= io_inst; // @[Mem_stage.scala 190:48]
    io_inst_valid_o_REG <= io_inst_valid; // @[Mem_stage.scala 191:40]
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
  REG = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  REG_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  REG_2 = _RAND_2[0:0];
  _RAND_3 = {2{`RANDOM}};
  REG_3 = _RAND_3[63:0];
  _RAND_4 = {2{`RANDOM}};
  REG_4 = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  REG_5 = _RAND_5[63:0];
  _RAND_6 = {2{`RANDOM}};
  REG_6 = _RAND_6[63:0];
  _RAND_7 = {2{`RANDOM}};
  REG_7 = _RAND_7[63:0];
  _RAND_8 = {2{`RANDOM}};
  REG_8 = _RAND_8[63:0];
  _RAND_9 = {2{`RANDOM}};
  REG_9 = _RAND_9[63:0];
  _RAND_10 = {2{`RANDOM}};
  REG_10 = _RAND_10[63:0];
  _RAND_11 = {2{`RANDOM}};
  REG_11 = _RAND_11[63:0];
  _RAND_12 = {1{`RANDOM}};
  io_wb_addr_o_REG = _RAND_12[4:0];
  _RAND_13 = {1{`RANDOM}};
  io_wb_en_o_REG = _RAND_13[0:0];
  _RAND_14 = {2{`RANDOM}};
  io_wb_data_o_REG = _RAND_14[63:0];
  _RAND_15 = {2{`RANDOM}};
  io_pc_o_REG = _RAND_15[63:0];
  _RAND_16 = {1{`RANDOM}};
  io_inst_o_REG = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  io_inst_valid_o_REG = _RAND_17[0:0];
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
  input         reset,
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
  wire  mod_clock; // @[Reg_file.scala 30:25]
  wire [7:0] mod_coreid; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_0; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_1; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_2; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_3; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_4; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_5; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_6; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_7; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_8; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_9; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_10; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_11; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_12; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_13; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_14; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_15; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_16; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_17; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_18; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_19; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_20; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_21; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_22; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_23; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_24; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_25; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_26; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_27; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_28; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_29; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_30; // @[Reg_file.scala 30:25]
  wire [63:0] mod_gpr_31; // @[Reg_file.scala 30:25]
  wire  csr_clock; // @[Reg_file.scala 35:21]
  wire [7:0] csr_coreid; // @[Reg_file.scala 35:21]
  wire [1:0] csr_priviledgeMode; // @[Reg_file.scala 35:21]
  wire [63:0] csr_mstatus; // @[Reg_file.scala 35:21]
  wire [63:0] csr_sstatus; // @[Reg_file.scala 35:21]
  wire [63:0] csr_mepc; // @[Reg_file.scala 35:21]
  wire [63:0] csr_sepc; // @[Reg_file.scala 35:21]
  wire [63:0] csr_mtval; // @[Reg_file.scala 35:21]
  wire [63:0] csr_stval; // @[Reg_file.scala 35:21]
  wire [63:0] csr_mtvec; // @[Reg_file.scala 35:21]
  wire [63:0] csr_stvec; // @[Reg_file.scala 35:21]
  wire [63:0] csr_mcause; // @[Reg_file.scala 35:21]
  wire [63:0] csr_scause; // @[Reg_file.scala 35:21]
  wire [63:0] csr_satp; // @[Reg_file.scala 35:21]
  wire [63:0] csr_mip; // @[Reg_file.scala 35:21]
  wire [63:0] csr_mie; // @[Reg_file.scala 35:21]
  wire [63:0] csr_mscratch; // @[Reg_file.scala 35:21]
  wire [63:0] csr_sscratch; // @[Reg_file.scala 35:21]
  wire [63:0] csr_mideleg; // @[Reg_file.scala 35:21]
  wire [63:0] csr_medeleg; // @[Reg_file.scala 35:21]
  wire  fp_clock; // @[Reg_file.scala 57:24]
  wire [7:0] fp_coreid; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_0; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_1; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_2; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_3; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_4; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_5; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_6; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_7; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_8; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_9; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_10; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_11; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_12; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_13; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_14; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_15; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_16; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_17; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_18; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_19; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_20; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_21; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_22; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_23; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_24; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_25; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_26; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_27; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_28; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_29; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_30; // @[Reg_file.scala 57:24]
  wire [63:0] fp_fpr_31; // @[Reg_file.scala 57:24]
  reg [63:0] registers_0; // @[Reg_file.scala 18:32]
  reg [63:0] registers_1; // @[Reg_file.scala 18:32]
  reg [63:0] registers_2; // @[Reg_file.scala 18:32]
  reg [63:0] registers_3; // @[Reg_file.scala 18:32]
  reg [63:0] registers_4; // @[Reg_file.scala 18:32]
  reg [63:0] registers_5; // @[Reg_file.scala 18:32]
  reg [63:0] registers_6; // @[Reg_file.scala 18:32]
  reg [63:0] registers_7; // @[Reg_file.scala 18:32]
  reg [63:0] registers_8; // @[Reg_file.scala 18:32]
  reg [63:0] registers_9; // @[Reg_file.scala 18:32]
  reg [63:0] registers_10; // @[Reg_file.scala 18:32]
  reg [63:0] registers_11; // @[Reg_file.scala 18:32]
  reg [63:0] registers_12; // @[Reg_file.scala 18:32]
  reg [63:0] registers_13; // @[Reg_file.scala 18:32]
  reg [63:0] registers_14; // @[Reg_file.scala 18:32]
  reg [63:0] registers_15; // @[Reg_file.scala 18:32]
  reg [63:0] registers_16; // @[Reg_file.scala 18:32]
  reg [63:0] registers_17; // @[Reg_file.scala 18:32]
  reg [63:0] registers_18; // @[Reg_file.scala 18:32]
  reg [63:0] registers_19; // @[Reg_file.scala 18:32]
  reg [63:0] registers_20; // @[Reg_file.scala 18:32]
  reg [63:0] registers_21; // @[Reg_file.scala 18:32]
  reg [63:0] registers_22; // @[Reg_file.scala 18:32]
  reg [63:0] registers_23; // @[Reg_file.scala 18:32]
  reg [63:0] registers_24; // @[Reg_file.scala 18:32]
  reg [63:0] registers_25; // @[Reg_file.scala 18:32]
  reg [63:0] registers_26; // @[Reg_file.scala 18:32]
  reg [63:0] registers_27; // @[Reg_file.scala 18:32]
  reg [63:0] registers_28; // @[Reg_file.scala 18:32]
  reg [63:0] registers_29; // @[Reg_file.scala 18:32]
  reg [63:0] registers_30; // @[Reg_file.scala 18:32]
  reg [63:0] registers_31; // @[Reg_file.scala 18:32]
  wire  r1_conflict = io_w_en & io_w_addr == io_r1_addr; // @[Reg_file.scala 20:46]
  wire  r2_conflict = io_w_en & io_w_addr == io_r2_addr; // @[Reg_file.scala 21:46]
  wire [63:0] _GEN_1 = 5'h1 == io_r1_addr ? registers_1 : registers_0; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_2 = 5'h2 == io_r1_addr ? registers_2 : _GEN_1; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_3 = 5'h3 == io_r1_addr ? registers_3 : _GEN_2; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_4 = 5'h4 == io_r1_addr ? registers_4 : _GEN_3; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_5 = 5'h5 == io_r1_addr ? registers_5 : _GEN_4; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_6 = 5'h6 == io_r1_addr ? registers_6 : _GEN_5; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_7 = 5'h7 == io_r1_addr ? registers_7 : _GEN_6; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_8 = 5'h8 == io_r1_addr ? registers_8 : _GEN_7; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_9 = 5'h9 == io_r1_addr ? registers_9 : _GEN_8; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_10 = 5'ha == io_r1_addr ? registers_10 : _GEN_9; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_11 = 5'hb == io_r1_addr ? registers_11 : _GEN_10; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_12 = 5'hc == io_r1_addr ? registers_12 : _GEN_11; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_13 = 5'hd == io_r1_addr ? registers_13 : _GEN_12; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_14 = 5'he == io_r1_addr ? registers_14 : _GEN_13; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_15 = 5'hf == io_r1_addr ? registers_15 : _GEN_14; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_16 = 5'h10 == io_r1_addr ? registers_16 : _GEN_15; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_17 = 5'h11 == io_r1_addr ? registers_17 : _GEN_16; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_18 = 5'h12 == io_r1_addr ? registers_18 : _GEN_17; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_19 = 5'h13 == io_r1_addr ? registers_19 : _GEN_18; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_20 = 5'h14 == io_r1_addr ? registers_20 : _GEN_19; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_21 = 5'h15 == io_r1_addr ? registers_21 : _GEN_20; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_22 = 5'h16 == io_r1_addr ? registers_22 : _GEN_21; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_23 = 5'h17 == io_r1_addr ? registers_23 : _GEN_22; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_24 = 5'h18 == io_r1_addr ? registers_24 : _GEN_23; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_25 = 5'h19 == io_r1_addr ? registers_25 : _GEN_24; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_26 = 5'h1a == io_r1_addr ? registers_26 : _GEN_25; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_27 = 5'h1b == io_r1_addr ? registers_27 : _GEN_26; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_28 = 5'h1c == io_r1_addr ? registers_28 : _GEN_27; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_29 = 5'h1d == io_r1_addr ? registers_29 : _GEN_28; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_30 = 5'h1e == io_r1_addr ? registers_30 : _GEN_29; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_31 = 5'h1f == io_r1_addr ? registers_31 : _GEN_30; // @[Reg_file.scala 23:44 Reg_file.scala 23:44]
  wire [63:0] _GEN_33 = 5'h1 == io_r2_addr ? registers_1 : registers_0; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_34 = 5'h2 == io_r2_addr ? registers_2 : _GEN_33; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_35 = 5'h3 == io_r2_addr ? registers_3 : _GEN_34; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_36 = 5'h4 == io_r2_addr ? registers_4 : _GEN_35; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_37 = 5'h5 == io_r2_addr ? registers_5 : _GEN_36; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_38 = 5'h6 == io_r2_addr ? registers_6 : _GEN_37; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_39 = 5'h7 == io_r2_addr ? registers_7 : _GEN_38; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_40 = 5'h8 == io_r2_addr ? registers_8 : _GEN_39; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_41 = 5'h9 == io_r2_addr ? registers_9 : _GEN_40; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_42 = 5'ha == io_r2_addr ? registers_10 : _GEN_41; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_43 = 5'hb == io_r2_addr ? registers_11 : _GEN_42; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_44 = 5'hc == io_r2_addr ? registers_12 : _GEN_43; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_45 = 5'hd == io_r2_addr ? registers_13 : _GEN_44; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_46 = 5'he == io_r2_addr ? registers_14 : _GEN_45; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_47 = 5'hf == io_r2_addr ? registers_15 : _GEN_46; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_48 = 5'h10 == io_r2_addr ? registers_16 : _GEN_47; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_49 = 5'h11 == io_r2_addr ? registers_17 : _GEN_48; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_50 = 5'h12 == io_r2_addr ? registers_18 : _GEN_49; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_51 = 5'h13 == io_r2_addr ? registers_19 : _GEN_50; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_52 = 5'h14 == io_r2_addr ? registers_20 : _GEN_51; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_53 = 5'h15 == io_r2_addr ? registers_21 : _GEN_52; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_54 = 5'h16 == io_r2_addr ? registers_22 : _GEN_53; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_55 = 5'h17 == io_r2_addr ? registers_23 : _GEN_54; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_56 = 5'h18 == io_r2_addr ? registers_24 : _GEN_55; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_57 = 5'h19 == io_r2_addr ? registers_25 : _GEN_56; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_58 = 5'h1a == io_r2_addr ? registers_26 : _GEN_57; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_59 = 5'h1b == io_r2_addr ? registers_27 : _GEN_58; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_60 = 5'h1c == io_r2_addr ? registers_28 : _GEN_59; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_61 = 5'h1d == io_r2_addr ? registers_29 : _GEN_60; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_62 = 5'h1e == io_r2_addr ? registers_30 : _GEN_61; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  wire [63:0] _GEN_63 = 5'h1f == io_r2_addr ? registers_31 : _GEN_62; // @[Reg_file.scala 24:44 Reg_file.scala 24:44]
  DifftestArchIntRegState mod ( // @[Reg_file.scala 30:25]
    .clock(mod_clock),
    .coreid(mod_coreid),
    .gpr_0(mod_gpr_0),
    .gpr_1(mod_gpr_1),
    .gpr_2(mod_gpr_2),
    .gpr_3(mod_gpr_3),
    .gpr_4(mod_gpr_4),
    .gpr_5(mod_gpr_5),
    .gpr_6(mod_gpr_6),
    .gpr_7(mod_gpr_7),
    .gpr_8(mod_gpr_8),
    .gpr_9(mod_gpr_9),
    .gpr_10(mod_gpr_10),
    .gpr_11(mod_gpr_11),
    .gpr_12(mod_gpr_12),
    .gpr_13(mod_gpr_13),
    .gpr_14(mod_gpr_14),
    .gpr_15(mod_gpr_15),
    .gpr_16(mod_gpr_16),
    .gpr_17(mod_gpr_17),
    .gpr_18(mod_gpr_18),
    .gpr_19(mod_gpr_19),
    .gpr_20(mod_gpr_20),
    .gpr_21(mod_gpr_21),
    .gpr_22(mod_gpr_22),
    .gpr_23(mod_gpr_23),
    .gpr_24(mod_gpr_24),
    .gpr_25(mod_gpr_25),
    .gpr_26(mod_gpr_26),
    .gpr_27(mod_gpr_27),
    .gpr_28(mod_gpr_28),
    .gpr_29(mod_gpr_29),
    .gpr_30(mod_gpr_30),
    .gpr_31(mod_gpr_31)
  );
  DifftestCSRState csr ( // @[Reg_file.scala 35:21]
    .clock(csr_clock),
    .coreid(csr_coreid),
    .priviledgeMode(csr_priviledgeMode),
    .mstatus(csr_mstatus),
    .sstatus(csr_sstatus),
    .mepc(csr_mepc),
    .sepc(csr_sepc),
    .mtval(csr_mtval),
    .stval(csr_stval),
    .mtvec(csr_mtvec),
    .stvec(csr_stvec),
    .mcause(csr_mcause),
    .scause(csr_scause),
    .satp(csr_satp),
    .mip(csr_mip),
    .mie(csr_mie),
    .mscratch(csr_mscratch),
    .sscratch(csr_sscratch),
    .mideleg(csr_mideleg),
    .medeleg(csr_medeleg)
  );
  DifftestArchFpRegState fp ( // @[Reg_file.scala 57:24]
    .clock(fp_clock),
    .coreid(fp_coreid),
    .fpr_0(fp_fpr_0),
    .fpr_1(fp_fpr_1),
    .fpr_2(fp_fpr_2),
    .fpr_3(fp_fpr_3),
    .fpr_4(fp_fpr_4),
    .fpr_5(fp_fpr_5),
    .fpr_6(fp_fpr_6),
    .fpr_7(fp_fpr_7),
    .fpr_8(fp_fpr_8),
    .fpr_9(fp_fpr_9),
    .fpr_10(fp_fpr_10),
    .fpr_11(fp_fpr_11),
    .fpr_12(fp_fpr_12),
    .fpr_13(fp_fpr_13),
    .fpr_14(fp_fpr_14),
    .fpr_15(fp_fpr_15),
    .fpr_16(fp_fpr_16),
    .fpr_17(fp_fpr_17),
    .fpr_18(fp_fpr_18),
    .fpr_19(fp_fpr_19),
    .fpr_20(fp_fpr_20),
    .fpr_21(fp_fpr_21),
    .fpr_22(fp_fpr_22),
    .fpr_23(fp_fpr_23),
    .fpr_24(fp_fpr_24),
    .fpr_25(fp_fpr_25),
    .fpr_26(fp_fpr_26),
    .fpr_27(fp_fpr_27),
    .fpr_28(fp_fpr_28),
    .fpr_29(fp_fpr_29),
    .fpr_30(fp_fpr_30),
    .fpr_31(fp_fpr_31)
  );
  assign io_r1_data = r1_conflict ? io_w_data : _GEN_31; // @[Reg_file.scala 23:44]
  assign io_r2_data = r2_conflict ? io_w_data : _GEN_63; // @[Reg_file.scala 24:44]
  assign mod_clock = clock; // @[Reg_file.scala 31:22]
  assign mod_coreid = 8'h0; // @[Reg_file.scala 32:23]
  assign mod_gpr_0 = registers_0; // @[Reg_file.scala 33:20]
  assign mod_gpr_1 = registers_1; // @[Reg_file.scala 33:20]
  assign mod_gpr_2 = registers_2; // @[Reg_file.scala 33:20]
  assign mod_gpr_3 = registers_3; // @[Reg_file.scala 33:20]
  assign mod_gpr_4 = registers_4; // @[Reg_file.scala 33:20]
  assign mod_gpr_5 = registers_5; // @[Reg_file.scala 33:20]
  assign mod_gpr_6 = registers_6; // @[Reg_file.scala 33:20]
  assign mod_gpr_7 = registers_7; // @[Reg_file.scala 33:20]
  assign mod_gpr_8 = registers_8; // @[Reg_file.scala 33:20]
  assign mod_gpr_9 = registers_9; // @[Reg_file.scala 33:20]
  assign mod_gpr_10 = registers_10; // @[Reg_file.scala 33:20]
  assign mod_gpr_11 = registers_11; // @[Reg_file.scala 33:20]
  assign mod_gpr_12 = registers_12; // @[Reg_file.scala 33:20]
  assign mod_gpr_13 = registers_13; // @[Reg_file.scala 33:20]
  assign mod_gpr_14 = registers_14; // @[Reg_file.scala 33:20]
  assign mod_gpr_15 = registers_15; // @[Reg_file.scala 33:20]
  assign mod_gpr_16 = registers_16; // @[Reg_file.scala 33:20]
  assign mod_gpr_17 = registers_17; // @[Reg_file.scala 33:20]
  assign mod_gpr_18 = registers_18; // @[Reg_file.scala 33:20]
  assign mod_gpr_19 = registers_19; // @[Reg_file.scala 33:20]
  assign mod_gpr_20 = registers_20; // @[Reg_file.scala 33:20]
  assign mod_gpr_21 = registers_21; // @[Reg_file.scala 33:20]
  assign mod_gpr_22 = registers_22; // @[Reg_file.scala 33:20]
  assign mod_gpr_23 = registers_23; // @[Reg_file.scala 33:20]
  assign mod_gpr_24 = registers_24; // @[Reg_file.scala 33:20]
  assign mod_gpr_25 = registers_25; // @[Reg_file.scala 33:20]
  assign mod_gpr_26 = registers_26; // @[Reg_file.scala 33:20]
  assign mod_gpr_27 = registers_27; // @[Reg_file.scala 33:20]
  assign mod_gpr_28 = registers_28; // @[Reg_file.scala 33:20]
  assign mod_gpr_29 = registers_29; // @[Reg_file.scala 33:20]
  assign mod_gpr_30 = registers_30; // @[Reg_file.scala 33:20]
  assign mod_gpr_31 = registers_31; // @[Reg_file.scala 33:20]
  assign csr_clock = clock; // @[Reg_file.scala 36:18]
  assign csr_coreid = 8'h0; // @[Reg_file.scala 37:19]
  assign csr_priviledgeMode = 2'h0; // @[Reg_file.scala 55:27]
  assign csr_mstatus = 64'h0; // @[Reg_file.scala 38:20]
  assign csr_sstatus = 64'h0; // @[Reg_file.scala 41:20]
  assign csr_mepc = 64'h0; // @[Reg_file.scala 40:17]
  assign csr_sepc = 64'h0; // @[Reg_file.scala 43:17]
  assign csr_mtval = 64'h0; // @[Reg_file.scala 51:17]
  assign csr_stval = 64'h0; // @[Reg_file.scala 52:17]
  assign csr_mtvec = 64'h0; // @[Reg_file.scala 53:18]
  assign csr_stvec = 64'h0; // @[Reg_file.scala 54:18]
  assign csr_mcause = 64'h0; // @[Reg_file.scala 39:19]
  assign csr_scause = 64'h0; // @[Reg_file.scala 42:19]
  assign csr_satp = 64'h0; // @[Reg_file.scala 44:17]
  assign csr_mip = 64'h0; // @[Reg_file.scala 45:16]
  assign csr_mie = 64'h0; // @[Reg_file.scala 46:16]
  assign csr_mscratch = 64'h0; // @[Reg_file.scala 47:21]
  assign csr_sscratch = 64'h0; // @[Reg_file.scala 48:21]
  assign csr_mideleg = 64'h0; // @[Reg_file.scala 49:20]
  assign csr_medeleg = 64'h0; // @[Reg_file.scala 50:20]
  assign fp_clock = clock; // @[Reg_file.scala 58:33]
  assign fp_coreid = 8'h0; // @[Reg_file.scala 59:25]
  assign fp_fpr_0 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_1 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_2 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_3 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_4 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_5 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_6 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_7 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_8 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_9 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_10 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_11 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_12 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_13 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_14 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_15 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_16 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_17 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_18 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_19 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_20 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_21 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_22 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_23 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_24 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_25 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_26 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_27 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_28 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_29 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_30 = 64'h0; // @[Reg_file.scala 60:33]
  assign fp_fpr_31 = 64'h0; // @[Reg_file.scala 60:33]
  always @(posedge clock) begin
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_0 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'h0 == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_0 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_1 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'h1 == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_1 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_2 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'h2 == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_2 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_3 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'h3 == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_3 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_4 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'h4 == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_4 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_5 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'h5 == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_5 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_6 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'h6 == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_6 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_7 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'h7 == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_7 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_8 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'h8 == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_8 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_9 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'h9 == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_9 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_10 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'ha == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_10 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_11 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'hb == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_11 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_12 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'hc == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_12 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_13 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'hd == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_13 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_14 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'he == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_14 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_15 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'hf == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_15 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_16 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'h10 == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_16 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_17 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'h11 == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_17 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_18 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'h12 == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_18 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_19 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'h13 == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_19 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_20 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'h14 == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_20 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_21 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'h15 == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_21 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_22 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'h16 == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_22 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_23 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'h17 == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_23 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_24 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'h18 == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_24 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_25 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'h19 == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_25 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_26 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'h1a == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_26 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_27 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'h1b == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_27 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_28 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'h1c == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_28 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_29 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'h1d == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_29 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_30 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'h1e == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_30 <= io_w_data; // @[Reg_file.scala 27:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_31 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 26:22]
      if (5'h1f == io_w_addr) begin // @[Reg_file.scala 27:38]
        registers_31 <= io_w_data; // @[Reg_file.scala 27:38]
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
module Stall(
  output [1:0] io_ctrl_if,
  output [1:0] io_ctrl_id,
  output [1:0] io_ctrl_exe,
  input        id_jmp,
  input        id_alu_conlict_0,
  input        id_load_conflict_0,
  input        exe_ld_conflict
);
  wire [1:0] _GEN_0 = id_jmp ? 2'h2 : 2'h0; // @[Stall_control.scala 41:33 Stall_control.scala 42:41 Stall_control.scala 46:41]
  wire [1:0] _GEN_2 = id_alu_conlict_0 | id_load_conflict_0 ? 2'h1 : _GEN_0; // @[Stall_control.scala 37:55 Stall_control.scala 38:41]
  wire [1:0] _GEN_3 = id_alu_conlict_0 | id_load_conflict_0 ? 2'h2 : 2'h0; // @[Stall_control.scala 37:55 Stall_control.scala 39:41]
  assign io_ctrl_if = exe_ld_conflict ? 2'h1 : _GEN_2; // @[Stall_control.scala 33:26 Stall_control.scala 34:41]
  assign io_ctrl_id = exe_ld_conflict ? 2'h1 : _GEN_3; // @[Stall_control.scala 33:26 Stall_control.scala 35:41]
  assign io_ctrl_exe = {{1'd0}, exe_ld_conflict}; // @[Stall_control.scala 33:26 Stall_control.scala 36:41]
endmodule
module Top(
  input         clock,
  input         reset,
  output [63:0] io_inst_ram_rIdx,
  input  [63:0] io_inst_ram_rdata,
  output [63:0] io_inst_ram_wIdx,
  output [63:0] io_inst_ram_wdata,
  output [63:0] io_inst_ram_wmask,
  output        io_inst_ram_wen,
  output        io_data_ram_en,
  output [63:0] io_data_ram_rIdx,
  input  [63:0] io_data_ram_rdata,
  output [63:0] io_data_ram_wIdx,
  output [63:0] io_data_ram_wdata,
  output [63:0] io_data_ram_wmask,
  output        io_data_ram_wen
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  wire  m_if_clock; // @[Top.scala 29:47]
  wire  m_if_reset; // @[Top.scala 29:47]
  wire [63:0] m_if_io_pc_c; // @[Top.scala 29:47]
  wire [63:0] m_if_io_inst; // @[Top.scala 29:47]
  wire [31:0] m_if_io_inst_o; // @[Top.scala 29:47]
  wire  m_if_io_inst_valid_o; // @[Top.scala 29:47]
  wire [63:0] m_if_io_pc_o; // @[Top.scala 29:47]
  wire [1:0] m_if_io_ctrl; // @[Top.scala 29:47]
  wire [63:0] m_if_io_jmp_addr; // @[Top.scala 29:47]
  wire  m_id_clock; // @[Top.scala 30:47]
  wire  m_id_reset; // @[Top.scala 30:47]
  wire [31:0] m_id_io_inst; // @[Top.scala 30:47]
  wire  m_id_io_inst_valid; // @[Top.scala 30:47]
  wire [63:0] m_id_io_pc; // @[Top.scala 30:47]
  wire [1:0] m_id_io_ctrl; // @[Top.scala 30:47]
  wire [4:0] m_id_io_rs1_c; // @[Top.scala 30:47]
  wire [4:0] m_id_io_rs2_c; // @[Top.scala 30:47]
  wire  m_id_io_rs1_en_c; // @[Top.scala 30:47]
  wire  m_id_io_rs2_en_c; // @[Top.scala 30:47]
  wire [63:0] m_id_io_rs1_data; // @[Top.scala 30:47]
  wire [63:0] m_id_io_rs2_data; // @[Top.scala 30:47]
  wire [4:0] m_id_io_rs1_o; // @[Top.scala 30:47]
  wire [4:0] m_id_io_rs2_o; // @[Top.scala 30:47]
  wire  m_id_io_rs1_en_o; // @[Top.scala 30:47]
  wire  m_id_io_rs2_en_o; // @[Top.scala 30:47]
  wire [63:0] m_id_io_op1_o; // @[Top.scala 30:47]
  wire [63:0] m_id_io_op2_o; // @[Top.scala 30:47]
  wire [63:0] m_id_io_imm_o; // @[Top.scala 30:47]
  wire [4:0] m_id_io_wb_addr_o; // @[Top.scala 30:47]
  wire  m_id_io_wb_en_o; // @[Top.scala 30:47]
  wire [7:0] m_id_io_fu_op_type_o; // @[Top.scala 30:47]
  wire [31:0] m_id_io_inst_o; // @[Top.scala 30:47]
  wire  m_id_io_inst_valid_o; // @[Top.scala 30:47]
  wire [63:0] m_id_io_pc_o; // @[Top.scala 30:47]
  wire [63:0] m_id_io_jmp_addr; // @[Top.scala 30:47]
  wire  m_id_jmp_0; // @[Top.scala 30:47]
  wire [4:0] m_id_exe_wb_addr_o; // @[Top.scala 30:47]
  wire  m_id_id_alu_conlict_0; // @[Top.scala 30:47]
  wire  m_id_id_load_conflict_0; // @[Top.scala 30:47]
  wire [63:0] m_id_exe_wb_data_o; // @[Top.scala 30:47]
  wire  m_id_exe_wb_en_o; // @[Top.scala 30:47]
  wire  m_id_exe_inst_valid_o; // @[Top.scala 30:47]
  wire  m_exe_clock; // @[Top.scala 31:47]
  wire  m_exe_reset; // @[Top.scala 31:47]
  wire [4:0] m_exe_io__rs1; // @[Top.scala 31:47]
  wire [4:0] m_exe_io__rs2; // @[Top.scala 31:47]
  wire  m_exe_io__rs1_en; // @[Top.scala 31:47]
  wire  m_exe_io__rs2_en; // @[Top.scala 31:47]
  wire [4:0] m_exe_io__by_wb_addr; // @[Top.scala 31:47]
  wire  m_exe_io__by_wb_en; // @[Top.scala 31:47]
  wire [63:0] m_exe_io__by_wb_data; // @[Top.scala 31:47]
  wire [1:0] m_exe_io__ctrl; // @[Top.scala 31:47]
  wire [63:0] m_exe_io__op1; // @[Top.scala 31:47]
  wire [63:0] m_exe_io__op2; // @[Top.scala 31:47]
  wire [63:0] m_exe_io__imm; // @[Top.scala 31:47]
  wire [7:0] m_exe_io__fu_op_type; // @[Top.scala 31:47]
  wire [31:0] m_exe_io__inst; // @[Top.scala 31:47]
  wire  m_exe_io__inst_valid; // @[Top.scala 31:47]
  wire [63:0] m_exe_io__pc; // @[Top.scala 31:47]
  wire [4:0] m_exe_io__wb_addr; // @[Top.scala 31:47]
  wire  m_exe_io__wb_en; // @[Top.scala 31:47]
  wire [31:0] m_exe_io__inst_o; // @[Top.scala 31:47]
  wire  m_exe_io__inst_valid_o; // @[Top.scala 31:47]
  wire [63:0] m_exe_io__pc_o; // @[Top.scala 31:47]
  wire [7:0] m_exe_io__fu_op_type_o; // @[Top.scala 31:47]
  wire [63:0] m_exe_io__op2_o; // @[Top.scala 31:47]
  wire [4:0] m_exe_io__wb_addr_o; // @[Top.scala 31:47]
  wire  m_exe_io__wb_en_o; // @[Top.scala 31:47]
  wire [63:0] m_exe_io__wb_data_o; // @[Top.scala 31:47]
  wire [4:0] m_exe_io_wb_addr_o; // @[Top.scala 31:47]
  wire [63:0] m_exe_io_wb_data_o; // @[Top.scala 31:47]
  wire  m_exe_io_wb_en_o; // @[Top.scala 31:47]
  wire  m_exe_io_inst_valid_o; // @[Top.scala 31:47]
  wire  m_exe_ld_conflict_0; // @[Top.scala 31:47]
  wire  m_ls_clock; // @[Top.scala 32:47]
  wire [4:0] m_ls_io_wb_addr; // @[Top.scala 32:47]
  wire  m_ls_io_wb_en; // @[Top.scala 32:47]
  wire [63:0] m_ls_io_wb_data; // @[Top.scala 32:47]
  wire [63:0] m_ls_io_op2; // @[Top.scala 32:47]
  wire [7:0] m_ls_io_fu_op_type; // @[Top.scala 32:47]
  wire [31:0] m_ls_io_inst; // @[Top.scala 32:47]
  wire  m_ls_io_inst_valid; // @[Top.scala 32:47]
  wire [63:0] m_ls_io_pc; // @[Top.scala 32:47]
  wire [31:0] m_ls_io_inst_o; // @[Top.scala 32:47]
  wire  m_ls_io_inst_valid_o; // @[Top.scala 32:47]
  wire [63:0] m_ls_io_pc_o; // @[Top.scala 32:47]
  wire [4:0] m_ls_io_wb_addr_o; // @[Top.scala 32:47]
  wire  m_ls_io_wb_en_o; // @[Top.scala 32:47]
  wire [63:0] m_ls_io_wb_data_o; // @[Top.scala 32:47]
  wire [63:0] m_ls_io_wr_mask; // @[Top.scala 32:47]
  wire [63:0] m_ls_io_wr_idx; // @[Top.scala 32:47]
  wire [63:0] m_ls_io_rd_idx; // @[Top.scala 32:47]
  wire  m_ls_io_rd_en; // @[Top.scala 32:47]
  wire  m_ls_io_wr_en; // @[Top.scala 32:47]
  wire [63:0] m_ls_io_wr_data; // @[Top.scala 32:47]
  wire [63:0] m_ls_io_rd_data; // @[Top.scala 32:47]
  wire  m_regfile_clock; // @[Top.scala 33:39]
  wire  m_regfile_reset; // @[Top.scala 33:39]
  wire [4:0] m_regfile_io_w_addr; // @[Top.scala 33:39]
  wire [63:0] m_regfile_io_w_data; // @[Top.scala 33:39]
  wire  m_regfile_io_w_en; // @[Top.scala 33:39]
  wire [4:0] m_regfile_io_r1_addr; // @[Top.scala 33:39]
  wire [63:0] m_regfile_io_r1_data; // @[Top.scala 33:39]
  wire [4:0] m_regfile_io_r2_addr; // @[Top.scala 33:39]
  wire [63:0] m_regfile_io_r2_data; // @[Top.scala 33:39]
  wire [1:0] m_ctrl_io_ctrl_if; // @[Top.scala 34:47]
  wire [1:0] m_ctrl_io_ctrl_id; // @[Top.scala 34:47]
  wire [1:0] m_ctrl_io_ctrl_exe; // @[Top.scala 34:47]
  wire  m_ctrl_id_jmp; // @[Top.scala 34:47]
  wire  m_ctrl_id_alu_conlict_0; // @[Top.scala 34:47]
  wire  m_ctrl_id_load_conflict_0; // @[Top.scala 34:47]
  wire  m_ctrl_exe_ld_conflict; // @[Top.scala 34:47]
  wire  commit_clock; // @[Top.scala 111:28]
  wire [7:0] commit_coreid; // @[Top.scala 111:28]
  wire [7:0] commit_index; // @[Top.scala 111:28]
  wire  commit_valid; // @[Top.scala 111:28]
  wire [63:0] commit_pc; // @[Top.scala 111:28]
  wire [31:0] commit_instr; // @[Top.scala 111:28]
  wire  commit_skip; // @[Top.scala 111:28]
  wire  commit_isRVC; // @[Top.scala 111:28]
  wire  commit_scFailed; // @[Top.scala 111:28]
  wire  commit_wen; // @[Top.scala 111:28]
  wire [63:0] commit_wdata; // @[Top.scala 111:28]
  wire [7:0] commit_wdest; // @[Top.scala 111:28]
  wire  trap_clock; // @[Top.scala 129:26]
  wire [7:0] trap_coreid; // @[Top.scala 129:26]
  wire  trap_valid; // @[Top.scala 129:26]
  wire [2:0] trap_code; // @[Top.scala 129:26]
  wire [63:0] trap_pc; // @[Top.scala 129:26]
  wire [63:0] trap_cycleCnt; // @[Top.scala 129:26]
  wire [63:0] trap_instrCnt; // @[Top.scala 129:26]
  reg  REG; // @[Top.scala 116:43]
  reg [63:0] REG_1; // @[Top.scala 117:43]
  reg [31:0] REG_2; // @[Top.scala 118:43]
  reg  REG_3; // @[Top.scala 122:43]
  reg [63:0] REG_4; // @[Top.scala 123:43]
  reg [4:0] REG_5; // @[Top.scala 124:43]
  reg [31:0] cycleCnt; // @[Top.scala 126:31]
  wire [31:0] _cycleCnt_T_1 = cycleCnt + 32'h1; // @[Top.scala 127:30]
  If m_if ( // @[Top.scala 29:47]
    .clock(m_if_clock),
    .reset(m_if_reset),
    .io_pc_c(m_if_io_pc_c),
    .io_inst(m_if_io_inst),
    .io_inst_o(m_if_io_inst_o),
    .io_inst_valid_o(m_if_io_inst_valid_o),
    .io_pc_o(m_if_io_pc_o),
    .io_ctrl(m_if_io_ctrl),
    .io_jmp_addr(m_if_io_jmp_addr)
  );
  Id m_id ( // @[Top.scala 30:47]
    .clock(m_id_clock),
    .reset(m_id_reset),
    .io_inst(m_id_io_inst),
    .io_inst_valid(m_id_io_inst_valid),
    .io_pc(m_id_io_pc),
    .io_ctrl(m_id_io_ctrl),
    .io_rs1_c(m_id_io_rs1_c),
    .io_rs2_c(m_id_io_rs2_c),
    .io_rs1_en_c(m_id_io_rs1_en_c),
    .io_rs2_en_c(m_id_io_rs2_en_c),
    .io_rs1_data(m_id_io_rs1_data),
    .io_rs2_data(m_id_io_rs2_data),
    .io_rs1_o(m_id_io_rs1_o),
    .io_rs2_o(m_id_io_rs2_o),
    .io_rs1_en_o(m_id_io_rs1_en_o),
    .io_rs2_en_o(m_id_io_rs2_en_o),
    .io_op1_o(m_id_io_op1_o),
    .io_op2_o(m_id_io_op2_o),
    .io_imm_o(m_id_io_imm_o),
    .io_wb_addr_o(m_id_io_wb_addr_o),
    .io_wb_en_o(m_id_io_wb_en_o),
    .io_fu_op_type_o(m_id_io_fu_op_type_o),
    .io_inst_o(m_id_io_inst_o),
    .io_inst_valid_o(m_id_io_inst_valid_o),
    .io_pc_o(m_id_io_pc_o),
    .io_jmp_addr(m_id_io_jmp_addr),
    .jmp_0(m_id_jmp_0),
    .exe_wb_addr_o(m_id_exe_wb_addr_o),
    .id_alu_conlict_0(m_id_id_alu_conlict_0),
    .id_load_conflict_0(m_id_id_load_conflict_0),
    .exe_wb_data_o(m_id_exe_wb_data_o),
    .exe_wb_en_o(m_id_exe_wb_en_o),
    .exe_inst_valid_o(m_id_exe_inst_valid_o)
  );
  Exe m_exe ( // @[Top.scala 31:47]
    .clock(m_exe_clock),
    .reset(m_exe_reset),
    .io__rs1(m_exe_io__rs1),
    .io__rs2(m_exe_io__rs2),
    .io__rs1_en(m_exe_io__rs1_en),
    .io__rs2_en(m_exe_io__rs2_en),
    .io__by_wb_addr(m_exe_io__by_wb_addr),
    .io__by_wb_en(m_exe_io__by_wb_en),
    .io__by_wb_data(m_exe_io__by_wb_data),
    .io__ctrl(m_exe_io__ctrl),
    .io__op1(m_exe_io__op1),
    .io__op2(m_exe_io__op2),
    .io__imm(m_exe_io__imm),
    .io__fu_op_type(m_exe_io__fu_op_type),
    .io__inst(m_exe_io__inst),
    .io__inst_valid(m_exe_io__inst_valid),
    .io__pc(m_exe_io__pc),
    .io__wb_addr(m_exe_io__wb_addr),
    .io__wb_en(m_exe_io__wb_en),
    .io__inst_o(m_exe_io__inst_o),
    .io__inst_valid_o(m_exe_io__inst_valid_o),
    .io__pc_o(m_exe_io__pc_o),
    .io__fu_op_type_o(m_exe_io__fu_op_type_o),
    .io__op2_o(m_exe_io__op2_o),
    .io__wb_addr_o(m_exe_io__wb_addr_o),
    .io__wb_en_o(m_exe_io__wb_en_o),
    .io__wb_data_o(m_exe_io__wb_data_o),
    .io_wb_addr_o(m_exe_io_wb_addr_o),
    .io_wb_data_o(m_exe_io_wb_data_o),
    .io_wb_en_o(m_exe_io_wb_en_o),
    .io_inst_valid_o(m_exe_io_inst_valid_o),
    .ld_conflict_0(m_exe_ld_conflict_0)
  );
  MemStage m_ls ( // @[Top.scala 32:47]
    .clock(m_ls_clock),
    .io_wb_addr(m_ls_io_wb_addr),
    .io_wb_en(m_ls_io_wb_en),
    .io_wb_data(m_ls_io_wb_data),
    .io_op2(m_ls_io_op2),
    .io_fu_op_type(m_ls_io_fu_op_type),
    .io_inst(m_ls_io_inst),
    .io_inst_valid(m_ls_io_inst_valid),
    .io_pc(m_ls_io_pc),
    .io_inst_o(m_ls_io_inst_o),
    .io_inst_valid_o(m_ls_io_inst_valid_o),
    .io_pc_o(m_ls_io_pc_o),
    .io_wb_addr_o(m_ls_io_wb_addr_o),
    .io_wb_en_o(m_ls_io_wb_en_o),
    .io_wb_data_o(m_ls_io_wb_data_o),
    .io_wr_mask(m_ls_io_wr_mask),
    .io_wr_idx(m_ls_io_wr_idx),
    .io_rd_idx(m_ls_io_rd_idx),
    .io_rd_en(m_ls_io_rd_en),
    .io_wr_en(m_ls_io_wr_en),
    .io_wr_data(m_ls_io_wr_data),
    .io_rd_data(m_ls_io_rd_data)
  );
  Regfile m_regfile ( // @[Top.scala 33:39]
    .clock(m_regfile_clock),
    .reset(m_regfile_reset),
    .io_w_addr(m_regfile_io_w_addr),
    .io_w_data(m_regfile_io_w_data),
    .io_w_en(m_regfile_io_w_en),
    .io_r1_addr(m_regfile_io_r1_addr),
    .io_r1_data(m_regfile_io_r1_data),
    .io_r2_addr(m_regfile_io_r2_addr),
    .io_r2_data(m_regfile_io_r2_data)
  );
  Stall m_ctrl ( // @[Top.scala 34:47]
    .io_ctrl_if(m_ctrl_io_ctrl_if),
    .io_ctrl_id(m_ctrl_io_ctrl_id),
    .io_ctrl_exe(m_ctrl_io_ctrl_exe),
    .id_jmp(m_ctrl_id_jmp),
    .id_alu_conlict_0(m_ctrl_id_alu_conlict_0),
    .id_load_conflict_0(m_ctrl_id_load_conflict_0),
    .exe_ld_conflict(m_ctrl_exe_ld_conflict)
  );
  DifftestInstrCommit commit ( // @[Top.scala 111:28]
    .clock(commit_clock),
    .coreid(commit_coreid),
    .index(commit_index),
    .valid(commit_valid),
    .pc(commit_pc),
    .instr(commit_instr),
    .skip(commit_skip),
    .isRVC(commit_isRVC),
    .scFailed(commit_scFailed),
    .wen(commit_wen),
    .wdata(commit_wdata),
    .wdest(commit_wdest)
  );
  DifftestTrapEvent trap ( // @[Top.scala 129:26]
    .clock(trap_clock),
    .coreid(trap_coreid),
    .valid(trap_valid),
    .code(trap_code),
    .pc(trap_pc),
    .cycleCnt(trap_cycleCnt),
    .instrCnt(trap_instrCnt)
  );
  assign io_inst_ram_rIdx = {{3'd0}, m_if_io_pc_c[63:3]}; // @[Top.scala 93:70]
  assign io_inst_ram_wIdx = m_ls_io_wr_idx; // @[Top.scala 95:49]
  assign io_inst_ram_wdata = m_ls_io_wr_data; // @[Top.scala 96:49]
  assign io_inst_ram_wmask = m_ls_io_wr_mask; // @[Top.scala 97:49]
  assign io_inst_ram_wen = m_ls_io_wr_en; // @[Top.scala 98:49]
  assign io_data_ram_en = m_ls_io_rd_en; // @[Top.scala 83:49]
  assign io_data_ram_rIdx = m_ls_io_rd_idx; // @[Top.scala 84:49]
  assign io_data_ram_wIdx = m_ls_io_wr_idx; // @[Top.scala 85:49]
  assign io_data_ram_wdata = m_ls_io_wr_data; // @[Top.scala 86:49]
  assign io_data_ram_wmask = m_ls_io_wr_mask; // @[Top.scala 87:49]
  assign io_data_ram_wen = m_ls_io_wr_en; // @[Top.scala 88:49]
  assign m_if_clock = clock;
  assign m_if_reset = reset;
  assign m_if_io_inst = io_inst_ram_rdata; // @[Top.scala 36:49]
  assign m_if_io_ctrl = m_ctrl_io_ctrl_if; // @[Top.scala 106:49]
  assign m_if_io_jmp_addr = m_id_io_jmp_addr; // @[Top.scala 37:49]
  assign m_id_clock = clock;
  assign m_id_reset = reset;
  assign m_id_io_inst = m_if_io_inst_o; // @[Top.scala 40:49]
  assign m_id_io_inst_valid = m_if_io_inst_valid_o; // @[Top.scala 39:49]
  assign m_id_io_pc = m_if_io_pc_o; // @[Top.scala 41:57]
  assign m_id_io_ctrl = m_ctrl_io_ctrl_id; // @[Top.scala 107:49]
  assign m_id_io_rs1_data = m_regfile_io_r1_data; // @[Top.scala 44:49]
  assign m_id_io_rs2_data = m_regfile_io_r2_data; // @[Top.scala 45:49]
  assign m_id_exe_wb_addr_o = m_exe_io_wb_addr_o;
  assign m_id_exe_wb_data_o = m_exe_io_wb_data_o;
  assign m_id_exe_wb_en_o = m_exe_io_wb_en_o;
  assign m_id_exe_inst_valid_o = m_exe_io_inst_valid_o;
  assign m_exe_clock = clock;
  assign m_exe_reset = reset;
  assign m_exe_io__rs1 = m_id_io_rs1_o; // @[Top.scala 50:49]
  assign m_exe_io__rs2 = m_id_io_rs2_o; // @[Top.scala 51:49]
  assign m_exe_io__rs1_en = m_id_io_rs1_en_o; // @[Top.scala 52:49]
  assign m_exe_io__rs2_en = m_id_io_rs2_en_o; // @[Top.scala 53:49]
  assign m_exe_io__by_wb_addr = m_ls_io_wb_addr_o; // @[Top.scala 67:49]
  assign m_exe_io__by_wb_en = m_ls_io_wb_en_o; // @[Top.scala 68:49]
  assign m_exe_io__by_wb_data = m_ls_io_wb_data_o; // @[Top.scala 69:49]
  assign m_exe_io__ctrl = m_ctrl_io_ctrl_exe; // @[Top.scala 108:49]
  assign m_exe_io__op1 = m_id_io_op1_o; // @[Top.scala 61:49]
  assign m_exe_io__op2 = m_id_io_op2_o; // @[Top.scala 62:49]
  assign m_exe_io__imm = m_id_io_imm_o; // @[Top.scala 63:49]
  assign m_exe_io__fu_op_type = m_id_io_fu_op_type_o; // @[Top.scala 64:41]
  assign m_exe_io__inst = m_id_io_inst_o; // @[Top.scala 60:49]
  assign m_exe_io__inst_valid = m_id_io_inst_valid_o; // @[Top.scala 58:49]
  assign m_exe_io__pc = m_id_io_pc_o; // @[Top.scala 59:49]
  assign m_exe_io__wb_addr = m_id_io_wb_addr_o; // @[Top.scala 56:49]
  assign m_exe_io__wb_en = m_id_io_wb_en_o; // @[Top.scala 55:49]
  assign m_ls_clock = clock;
  assign m_ls_io_wb_addr = m_exe_io__wb_addr_o; // @[Top.scala 71:49]
  assign m_ls_io_wb_en = m_exe_io__wb_en_o; // @[Top.scala 72:49]
  assign m_ls_io_wb_data = m_exe_io__wb_data_o; // @[Top.scala 73:49]
  assign m_ls_io_op2 = m_exe_io__op2_o; // @[Top.scala 75:57]
  assign m_ls_io_fu_op_type = m_exe_io__fu_op_type_o; // @[Top.scala 78:49]
  assign m_ls_io_inst = m_exe_io__inst_o; // @[Top.scala 80:49]
  assign m_ls_io_inst_valid = m_exe_io__inst_valid_o; // @[Top.scala 81:49]
  assign m_ls_io_pc = m_exe_io__pc_o; // @[Top.scala 79:57]
  assign m_ls_io_rd_data = io_data_ram_rdata; // @[Top.scala 90:49]
  assign m_regfile_clock = clock;
  assign m_regfile_reset = reset;
  assign m_regfile_io_w_addr = m_ls_io_wb_addr_o; // @[Top.scala 102:49]
  assign m_regfile_io_w_data = m_ls_io_wb_data_o; // @[Top.scala 103:49]
  assign m_regfile_io_w_en = m_ls_io_wb_en_o; // @[Top.scala 104:49]
  assign m_regfile_io_r1_addr = m_id_io_rs1_en_c ? m_id_io_rs1_c : 5'h0; // @[Top.scala 47:52]
  assign m_regfile_io_r2_addr = m_id_io_rs2_en_c ? m_id_io_rs2_c : 5'h0; // @[Top.scala 48:52]
  assign m_ctrl_id_jmp = m_id_jmp_0;
  assign m_ctrl_id_alu_conlict_0 = m_id_id_alu_conlict_0;
  assign m_ctrl_id_load_conflict_0 = m_id_id_load_conflict_0;
  assign m_ctrl_exe_ld_conflict = m_exe_ld_conflict_0;
  assign commit_clock = clock; // @[Top.scala 112:25]
  assign commit_coreid = 8'h0; // @[Top.scala 113:26]
  assign commit_index = 8'h0; // @[Top.scala 114:25]
  assign commit_valid = REG; // @[Top.scala 116:33]
  assign commit_pc = REG_1; // @[Top.scala 117:33]
  assign commit_instr = REG_2; // @[Top.scala 118:33]
  assign commit_skip = 1'h0; // @[Top.scala 119:33]
  assign commit_isRVC = 1'h0; // @[Top.scala 120:33]
  assign commit_scFailed = 1'h0; // @[Top.scala 121:33]
  assign commit_wen = REG_3; // @[Top.scala 122:33]
  assign commit_wdata = REG_4; // @[Top.scala 123:33]
  assign commit_wdest = {{3'd0}, REG_5}; // @[Top.scala 124:33]
  assign trap_clock = clock; // @[Top.scala 130:26]
  assign trap_coreid = 8'h0; // @[Top.scala 131:26]
  assign trap_valid = commit_instr == 32'h6b; // @[Top.scala 132:46]
  assign trap_code = 3'h0; // @[Top.scala 133:26]
  assign trap_pc = commit_pc; // @[Top.scala 134:26]
  assign trap_cycleCnt = {{32'd0}, cycleCnt}; // @[Top.scala 135:26]
  assign trap_instrCnt = 64'h0; // @[Top.scala 136:26]
  always @(posedge clock) begin
    REG <= m_ls_io_inst_valid_o; // @[Top.scala 116:43]
    REG_1 <= m_ls_io_pc_o; // @[Top.scala 117:43]
    REG_2 <= m_ls_io_inst_o; // @[Top.scala 118:43]
    REG_3 <= m_ls_io_wb_en_o; // @[Top.scala 122:43]
    REG_4 <= m_ls_io_wb_data_o; // @[Top.scala 123:43]
    REG_5 <= m_ls_io_wb_addr_o; // @[Top.scala 124:43]
    if (reset) begin // @[Top.scala 126:31]
      cycleCnt <= 32'h1; // @[Top.scala 126:31]
    end else begin
      cycleCnt <= _cycleCnt_T_1; // @[Top.scala 127:18]
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
  _RAND_0 = {1{`RANDOM}};
  REG = _RAND_0[0:0];
  _RAND_1 = {2{`RANDOM}};
  REG_1 = _RAND_1[63:0];
  _RAND_2 = {1{`RANDOM}};
  REG_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  REG_3 = _RAND_3[0:0];
  _RAND_4 = {2{`RANDOM}};
  REG_4 = _RAND_4[63:0];
  _RAND_5 = {1{`RANDOM}};
  REG_5 = _RAND_5[4:0];
  _RAND_6 = {1{`RANDOM}};
  cycleCnt = _RAND_6[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SimTop(
  input         clock,
  input         reset,
  input  [63:0] io_logCtrl_log_begin,
  input  [63:0] io_logCtrl_log_end,
  input  [63:0] io_logCtrl_log_level,
  input         io_perfInfo_clean,
  input         io_perfInfo_dump,
  output        io_uart_out_valid,
  output [7:0]  io_uart_out_ch,
  output        io_uart_in_valid,
  input  [7:0]  io_uart_in_ch
);
  wire  rcore_clock; // @[SimTop.scala 31:21]
  wire  rcore_reset; // @[SimTop.scala 31:21]
  wire [63:0] rcore_io_inst_ram_rIdx; // @[SimTop.scala 31:21]
  wire [63:0] rcore_io_inst_ram_rdata; // @[SimTop.scala 31:21]
  wire [63:0] rcore_io_inst_ram_wIdx; // @[SimTop.scala 31:21]
  wire [63:0] rcore_io_inst_ram_wdata; // @[SimTop.scala 31:21]
  wire [63:0] rcore_io_inst_ram_wmask; // @[SimTop.scala 31:21]
  wire  rcore_io_inst_ram_wen; // @[SimTop.scala 31:21]
  wire  rcore_io_data_ram_en; // @[SimTop.scala 31:21]
  wire [63:0] rcore_io_data_ram_rIdx; // @[SimTop.scala 31:21]
  wire [63:0] rcore_io_data_ram_rdata; // @[SimTop.scala 31:21]
  wire [63:0] rcore_io_data_ram_wIdx; // @[SimTop.scala 31:21]
  wire [63:0] rcore_io_data_ram_wdata; // @[SimTop.scala 31:21]
  wire [63:0] rcore_io_data_ram_wmask; // @[SimTop.scala 31:21]
  wire  rcore_io_data_ram_wen; // @[SimTop.scala 31:21]
  wire  inst_ram_clk; // @[SimTop.scala 43:24]
  wire  inst_ram_en; // @[SimTop.scala 43:24]
  wire [63:0] inst_ram_rIdx; // @[SimTop.scala 43:24]
  wire [63:0] inst_ram_rdata; // @[SimTop.scala 43:24]
  wire [63:0] inst_ram_wIdx; // @[SimTop.scala 43:24]
  wire [63:0] inst_ram_wdata; // @[SimTop.scala 43:24]
  wire [63:0] inst_ram_wmask; // @[SimTop.scala 43:24]
  wire  inst_ram_wen; // @[SimTop.scala 43:24]
  wire  data_ram_clk; // @[SimTop.scala 44:24]
  wire  data_ram_en; // @[SimTop.scala 44:24]
  wire [63:0] data_ram_rIdx; // @[SimTop.scala 44:24]
  wire [63:0] data_ram_rdata; // @[SimTop.scala 44:24]
  wire [63:0] data_ram_wIdx; // @[SimTop.scala 44:24]
  wire [63:0] data_ram_wdata; // @[SimTop.scala 44:24]
  wire [63:0] data_ram_wmask; // @[SimTop.scala 44:24]
  wire  data_ram_wen; // @[SimTop.scala 44:24]
  Top rcore ( // @[SimTop.scala 31:21]
    .clock(rcore_clock),
    .reset(rcore_reset),
    .io_inst_ram_rIdx(rcore_io_inst_ram_rIdx),
    .io_inst_ram_rdata(rcore_io_inst_ram_rdata),
    .io_inst_ram_wIdx(rcore_io_inst_ram_wIdx),
    .io_inst_ram_wdata(rcore_io_inst_ram_wdata),
    .io_inst_ram_wmask(rcore_io_inst_ram_wmask),
    .io_inst_ram_wen(rcore_io_inst_ram_wen),
    .io_data_ram_en(rcore_io_data_ram_en),
    .io_data_ram_rIdx(rcore_io_data_ram_rIdx),
    .io_data_ram_rdata(rcore_io_data_ram_rdata),
    .io_data_ram_wIdx(rcore_io_data_ram_wIdx),
    .io_data_ram_wdata(rcore_io_data_ram_wdata),
    .io_data_ram_wmask(rcore_io_data_ram_wmask),
    .io_data_ram_wen(rcore_io_data_ram_wen)
  );
  RAMHelper inst_ram ( // @[SimTop.scala 43:24]
    .clk(inst_ram_clk),
    .en(inst_ram_en),
    .rIdx(inst_ram_rIdx),
    .rdata(inst_ram_rdata),
    .wIdx(inst_ram_wIdx),
    .wdata(inst_ram_wdata),
    .wmask(inst_ram_wmask),
    .wen(inst_ram_wen)
  );
  RAMHelper data_ram ( // @[SimTop.scala 44:24]
    .clk(data_ram_clk),
    .en(data_ram_en),
    .rIdx(data_ram_rIdx),
    .rdata(data_ram_rdata),
    .wIdx(data_ram_wIdx),
    .wdata(data_ram_wdata),
    .wmask(data_ram_wmask),
    .wen(data_ram_wen)
  );
  assign io_uart_out_valid = 1'h0; // @[SimTop.scala 38:21]
  assign io_uart_out_ch = 8'h0; // @[SimTop.scala 39:18]
  assign io_uart_in_valid = 1'h0; // @[SimTop.scala 37:20]
  assign rcore_clock = clock;
  assign rcore_reset = reset;
  assign rcore_io_inst_ram_rdata = inst_ram_rdata; // @[SimTop.scala 53:41]
  assign rcore_io_data_ram_rdata = data_ram_rdata; // @[SimTop.scala 62:41]
  assign inst_ram_clk = clock; // @[SimTop.scala 46:49]
  assign inst_ram_en = 1'h1; // @[SimTop.scala 47:49]
  assign inst_ram_rIdx = rcore_io_inst_ram_rIdx - 64'h10000000; // @[SimTop.scala 48:75]
  assign inst_ram_wIdx = rcore_io_inst_ram_wIdx - 64'h10000000; // @[SimTop.scala 49:75]
  assign inst_ram_wdata = rcore_io_inst_ram_wdata; // @[SimTop.scala 50:49]
  assign inst_ram_wmask = rcore_io_inst_ram_wmask; // @[SimTop.scala 51:49]
  assign inst_ram_wen = rcore_io_inst_ram_wen; // @[SimTop.scala 52:49]
  assign data_ram_clk = clock; // @[SimTop.scala 55:49]
  assign data_ram_en = rcore_io_data_ram_en; // @[SimTop.scala 56:49]
  assign data_ram_rIdx = rcore_io_data_ram_rIdx - 64'h10000000; // @[SimTop.scala 57:75]
  assign data_ram_wIdx = rcore_io_data_ram_wIdx - 64'h10000000; // @[SimTop.scala 58:75]
  assign data_ram_wdata = rcore_io_data_ram_wdata; // @[SimTop.scala 59:49]
  assign data_ram_wmask = rcore_io_data_ram_wmask; // @[SimTop.scala 60:49]
  assign data_ram_wen = rcore_io_data_ram_wen; // @[SimTop.scala 61:49]
endmodule
