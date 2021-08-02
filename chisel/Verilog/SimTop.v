module If(
  input         clock,
  input         reset,
  output [63:0] io_inst_addr,
  output [63:0] io_pc
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] pc; // @[If_stage.scala 11:25]
  wire [63:0] _pc_T_1 = pc + 64'h4; // @[If_stage.scala 12:18]
  assign io_inst_addr = {{3'd0}, pc[63:3]}; // @[If_stage.scala 14:31]
  assign io_pc = pc; // @[If_stage.scala 15:33]
  always @(posedge clock) begin
    if (reset) begin // @[If_stage.scala 11:25]
      pc <= 64'h80000000; // @[If_stage.scala 11:25]
    end else begin
      pc <= _pc_T_1; // @[If_stage.scala 12:12]
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
  input  [63:0] io_pc,
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
  wire [1:0] _decode_list_T_74 = _decode_list_T_73 ? 2'h2 : 2'h0; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_75 = _decode_list_T_71 ? 2'h2 : _decode_list_T_74; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_76 = _decode_list_T_69 ? 2'h2 : _decode_list_T_75; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_77 = _decode_list_T_67 ? 2'h2 : _decode_list_T_76; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_78 = _decode_list_T_65 ? 2'h2 : _decode_list_T_77; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_79 = _decode_list_T_63 ? 2'h2 : _decode_list_T_78; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_80 = _decode_list_T_61 ? 2'h2 : _decode_list_T_79; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_81 = _decode_list_T_59 ? 2'h2 : _decode_list_T_80; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_82 = _decode_list_T_57 ? 2'h2 : _decode_list_T_81; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_83 = _decode_list_T_55 ? 2'h2 : _decode_list_T_82; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_84 = _decode_list_T_53 ? 2'h1 : _decode_list_T_83; // @[Lookup.scala 33:37]
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
  wire [1:0] _decode_list_T_110 = _decode_list_T_73 ? 2'h0 : 2'h3; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_111 = _decode_list_T_71 ? 2'h0 : _decode_list_T_110; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_112 = _decode_list_T_69 ? 2'h0 : _decode_list_T_111; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_113 = _decode_list_T_67 ? 2'h0 : _decode_list_T_112; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_114 = _decode_list_T_65 ? 2'h0 : _decode_list_T_113; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_115 = _decode_list_T_63 ? 2'h0 : _decode_list_T_114; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_116 = _decode_list_T_61 ? 2'h0 : _decode_list_T_115; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_117 = _decode_list_T_59 ? 2'h0 : _decode_list_T_116; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_118 = _decode_list_T_57 ? 2'h0 : _decode_list_T_117; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_119 = _decode_list_T_55 ? 2'h0 : _decode_list_T_118; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_120 = _decode_list_T_53 ? 2'h0 : _decode_list_T_119; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_121 = _decode_list_T_51 ? 2'h0 : _decode_list_T_120; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_122 = _decode_list_T_49 ? 2'h0 : _decode_list_T_121; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_123 = _decode_list_T_47 ? 2'h0 : _decode_list_T_122; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_124 = _decode_list_T_45 ? 2'h0 : _decode_list_T_123; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_125 = _decode_list_T_43 ? 2'h0 : _decode_list_T_124; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_126 = _decode_list_T_41 ? 2'h0 : _decode_list_T_125; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_127 = _decode_list_T_39 ? 2'h0 : _decode_list_T_126; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_128 = _decode_list_T_37 ? 2'h0 : _decode_list_T_127; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_129 = _decode_list_T_35 ? 2'h1 : _decode_list_T_128; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_130 = _decode_list_T_33 ? 2'h1 : _decode_list_T_129; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_131 = _decode_list_T_31 ? 2'h1 : _decode_list_T_130; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_132 = _decode_list_T_29 ? 2'h1 : _decode_list_T_131; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_133 = _decode_list_T_27 ? 2'h1 : _decode_list_T_132; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_134 = _decode_list_T_25 ? 2'h1 : _decode_list_T_133; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_135 = _decode_list_T_23 ? 2'h1 : _decode_list_T_134; // @[Lookup.scala 33:37]
  wire [1:0] _decode_list_T_136 = _decode_list_T_21 ? 2'h1 : _decode_list_T_135; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_137 = _decode_list_T_19 ? 3'h5 : {{1'd0}, _decode_list_T_136}; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_138 = _decode_list_T_17 ? 3'h5 : _decode_list_T_137; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_139 = _decode_list_T_15 ? 3'h5 : _decode_list_T_138; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_140 = _decode_list_T_13 ? 3'h5 : _decode_list_T_139; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_141 = _decode_list_T_11 ? 3'h5 : _decode_list_T_140; // @[Lookup.scala 33:37]
  wire [2:0] _decode_list_T_142 = _decode_list_T_9 ? 3'h5 : _decode_list_T_141; // @[Lookup.scala 33:37]
  wire [5:0] _decode_list_T_146 = _decode_list_T_73 ? 6'h7 : 6'h3f; // @[Lookup.scala 33:37]
  wire [5:0] _decode_list_T_147 = _decode_list_T_71 ? 6'h6 : _decode_list_T_146; // @[Lookup.scala 33:37]
  wire [5:0] _decode_list_T_148 = _decode_list_T_69 ? 6'hd : _decode_list_T_147; // @[Lookup.scala 33:37]
  wire [5:0] _decode_list_T_149 = _decode_list_T_67 ? 6'h5 : _decode_list_T_148; // @[Lookup.scala 33:37]
  wire [5:0] _decode_list_T_150 = _decode_list_T_65 ? 6'h4 : _decode_list_T_149; // @[Lookup.scala 33:37]
  wire [5:0] _decode_list_T_151 = _decode_list_T_63 ? 6'h3 : _decode_list_T_150; // @[Lookup.scala 33:37]
  wire [5:0] _decode_list_T_152 = _decode_list_T_61 ? 6'h2 : _decode_list_T_151; // @[Lookup.scala 33:37]
  wire [5:0] _decode_list_T_153 = _decode_list_T_59 ? 6'h1 : _decode_list_T_152; // @[Lookup.scala 33:37]
  wire [5:0] _decode_list_T_154 = _decode_list_T_57 ? 6'h8 : _decode_list_T_153; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_155 = _decode_list_T_55 ? 7'h40 : {{1'd0}, _decode_list_T_154}; // @[Lookup.scala 33:37]
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
  wire [11:0] imm_lo = io_inst[31:20]; // @[Id_stage.scala 56:53]
  wire  imm_signBit = imm_lo[11]; // @[BitUtil.scala 9:20]
  wire [51:0] imm_hi = imm_signBit ? 52'hfffffffffffff : 52'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _imm_T_1 = {imm_hi,imm_lo}; // @[Cat.scala 30:58]
  wire [6:0] imm_hi_1 = io_inst[31:25]; // @[Id_stage.scala 57:53]
  wire [4:0] imm_lo_1 = io_inst[11:7]; // @[Id_stage.scala 57:68]
  wire [11:0] imm_lo_2 = {imm_hi_1,imm_lo_1}; // @[Cat.scala 30:58]
  wire  imm_signBit_1 = imm_lo_2[11]; // @[BitUtil.scala 9:20]
  wire [51:0] imm_hi_2 = imm_signBit_1 ? 52'hfffffffffffff : 52'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _imm_T_3 = {imm_hi_2,imm_hi_1,imm_lo_1}; // @[Cat.scala 30:58]
  wire  imm_hi_hi_hi = io_inst[31]; // @[Id_stage.scala 58:53]
  wire  imm_hi_hi_lo = io_inst[7]; // @[Id_stage.scala 58:65]
  wire [5:0] imm_hi_lo = io_inst[30:25]; // @[Id_stage.scala 58:76]
  wire [3:0] imm_lo_hi = io_inst[11:8]; // @[Id_stage.scala 58:91]
  wire [12:0] imm_lo_4 = {imm_hi_hi_hi,imm_hi_hi_lo,imm_hi_lo,imm_lo_hi,1'h0}; // @[Cat.scala 30:58]
  wire  imm_signBit_2 = imm_lo_4[12]; // @[BitUtil.scala 9:20]
  wire [50:0] imm_hi_4 = imm_signBit_2 ? 51'h7ffffffffffff : 51'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _imm_T_5 = {imm_hi_4,imm_hi_hi_hi,imm_hi_hi_lo,imm_hi_lo,imm_lo_hi,1'h0}; // @[Cat.scala 30:58]
  wire [19:0] imm_hi_5 = io_inst[31:12]; // @[Id_stage.scala 59:53]
  wire [31:0] imm_lo_5 = {imm_hi_5,12'h0}; // @[Cat.scala 30:58]
  wire  imm_signBit_3 = imm_lo_5[31]; // @[BitUtil.scala 9:20]
  wire [31:0] imm_hi_6 = imm_signBit_3 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _imm_T_7 = {imm_hi_6,imm_hi_5,12'h0}; // @[Cat.scala 30:58]
  wire [7:0] imm_hi_hi_lo_1 = io_inst[19:12]; // @[Id_stage.scala 60:65]
  wire  imm_hi_lo_1 = io_inst[20]; // @[Id_stage.scala 60:80]
  wire [9:0] imm_lo_hi_1 = io_inst[30:21]; // @[Id_stage.scala 60:92]
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
  wire  _io_rs2_T = ~src2_type; // @[Id_stage.scala 65:56]
  reg [63:0] io_op1_REG; // @[Id_stage.scala 67:48]
  reg [63:0] io_op2_REG; // @[Id_stage.scala 68:48]
  reg [63:0] io_imm_REG; // @[Id_stage.scala 70:48]
  reg [6:0] io_fu_op_type_REG; // @[Id_stage.scala 71:40]
  reg [2:0] io_fu_type_REG; // @[Id_stage.scala 72:48]
  reg [4:0] io_rd_REG; // @[Id_stage.scala 73:48]
  assign io_rs1 = src1_type ? 5'h0 : io_inst[19:15]; // @[Id_stage.scala 64:45]
  assign io_rs2 = ~src2_type ? io_inst[24:20] : 5'h0; // @[Id_stage.scala 65:45]
  assign io_op1 = io_op1_REG; // @[Id_stage.scala 67:33]
  assign io_op2 = io_op2_REG; // @[Id_stage.scala 68:33]
  assign io_imm = io_imm_REG; // @[Id_stage.scala 70:33]
  assign io_rd = io_rd_REG; // @[Id_stage.scala 73:33]
  assign io_fu_type = io_fu_type_REG; // @[Id_stage.scala 72:33]
  assign io_fu_op_type = io_fu_op_type_REG; // @[Id_stage.scala 71:25]
  always @(posedge clock) begin
    if (io_inst[6:0] == 7'h37) begin // @[Id_stage.scala 67:52]
      io_op1_REG <= 64'h0;
    end else if (src1_type) begin // @[Id_stage.scala 67:93]
      io_op1_REG <= io_pc;
    end else begin
      io_op1_REG <= io_rs1_data;
    end
    if (_io_rs2_T) begin // @[Id_stage.scala 68:52]
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
    io_rd_REG <= io_inst[11:7]; // @[Id_stage.scala 73:56]
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
  wire [5:0] shamt = io_op2[5:0]; // @[Exe_stage.scala 46:27]
  wire  is_adder_sub = ~io_fu_op_type[6]; // @[Exe_stage.scala 48:28]
  wire [63:0] _adder_res_T_1 = is_adder_sub ? 64'hffffffffffffffff : 64'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _adder_res_T_2 = io_op2 ^ _adder_res_T_1; // @[Exe_stage.scala 49:44]
  wire [64:0] _adder_res_T_3 = io_op1 + _adder_res_T_2; // @[Exe_stage.scala 49:33]
  wire [64:0] _GEN_0 = {{64'd0}, is_adder_sub}; // @[Exe_stage.scala 49:72]
  wire [64:0] adder_res = _adder_res_T_3 + _GEN_0; // @[Exe_stage.scala 49:72]
  wire [63:0] xor_res = io_op1 ^ io_op2; // @[Exe_stage.scala 50:31]
  wire  sltu_res = ~adder_res[64]; // @[Exe_stage.scala 52:24]
  wire  slt_res = xor_res[63] ^ sltu_res; // @[Exe_stage.scala 53:39]
  wire [126:0] _GEN_1 = {{63'd0}, io_op1}; // @[Exe_stage.scala 56:57]
  wire [126:0] _wb_data_T = _GEN_1 << shamt; // @[Exe_stage.scala 56:57]
  wire [63:0] _wb_data_T_2 = io_op1 >> shamt; // @[Exe_stage.scala 57:57]
  wire [63:0] _wb_data_T_5 = $signed(io_op1) >>> shamt; // @[Exe_stage.scala 58:74]
  wire [63:0] _wb_data_T_6 = io_op1 | io_op2; // @[Exe_stage.scala 60:57]
  wire [63:0] _wb_data_T_7 = io_op1 & io_op2; // @[Exe_stage.scala 61:57]
  wire [63:0] _wb_data_T_8 = {63'h0,slt_res}; // @[Cat.scala 30:58]
  wire [63:0] _wb_data_T_9 = {63'h0,sltu_res}; // @[Cat.scala 30:58]
  wire [64:0] _wb_data_T_11 = 7'h1 == io_fu_op_type ? {{1'd0}, _wb_data_T[63:0]} : adder_res; // @[Mux.scala 80:57]
  wire [64:0] _wb_data_T_13 = 7'h5 == io_fu_op_type ? {{1'd0}, _wb_data_T_2} : _wb_data_T_11; // @[Mux.scala 80:57]
  wire [64:0] _wb_data_T_15 = 7'hd == io_fu_op_type ? {{1'd0}, _wb_data_T_5} : _wb_data_T_13; // @[Mux.scala 80:57]
  wire [64:0] _wb_data_T_17 = 7'h6 == io_fu_op_type ? {{1'd0}, _wb_data_T_6} : _wb_data_T_15; // @[Mux.scala 80:57]
  reg  io_wb_en_REG; // @[Exe_stage.scala 70:56]
  reg [64:0] io_wb_data_REG; // @[Exe_stage.scala 71:56]
  reg [4:0] io_wb_addr_REG; // @[Exe_stage.scala 72:56]
  reg [6:0] io_fu_op_type_o_REG; // @[Exe_stage.scala 73:48]
  reg [2:0] io_fu_type_o_REG; // @[Exe_stage.scala 74:48]
  reg [63:0] io_op1_o_REG; // @[Exe_stage.scala 75:56]
  reg [63:0] io_op2_o_REG; // @[Exe_stage.scala 76:56]
  reg [63:0] io_imm_o_REG; // @[Exe_stage.scala 77:56]
  assign io_fu_type_o = io_fu_type_o_REG; // @[Exe_stage.scala 74:33]
  assign io_fu_op_type_o = io_fu_op_type_o_REG; // @[Exe_stage.scala 73:33]
  assign io_op1_o = io_op1_o_REG; // @[Exe_stage.scala 75:41]
  assign io_op2_o = io_op2_o_REG; // @[Exe_stage.scala 76:41]
  assign io_imm_o = io_imm_o_REG; // @[Exe_stage.scala 77:41]
  assign io_wb_addr = io_wb_addr_REG; // @[Exe_stage.scala 72:41]
  assign io_wb_en = io_wb_en_REG; // @[Exe_stage.scala 70:41]
  assign io_wb_data = io_wb_data_REG[63:0]; // @[Exe_stage.scala 71:41]
  always @(posedge clock) begin
    io_wb_en_REG <= 7'h5a == io_fu_op_type | (7'h58 == io_fu_op_type | (7'h8 == io_fu_op_type | (7'h3 == io_fu_op_type
       | (7'h2 == io_fu_op_type | (7'h4 == io_fu_op_type | (7'h7 == io_fu_op_type | (7'h6 == io_fu_op_type | (7'hd ==
      io_fu_op_type | (7'h5 == io_fu_op_type | (7'h1 == io_fu_op_type | 7'h40 == io_fu_op_type)))))))))); // @[Mux.scala 80:57]
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
    io_wb_addr_REG <= io_rd; // @[Exe_stage.scala 72:56]
    io_fu_op_type_o_REG <= io_fu_op_type; // @[Exe_stage.scala 73:48]
    io_fu_type_o_REG <= io_fu_type; // @[Exe_stage.scala 74:48]
    io_op1_o_REG <= io_op1; // @[Exe_stage.scala 75:56]
    io_op2_o_REG <= io_op2; // @[Exe_stage.scala 76:56]
    io_imm_o_REG <= io_imm; // @[Exe_stage.scala 77:56]
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
  output [63:0] io_mem_addr_wr,
  output [63:0] io_mem_addr_rd,
  output        io_mem_en_rd,
  output        io_mem_en_wr,
  output [63:0] io_mem_data_wr,
  input  [63:0] io_mem_data_rd
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire [7:0] mem_data_wr_lo = io_op2[7:0]; // @[Mem_stage.scala 52:63]
  wire [63:0] _mem_data_wr_T = {56'h0,mem_data_wr_lo}; // @[Cat.scala 30:58]
  wire [15:0] mem_data_wr_lo_1 = io_op2[15:0]; // @[Mem_stage.scala 53:63]
  wire [63:0] _mem_data_wr_T_1 = {48'h0,mem_data_wr_lo_1}; // @[Cat.scala 30:58]
  wire [31:0] mem_data_wr_lo_2 = io_op2[31:0]; // @[Mem_stage.scala 54:63]
  wire [63:0] _mem_data_wr_T_2 = {32'h0,mem_data_wr_lo_2}; // @[Cat.scala 30:58]
  wire [63:0] _mem_data_wr_T_4 = 7'h25 == io_fu_op_type ? _mem_data_wr_T : 64'h0; // @[Mux.scala 80:57]
  wire [63:0] _mem_data_wr_T_6 = 7'h26 == io_fu_op_type ? _mem_data_wr_T_1 : _mem_data_wr_T_4; // @[Mux.scala 80:57]
  reg [6:0] wb_data_r_REG; // @[Mem_stage.scala 57:50]
  reg [63:0] wb_data_r_REG_1; // @[Mem_stage.scala 57:73]
  wire [7:0] wb_data_r_lo = io_mem_data_rd[7:0]; // @[Mem_stage.scala 58:80]
  wire  wb_data_r_signBit = wb_data_r_lo[7]; // @[BitUtil.scala 9:20]
  wire [55:0] wb_data_r_hi = wb_data_r_signBit ? 56'hffffffffffffff : 56'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _wb_data_r_T_1 = {wb_data_r_hi,wb_data_r_lo}; // @[Cat.scala 30:58]
  wire [15:0] wb_data_r_lo_1 = io_mem_data_rd[15:0]; // @[Mem_stage.scala 59:72]
  wire  wb_data_r_signBit_1 = wb_data_r_lo_1[15]; // @[BitUtil.scala 9:20]
  wire [47:0] wb_data_r_hi_1 = wb_data_r_signBit_1 ? 48'hffffffffffff : 48'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _wb_data_r_T_3 = {wb_data_r_hi_1,wb_data_r_lo_1}; // @[Cat.scala 30:58]
  wire [31:0] wb_data_r_lo_2 = io_mem_data_rd[31:0]; // @[Mem_stage.scala 60:72]
  wire  wb_data_r_signBit_2 = wb_data_r_lo_2[31]; // @[BitUtil.scala 9:20]
  wire [31:0] wb_data_r_hi_2 = wb_data_r_signBit_2 ? 32'hffffffff : 32'h0; // @[Bitwise.scala 72:12]
  wire [63:0] _wb_data_r_T_5 = {wb_data_r_hi_2,wb_data_r_lo_2}; // @[Cat.scala 30:58]
  wire [63:0] _wb_data_r_T_6 = {56'h0,wb_data_r_lo}; // @[Cat.scala 30:58]
  wire [63:0] _wb_data_r_T_7 = {48'h0,wb_data_r_lo_1}; // @[Cat.scala 30:58]
  wire [63:0] _wb_data_r_T_9 = 7'h20 == wb_data_r_REG ? _wb_data_r_T_1 : wb_data_r_REG_1; // @[Mux.scala 80:57]
  wire [63:0] _wb_data_r_T_11 = 7'h21 == wb_data_r_REG ? _wb_data_r_T_3 : _wb_data_r_T_9; // @[Mux.scala 80:57]
  wire [63:0] _wb_data_r_T_13 = 7'h22 == wb_data_r_REG ? _wb_data_r_T_5 : _wb_data_r_T_11; // @[Mux.scala 80:57]
  wire [63:0] _wb_data_r_T_15 = 7'h23 == wb_data_r_REG ? _wb_data_r_T_6 : _wb_data_r_T_13; // @[Mux.scala 80:57]
  reg [4:0] io_wb_addr_r_REG; // @[Mem_stage.scala 68:40]
  reg  io_wb_en_r_REG; // @[Mem_stage.scala 69:48]
  assign io_wb_addr_r = io_wb_addr_r_REG; // @[Mem_stage.scala 68:25]
  assign io_wb_en_r = io_wb_en_r_REG; // @[Mem_stage.scala 69:33]
  assign io_wb_data_r = 7'h24 == wb_data_r_REG ? _wb_data_r_T_7 : _wb_data_r_T_15; // @[Mux.scala 80:57]
  assign io_mem_addr_wr = io_op1 + io_imm; // @[Mem_stage.scala 33:34]
  assign io_mem_addr_rd = io_op1 + io_op2; // @[Mem_stage.scala 32:34]
  assign io_mem_en_rd = 3'h1 == io_fu_type; // @[Mux.scala 80:60]
  assign io_mem_en_wr = 7'h27 == io_fu_op_type | (7'h26 == io_fu_op_type | 7'h25 == io_fu_op_type); // @[Mux.scala 80:57]
  assign io_mem_data_wr = 7'h27 == io_fu_op_type ? _mem_data_wr_T_2 : _mem_data_wr_T_6; // @[Mux.scala 80:57]
  always @(posedge clock) begin
    wb_data_r_REG <= io_fu_op_type; // @[Mem_stage.scala 57:50]
    wb_data_r_REG_1 <= io_wb_data; // @[Mem_stage.scala 57:73]
    io_wb_addr_r_REG <= io_wb_addr; // @[Mem_stage.scala 68:40]
    io_wb_en_r_REG <= io_wb_en; // @[Mem_stage.scala 69:48]
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
  wb_data_r_REG = _RAND_0[6:0];
  _RAND_1 = {2{`RANDOM}};
  wb_data_r_REG_1 = _RAND_1[63:0];
  _RAND_2 = {1{`RANDOM}};
  io_wb_addr_r_REG = _RAND_2[4:0];
  _RAND_3 = {1{`RANDOM}};
  io_wb_en_r_REG = _RAND_3[0:0];
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
  wire  mod_clock; // @[Reg_file.scala 27:25]
  wire [7:0] mod_coreid; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_0; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_1; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_2; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_3; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_4; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_5; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_6; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_7; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_8; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_9; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_10; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_11; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_12; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_13; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_14; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_15; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_16; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_17; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_18; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_19; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_20; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_21; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_22; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_23; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_24; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_25; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_26; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_27; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_28; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_29; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_30; // @[Reg_file.scala 27:25]
  wire [63:0] mod_gpr_31; // @[Reg_file.scala 27:25]
  wire  csr_clock; // @[Reg_file.scala 32:21]
  wire [7:0] csr_coreid; // @[Reg_file.scala 32:21]
  wire [1:0] csr_priviledgeMode; // @[Reg_file.scala 32:21]
  wire [63:0] csr_mstatus; // @[Reg_file.scala 32:21]
  wire [63:0] csr_sstatus; // @[Reg_file.scala 32:21]
  wire [63:0] csr_mepc; // @[Reg_file.scala 32:21]
  wire [63:0] csr_sepc; // @[Reg_file.scala 32:21]
  wire [63:0] csr_mtval; // @[Reg_file.scala 32:21]
  wire [63:0] csr_stval; // @[Reg_file.scala 32:21]
  wire [63:0] csr_mtvec; // @[Reg_file.scala 32:21]
  wire [63:0] csr_stvec; // @[Reg_file.scala 32:21]
  wire [63:0] csr_mcause; // @[Reg_file.scala 32:21]
  wire [63:0] csr_scause; // @[Reg_file.scala 32:21]
  wire [63:0] csr_satp; // @[Reg_file.scala 32:21]
  wire [63:0] csr_mip; // @[Reg_file.scala 32:21]
  wire [63:0] csr_mie; // @[Reg_file.scala 32:21]
  wire [63:0] csr_mscratch; // @[Reg_file.scala 32:21]
  wire [63:0] csr_sscratch; // @[Reg_file.scala 32:21]
  wire [63:0] csr_mideleg; // @[Reg_file.scala 32:21]
  wire [63:0] csr_medeleg; // @[Reg_file.scala 32:21]
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
  wire [63:0] _GEN_1 = 5'h1 == io_r1_addr ? registers_1 : registers_0; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_2 = 5'h2 == io_r1_addr ? registers_2 : _GEN_1; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_3 = 5'h3 == io_r1_addr ? registers_3 : _GEN_2; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_4 = 5'h4 == io_r1_addr ? registers_4 : _GEN_3; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_5 = 5'h5 == io_r1_addr ? registers_5 : _GEN_4; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_6 = 5'h6 == io_r1_addr ? registers_6 : _GEN_5; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_7 = 5'h7 == io_r1_addr ? registers_7 : _GEN_6; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_8 = 5'h8 == io_r1_addr ? registers_8 : _GEN_7; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_9 = 5'h9 == io_r1_addr ? registers_9 : _GEN_8; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_10 = 5'ha == io_r1_addr ? registers_10 : _GEN_9; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_11 = 5'hb == io_r1_addr ? registers_11 : _GEN_10; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_12 = 5'hc == io_r1_addr ? registers_12 : _GEN_11; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_13 = 5'hd == io_r1_addr ? registers_13 : _GEN_12; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_14 = 5'he == io_r1_addr ? registers_14 : _GEN_13; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_15 = 5'hf == io_r1_addr ? registers_15 : _GEN_14; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_16 = 5'h10 == io_r1_addr ? registers_16 : _GEN_15; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_17 = 5'h11 == io_r1_addr ? registers_17 : _GEN_16; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_18 = 5'h12 == io_r1_addr ? registers_18 : _GEN_17; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_19 = 5'h13 == io_r1_addr ? registers_19 : _GEN_18; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_20 = 5'h14 == io_r1_addr ? registers_20 : _GEN_19; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_21 = 5'h15 == io_r1_addr ? registers_21 : _GEN_20; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_22 = 5'h16 == io_r1_addr ? registers_22 : _GEN_21; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_23 = 5'h17 == io_r1_addr ? registers_23 : _GEN_22; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_24 = 5'h18 == io_r1_addr ? registers_24 : _GEN_23; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_25 = 5'h19 == io_r1_addr ? registers_25 : _GEN_24; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_26 = 5'h1a == io_r1_addr ? registers_26 : _GEN_25; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_27 = 5'h1b == io_r1_addr ? registers_27 : _GEN_26; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_28 = 5'h1c == io_r1_addr ? registers_28 : _GEN_27; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_29 = 5'h1d == io_r1_addr ? registers_29 : _GEN_28; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_30 = 5'h1e == io_r1_addr ? registers_30 : _GEN_29; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  wire [63:0] _GEN_33 = 5'h1 == io_r2_addr ? registers_1 : registers_0; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_34 = 5'h2 == io_r2_addr ? registers_2 : _GEN_33; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_35 = 5'h3 == io_r2_addr ? registers_3 : _GEN_34; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_36 = 5'h4 == io_r2_addr ? registers_4 : _GEN_35; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_37 = 5'h5 == io_r2_addr ? registers_5 : _GEN_36; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_38 = 5'h6 == io_r2_addr ? registers_6 : _GEN_37; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_39 = 5'h7 == io_r2_addr ? registers_7 : _GEN_38; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_40 = 5'h8 == io_r2_addr ? registers_8 : _GEN_39; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_41 = 5'h9 == io_r2_addr ? registers_9 : _GEN_40; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_42 = 5'ha == io_r2_addr ? registers_10 : _GEN_41; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_43 = 5'hb == io_r2_addr ? registers_11 : _GEN_42; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_44 = 5'hc == io_r2_addr ? registers_12 : _GEN_43; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_45 = 5'hd == io_r2_addr ? registers_13 : _GEN_44; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_46 = 5'he == io_r2_addr ? registers_14 : _GEN_45; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_47 = 5'hf == io_r2_addr ? registers_15 : _GEN_46; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_48 = 5'h10 == io_r2_addr ? registers_16 : _GEN_47; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_49 = 5'h11 == io_r2_addr ? registers_17 : _GEN_48; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_50 = 5'h12 == io_r2_addr ? registers_18 : _GEN_49; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_51 = 5'h13 == io_r2_addr ? registers_19 : _GEN_50; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_52 = 5'h14 == io_r2_addr ? registers_20 : _GEN_51; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_53 = 5'h15 == io_r2_addr ? registers_21 : _GEN_52; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_54 = 5'h16 == io_r2_addr ? registers_22 : _GEN_53; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_55 = 5'h17 == io_r2_addr ? registers_23 : _GEN_54; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_56 = 5'h18 == io_r2_addr ? registers_24 : _GEN_55; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_57 = 5'h19 == io_r2_addr ? registers_25 : _GEN_56; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_58 = 5'h1a == io_r2_addr ? registers_26 : _GEN_57; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_59 = 5'h1b == io_r2_addr ? registers_27 : _GEN_58; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_60 = 5'h1c == io_r2_addr ? registers_28 : _GEN_59; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_61 = 5'h1d == io_r2_addr ? registers_29 : _GEN_60; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  wire [63:0] _GEN_62 = 5'h1e == io_r2_addr ? registers_30 : _GEN_61; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  DifftestArchIntRegState mod ( // @[Reg_file.scala 27:25]
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
  DifftestCSRState csr ( // @[Reg_file.scala 32:21]
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
  assign io_r1_data = 5'h1f == io_r1_addr ? registers_31 : _GEN_30; // @[Reg_file.scala 21:20 Reg_file.scala 21:20]
  assign io_r2_data = 5'h1f == io_r2_addr ? registers_31 : _GEN_62; // @[Reg_file.scala 22:20 Reg_file.scala 22:20]
  assign mod_clock = clock; // @[Reg_file.scala 28:22]
  assign mod_coreid = 8'h0; // @[Reg_file.scala 29:23]
  assign mod_gpr_0 = registers_0; // @[Reg_file.scala 30:20]
  assign mod_gpr_1 = registers_1; // @[Reg_file.scala 30:20]
  assign mod_gpr_2 = registers_2; // @[Reg_file.scala 30:20]
  assign mod_gpr_3 = registers_3; // @[Reg_file.scala 30:20]
  assign mod_gpr_4 = registers_4; // @[Reg_file.scala 30:20]
  assign mod_gpr_5 = registers_5; // @[Reg_file.scala 30:20]
  assign mod_gpr_6 = registers_6; // @[Reg_file.scala 30:20]
  assign mod_gpr_7 = registers_7; // @[Reg_file.scala 30:20]
  assign mod_gpr_8 = registers_8; // @[Reg_file.scala 30:20]
  assign mod_gpr_9 = registers_9; // @[Reg_file.scala 30:20]
  assign mod_gpr_10 = registers_10; // @[Reg_file.scala 30:20]
  assign mod_gpr_11 = registers_11; // @[Reg_file.scala 30:20]
  assign mod_gpr_12 = registers_12; // @[Reg_file.scala 30:20]
  assign mod_gpr_13 = registers_13; // @[Reg_file.scala 30:20]
  assign mod_gpr_14 = registers_14; // @[Reg_file.scala 30:20]
  assign mod_gpr_15 = registers_15; // @[Reg_file.scala 30:20]
  assign mod_gpr_16 = registers_16; // @[Reg_file.scala 30:20]
  assign mod_gpr_17 = registers_17; // @[Reg_file.scala 30:20]
  assign mod_gpr_18 = registers_18; // @[Reg_file.scala 30:20]
  assign mod_gpr_19 = registers_19; // @[Reg_file.scala 30:20]
  assign mod_gpr_20 = registers_20; // @[Reg_file.scala 30:20]
  assign mod_gpr_21 = registers_21; // @[Reg_file.scala 30:20]
  assign mod_gpr_22 = registers_22; // @[Reg_file.scala 30:20]
  assign mod_gpr_23 = registers_23; // @[Reg_file.scala 30:20]
  assign mod_gpr_24 = registers_24; // @[Reg_file.scala 30:20]
  assign mod_gpr_25 = registers_25; // @[Reg_file.scala 30:20]
  assign mod_gpr_26 = registers_26; // @[Reg_file.scala 30:20]
  assign mod_gpr_27 = registers_27; // @[Reg_file.scala 30:20]
  assign mod_gpr_28 = registers_28; // @[Reg_file.scala 30:20]
  assign mod_gpr_29 = registers_29; // @[Reg_file.scala 30:20]
  assign mod_gpr_30 = registers_30; // @[Reg_file.scala 30:20]
  assign mod_gpr_31 = registers_31; // @[Reg_file.scala 30:20]
  assign csr_clock = clock; // @[Reg_file.scala 33:18]
  assign csr_coreid = 8'h0; // @[Reg_file.scala 34:19]
  assign csr_priviledgeMode = 2'h0; // @[Reg_file.scala 52:27]
  assign csr_mstatus = 64'h0; // @[Reg_file.scala 35:20]
  assign csr_sstatus = 64'h0; // @[Reg_file.scala 38:20]
  assign csr_mepc = 64'h0; // @[Reg_file.scala 37:17]
  assign csr_sepc = 64'h0; // @[Reg_file.scala 40:17]
  assign csr_mtval = 64'h0; // @[Reg_file.scala 48:17]
  assign csr_stval = 64'h0; // @[Reg_file.scala 49:17]
  assign csr_mtvec = 64'h0; // @[Reg_file.scala 50:18]
  assign csr_stvec = 64'h0; // @[Reg_file.scala 51:18]
  assign csr_mcause = 64'h0; // @[Reg_file.scala 36:19]
  assign csr_scause = 64'h0; // @[Reg_file.scala 39:19]
  assign csr_satp = 64'h0; // @[Reg_file.scala 41:17]
  assign csr_mip = 64'h0; // @[Reg_file.scala 42:16]
  assign csr_mie = 64'h0; // @[Reg_file.scala 43:16]
  assign csr_mscratch = 64'h0; // @[Reg_file.scala 44:21]
  assign csr_sscratch = 64'h0; // @[Reg_file.scala 45:21]
  assign csr_mideleg = 64'h0; // @[Reg_file.scala 46:20]
  assign csr_medeleg = 64'h0; // @[Reg_file.scala 47:20]
  always @(posedge clock) begin
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_0 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'h0 == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_0 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_1 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'h1 == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_1 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_2 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'h2 == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_2 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_3 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'h3 == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_3 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_4 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'h4 == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_4 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_5 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'h5 == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_5 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_6 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'h6 == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_6 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_7 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'h7 == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_7 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_8 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'h8 == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_8 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_9 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'h9 == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_9 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_10 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'ha == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_10 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_11 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'hb == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_11 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_12 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'hc == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_12 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_13 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'hd == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_13 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_14 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'he == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_14 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_15 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'hf == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_15 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_16 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'h10 == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_16 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_17 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'h11 == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_17 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_18 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'h12 == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_18 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_19 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'h13 == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_19 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_20 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'h14 == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_20 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_21 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'h15 == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_21 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_22 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'h16 == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_22 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_23 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'h17 == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_23 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_24 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'h18 == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_24 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_25 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'h19 == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_25 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_26 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'h1a == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_26 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_27 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'h1b == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_27 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_28 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'h1c == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_28 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_29 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'h1d == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_29 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_30 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'h1e == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_30 <= io_w_data; // @[Reg_file.scala 24:38]
      end
    end
    if (reset) begin // @[Reg_file.scala 18:32]
      registers_31 <= 64'h0; // @[Reg_file.scala 18:32]
    end else if (io_w_en) begin // @[Reg_file.scala 23:22]
      if (5'h1f == io_w_addr) begin // @[Reg_file.scala 24:38]
        registers_31 <= io_w_data; // @[Reg_file.scala 24:38]
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
  reg [31:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
`endif // RANDOMIZE_REG_INIT
  wire  m_if_clock; // @[Top.scala 29:47]
  wire  m_if_reset; // @[Top.scala 29:47]
  wire [63:0] m_if_io_inst_addr; // @[Top.scala 29:47]
  wire [63:0] m_if_io_pc; // @[Top.scala 29:47]
  wire  m_id_clock; // @[Top.scala 30:47]
  wire [31:0] m_id_io_inst; // @[Top.scala 30:47]
  wire [63:0] m_id_io_pc; // @[Top.scala 30:47]
  wire [4:0] m_id_io_rs1; // @[Top.scala 30:47]
  wire [4:0] m_id_io_rs2; // @[Top.scala 30:47]
  wire [63:0] m_id_io_rs1_data; // @[Top.scala 30:47]
  wire [63:0] m_id_io_rs2_data; // @[Top.scala 30:47]
  wire [63:0] m_id_io_op1; // @[Top.scala 30:47]
  wire [63:0] m_id_io_op2; // @[Top.scala 30:47]
  wire [63:0] m_id_io_imm; // @[Top.scala 30:47]
  wire [4:0] m_id_io_rd; // @[Top.scala 30:47]
  wire [2:0] m_id_io_fu_type; // @[Top.scala 30:47]
  wire [6:0] m_id_io_fu_op_type; // @[Top.scala 30:47]
  wire  m_exe_clock; // @[Top.scala 31:47]
  wire [63:0] m_exe_io_op1; // @[Top.scala 31:47]
  wire [63:0] m_exe_io_op2; // @[Top.scala 31:47]
  wire [63:0] m_exe_io_imm; // @[Top.scala 31:47]
  wire [4:0] m_exe_io_rd; // @[Top.scala 31:47]
  wire [2:0] m_exe_io_fu_type; // @[Top.scala 31:47]
  wire [6:0] m_exe_io_fu_op_type; // @[Top.scala 31:47]
  wire [2:0] m_exe_io_fu_type_o; // @[Top.scala 31:47]
  wire [6:0] m_exe_io_fu_op_type_o; // @[Top.scala 31:47]
  wire [63:0] m_exe_io_op1_o; // @[Top.scala 31:47]
  wire [63:0] m_exe_io_op2_o; // @[Top.scala 31:47]
  wire [63:0] m_exe_io_imm_o; // @[Top.scala 31:47]
  wire [4:0] m_exe_io_wb_addr; // @[Top.scala 31:47]
  wire  m_exe_io_wb_en; // @[Top.scala 31:47]
  wire [63:0] m_exe_io_wb_data; // @[Top.scala 31:47]
  wire  m_mem_clock; // @[Top.scala 32:47]
  wire [4:0] m_mem_io_wb_addr; // @[Top.scala 32:47]
  wire  m_mem_io_wb_en; // @[Top.scala 32:47]
  wire [63:0] m_mem_io_wb_data; // @[Top.scala 32:47]
  wire [63:0] m_mem_io_op1; // @[Top.scala 32:47]
  wire [63:0] m_mem_io_op2; // @[Top.scala 32:47]
  wire [63:0] m_mem_io_imm; // @[Top.scala 32:47]
  wire [2:0] m_mem_io_fu_type; // @[Top.scala 32:47]
  wire [6:0] m_mem_io_fu_op_type; // @[Top.scala 32:47]
  wire [4:0] m_mem_io_wb_addr_r; // @[Top.scala 32:47]
  wire  m_mem_io_wb_en_r; // @[Top.scala 32:47]
  wire [63:0] m_mem_io_wb_data_r; // @[Top.scala 32:47]
  wire [63:0] m_mem_io_mem_addr_wr; // @[Top.scala 32:47]
  wire [63:0] m_mem_io_mem_addr_rd; // @[Top.scala 32:47]
  wire  m_mem_io_mem_en_rd; // @[Top.scala 32:47]
  wire  m_mem_io_mem_en_wr; // @[Top.scala 32:47]
  wire [63:0] m_mem_io_mem_data_wr; // @[Top.scala 32:47]
  wire [63:0] m_mem_io_mem_data_rd; // @[Top.scala 32:47]
  wire  m_regfile_clock; // @[Top.scala 33:39]
  wire  m_regfile_reset; // @[Top.scala 33:39]
  wire [4:0] m_regfile_io_w_addr; // @[Top.scala 33:39]
  wire [63:0] m_regfile_io_w_data; // @[Top.scala 33:39]
  wire  m_regfile_io_w_en; // @[Top.scala 33:39]
  wire [4:0] m_regfile_io_r1_addr; // @[Top.scala 33:39]
  wire [63:0] m_regfile_io_r1_data; // @[Top.scala 33:39]
  wire [4:0] m_regfile_io_r2_addr; // @[Top.scala 33:39]
  wire [63:0] m_regfile_io_r2_data; // @[Top.scala 33:39]
  wire  commit_clock; // @[Top.scala 91:28]
  wire [7:0] commit_coreid; // @[Top.scala 91:28]
  wire [7:0] commit_index; // @[Top.scala 91:28]
  wire  commit_valid; // @[Top.scala 91:28]
  wire [63:0] commit_pc; // @[Top.scala 91:28]
  wire [31:0] commit_instr; // @[Top.scala 91:28]
  wire  commit_skip; // @[Top.scala 91:28]
  wire  commit_isRVC; // @[Top.scala 91:28]
  wire  commit_scFailed; // @[Top.scala 91:28]
  wire  commit_wen; // @[Top.scala 91:28]
  wire [63:0] commit_wdata; // @[Top.scala 91:28]
  wire [7:0] commit_wdest; // @[Top.scala 91:28]
  wire  trap_clock; // @[Top.scala 109:26]
  wire [7:0] trap_coreid; // @[Top.scala 109:26]
  wire  trap_valid; // @[Top.scala 109:26]
  wire [2:0] trap_code; // @[Top.scala 109:26]
  wire [63:0] trap_pc; // @[Top.scala 109:26]
  wire [63:0] trap_cycleCnt; // @[Top.scala 109:26]
  wire [63:0] trap_instrCnt; // @[Top.scala 109:26]
  reg  word_select; // @[Top.scala 35:64]
  reg  REG; // @[Top.scala 96:35]
  reg [63:0] REG_1; // @[Top.scala 97:56]
  reg [63:0] REG_2; // @[Top.scala 97:48]
  reg [63:0] REG_3; // @[Top.scala 97:40]
  reg [63:0] REG_4; // @[Top.scala 97:32]
  reg [31:0] REG_5; // @[Top.scala 98:51]
  reg [31:0] REG_6; // @[Top.scala 98:43]
  reg [31:0] REG_7; // @[Top.scala 98:35]
  reg  REG_8; // @[Top.scala 102:33]
  reg [63:0] REG_9; // @[Top.scala 103:35]
  reg [4:0] REG_10; // @[Top.scala 104:35]
  reg [31:0] cycleCnt; // @[Top.scala 106:31]
  wire [31:0] _cycleCnt_T_1 = cycleCnt + 32'h1; // @[Top.scala 107:30]
  If m_if ( // @[Top.scala 29:47]
    .clock(m_if_clock),
    .reset(m_if_reset),
    .io_inst_addr(m_if_io_inst_addr),
    .io_pc(m_if_io_pc)
  );
  Id m_id ( // @[Top.scala 30:47]
    .clock(m_id_clock),
    .io_inst(m_id_io_inst),
    .io_pc(m_id_io_pc),
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
  Exe m_exe ( // @[Top.scala 31:47]
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
  MemStage m_mem ( // @[Top.scala 32:47]
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
    .io_mem_addr_wr(m_mem_io_mem_addr_wr),
    .io_mem_addr_rd(m_mem_io_mem_addr_rd),
    .io_mem_en_rd(m_mem_io_mem_en_rd),
    .io_mem_en_wr(m_mem_io_mem_en_wr),
    .io_mem_data_wr(m_mem_io_mem_data_wr),
    .io_mem_data_rd(m_mem_io_mem_data_rd)
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
  DifftestInstrCommit commit ( // @[Top.scala 91:28]
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
  DifftestTrapEvent trap ( // @[Top.scala 109:26]
    .clock(trap_clock),
    .coreid(trap_coreid),
    .valid(trap_valid),
    .code(trap_code),
    .pc(trap_pc),
    .cycleCnt(trap_cycleCnt),
    .instrCnt(trap_instrCnt)
  );
  assign io_inst_ram_rIdx = m_if_io_inst_addr; // @[Top.scala 67:65]
  assign io_inst_ram_wIdx = m_mem_io_mem_addr_wr; // @[Top.scala 69:65]
  assign io_inst_ram_wdata = m_mem_io_mem_data_wr; // @[Top.scala 70:65]
  assign io_inst_ram_wmask = m_mem_io_mem_data_wr; // @[Top.scala 71:65]
  assign io_inst_ram_wen = m_mem_io_mem_en_wr; // @[Top.scala 72:65]
  assign io_data_ram_en = m_mem_io_mem_en_rd; // @[Top.scala 74:65]
  assign io_data_ram_rIdx = m_mem_io_mem_addr_rd; // @[Top.scala 75:65]
  assign io_data_ram_wIdx = m_mem_io_mem_addr_wr; // @[Top.scala 76:65]
  assign io_data_ram_wdata = m_mem_io_mem_data_wr; // @[Top.scala 77:65]
  assign io_data_ram_wmask = m_mem_io_mem_data_wr; // @[Top.scala 78:65]
  assign io_data_ram_wen = m_mem_io_mem_en_wr; // @[Top.scala 79:65]
  assign m_if_clock = clock;
  assign m_if_reset = reset;
  assign m_id_clock = clock;
  assign m_id_io_inst = ~word_select ? io_inst_ram_rdata[63:32] : io_inst_ram_rdata[31:0]; // @[Top.scala 37:60]
  assign m_id_io_pc = m_if_io_pc; // @[Top.scala 38:57]
  assign m_id_io_rs1_data = m_regfile_io_r1_data; // @[Top.scala 43:49]
  assign m_id_io_rs2_data = m_regfile_io_r2_data; // @[Top.scala 44:49]
  assign m_exe_clock = clock;
  assign m_exe_io_op1 = m_id_io_op1; // @[Top.scala 48:49]
  assign m_exe_io_op2 = m_id_io_op2; // @[Top.scala 49:49]
  assign m_exe_io_imm = m_id_io_imm; // @[Top.scala 50:49]
  assign m_exe_io_rd = m_id_io_rd; // @[Top.scala 51:49]
  assign m_exe_io_fu_type = m_id_io_fu_type; // @[Top.scala 53:49]
  assign m_exe_io_fu_op_type = m_id_io_fu_op_type; // @[Top.scala 52:41]
  assign m_mem_clock = clock;
  assign m_mem_io_wb_addr = m_exe_io_wb_addr; // @[Top.scala 55:49]
  assign m_mem_io_wb_en = m_exe_io_wb_en; // @[Top.scala 56:49]
  assign m_mem_io_wb_data = m_exe_io_wb_data; // @[Top.scala 57:49]
  assign m_mem_io_op1 = m_exe_io_op1_o; // @[Top.scala 58:49]
  assign m_mem_io_op2 = m_exe_io_op2_o; // @[Top.scala 59:49]
  assign m_mem_io_imm = m_exe_io_imm_o; // @[Top.scala 60:49]
  assign m_mem_io_fu_type = m_exe_io_fu_type_o; // @[Top.scala 61:49]
  assign m_mem_io_fu_op_type = m_exe_io_fu_op_type_o; // @[Top.scala 62:49]
  assign m_mem_io_mem_data_rd = io_data_ram_rdata; // @[Top.scala 65:49]
  assign m_regfile_clock = clock;
  assign m_regfile_reset = reset;
  assign m_regfile_io_w_addr = m_mem_io_wb_addr_r; // @[Top.scala 84:49]
  assign m_regfile_io_w_data = m_mem_io_wb_data_r; // @[Top.scala 85:49]
  assign m_regfile_io_w_en = m_mem_io_wb_en_r; // @[Top.scala 86:49]
  assign m_regfile_io_r1_addr = m_id_io_rs1; // @[Top.scala 40:41]
  assign m_regfile_io_r2_addr = m_id_io_rs2; // @[Top.scala 41:41]
  assign commit_clock = clock; // @[Top.scala 92:25]
  assign commit_coreid = 8'h0; // @[Top.scala 93:26]
  assign commit_index = 8'h0; // @[Top.scala 94:25]
  assign commit_valid = REG; // @[Top.scala 96:25]
  assign commit_pc = REG_4; // @[Top.scala 97:22]
  assign commit_instr = REG_7; // @[Top.scala 98:25]
  assign commit_skip = 1'h0; // @[Top.scala 99:24]
  assign commit_isRVC = 1'h0; // @[Top.scala 100:25]
  assign commit_scFailed = 1'h0; // @[Top.scala 101:28]
  assign commit_wen = REG_8; // @[Top.scala 102:23]
  assign commit_wdata = REG_9; // @[Top.scala 103:25]
  assign commit_wdest = {{3'd0}, REG_10}; // @[Top.scala 104:25]
  assign trap_clock = clock; // @[Top.scala 110:26]
  assign trap_coreid = 8'h0; // @[Top.scala 111:26]
  assign trap_valid = commit_instr == 32'h6b; // @[Top.scala 112:45]
  assign trap_code = 3'h0; // @[Top.scala 113:26]
  assign trap_pc = commit_pc; // @[Top.scala 114:26]
  assign trap_cycleCnt = {{32'd0}, cycleCnt}; // @[Top.scala 115:26]
  assign trap_instrCnt = 64'h0; // @[Top.scala 116:26]
  always @(posedge clock) begin
    word_select <= m_if_io_pc[2]; // @[Top.scala 35:75]
    REG <= m_mem_io_wb_en_r; // @[Top.scala 96:35]
    REG_1 <= m_if_io_pc; // @[Top.scala 97:56]
    REG_2 <= REG_1; // @[Top.scala 97:48]
    REG_3 <= REG_2; // @[Top.scala 97:40]
    REG_4 <= REG_3; // @[Top.scala 97:32]
    REG_5 <= m_id_io_inst; // @[Top.scala 98:51]
    REG_6 <= REG_5; // @[Top.scala 98:43]
    REG_7 <= REG_6; // @[Top.scala 98:35]
    REG_8 <= m_mem_io_wb_en_r; // @[Top.scala 102:33]
    REG_9 <= m_mem_io_wb_data_r; // @[Top.scala 103:35]
    REG_10 <= m_mem_io_wb_addr_r; // @[Top.scala 104:35]
    if (reset) begin // @[Top.scala 106:31]
      cycleCnt <= 32'h1; // @[Top.scala 106:31]
    end else begin
      cycleCnt <= _cycleCnt_T_1; // @[Top.scala 107:18]
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
  word_select = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  REG = _RAND_1[0:0];
  _RAND_2 = {2{`RANDOM}};
  REG_1 = _RAND_2[63:0];
  _RAND_3 = {2{`RANDOM}};
  REG_2 = _RAND_3[63:0];
  _RAND_4 = {2{`RANDOM}};
  REG_3 = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  REG_4 = _RAND_5[63:0];
  _RAND_6 = {1{`RANDOM}};
  REG_5 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  REG_6 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  REG_7 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  REG_8 = _RAND_9[0:0];
  _RAND_10 = {2{`RANDOM}};
  REG_9 = _RAND_10[63:0];
  _RAND_11 = {1{`RANDOM}};
  REG_10 = _RAND_11[4:0];
  _RAND_12 = {1{`RANDOM}};
  cycleCnt = _RAND_12[31:0];
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
  wire  rcore_clock; // @[SimTop.scala 35:21]
  wire  rcore_reset; // @[SimTop.scala 35:21]
  wire [63:0] rcore_io_inst_ram_rIdx; // @[SimTop.scala 35:21]
  wire [63:0] rcore_io_inst_ram_rdata; // @[SimTop.scala 35:21]
  wire [63:0] rcore_io_inst_ram_wIdx; // @[SimTop.scala 35:21]
  wire [63:0] rcore_io_inst_ram_wdata; // @[SimTop.scala 35:21]
  wire [63:0] rcore_io_inst_ram_wmask; // @[SimTop.scala 35:21]
  wire  rcore_io_inst_ram_wen; // @[SimTop.scala 35:21]
  wire  rcore_io_data_ram_en; // @[SimTop.scala 35:21]
  wire [63:0] rcore_io_data_ram_rIdx; // @[SimTop.scala 35:21]
  wire [63:0] rcore_io_data_ram_rdata; // @[SimTop.scala 35:21]
  wire [63:0] rcore_io_data_ram_wIdx; // @[SimTop.scala 35:21]
  wire [63:0] rcore_io_data_ram_wdata; // @[SimTop.scala 35:21]
  wire [63:0] rcore_io_data_ram_wmask; // @[SimTop.scala 35:21]
  wire  rcore_io_data_ram_wen; // @[SimTop.scala 35:21]
  wire  inst_ram_clk; // @[SimTop.scala 51:24]
  wire  inst_ram_en; // @[SimTop.scala 51:24]
  wire [63:0] inst_ram_rIdx; // @[SimTop.scala 51:24]
  wire [63:0] inst_ram_rdata; // @[SimTop.scala 51:24]
  wire [63:0] inst_ram_wIdx; // @[SimTop.scala 51:24]
  wire [63:0] inst_ram_wdata; // @[SimTop.scala 51:24]
  wire [63:0] inst_ram_wmask; // @[SimTop.scala 51:24]
  wire  inst_ram_wen; // @[SimTop.scala 51:24]
  wire  data_ram_clk; // @[SimTop.scala 52:24]
  wire  data_ram_en; // @[SimTop.scala 52:24]
  wire [63:0] data_ram_rIdx; // @[SimTop.scala 52:24]
  wire [63:0] data_ram_rdata; // @[SimTop.scala 52:24]
  wire [63:0] data_ram_wIdx; // @[SimTop.scala 52:24]
  wire [63:0] data_ram_wdata; // @[SimTop.scala 52:24]
  wire [63:0] data_ram_wmask; // @[SimTop.scala 52:24]
  wire  data_ram_wen; // @[SimTop.scala 52:24]
  Top rcore ( // @[SimTop.scala 35:21]
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
  RAMHelper inst_ram ( // @[SimTop.scala 51:24]
    .clk(inst_ram_clk),
    .en(inst_ram_en),
    .rIdx(inst_ram_rIdx),
    .rdata(inst_ram_rdata),
    .wIdx(inst_ram_wIdx),
    .wdata(inst_ram_wdata),
    .wmask(inst_ram_wmask),
    .wen(inst_ram_wen)
  );
  RAMHelper data_ram ( // @[SimTop.scala 52:24]
    .clk(data_ram_clk),
    .en(data_ram_en),
    .rIdx(data_ram_rIdx),
    .rdata(data_ram_rdata),
    .wIdx(data_ram_wIdx),
    .wdata(data_ram_wdata),
    .wmask(data_ram_wmask),
    .wen(data_ram_wen)
  );
  assign io_uart_out_valid = 1'h0; // @[SimTop.scala 46:21]
  assign io_uart_out_ch = 8'h0; // @[SimTop.scala 47:18]
  assign io_uart_in_valid = 1'h0; // @[SimTop.scala 45:20]
  assign rcore_clock = clock;
  assign rcore_reset = reset;
  assign rcore_io_inst_ram_rdata = inst_ram_rdata; // @[SimTop.scala 61:41]
  assign rcore_io_data_ram_rdata = data_ram_rdata; // @[SimTop.scala 70:41]
  assign inst_ram_clk = clock; // @[SimTop.scala 54:49]
  assign inst_ram_en = 1'h1; // @[SimTop.scala 55:49]
  assign inst_ram_rIdx = rcore_io_inst_ram_rIdx - 64'h10000000; // @[SimTop.scala 56:75]
  assign inst_ram_wIdx = rcore_io_inst_ram_wIdx; // @[SimTop.scala 57:49]
  assign inst_ram_wdata = rcore_io_inst_ram_wdata; // @[SimTop.scala 58:49]
  assign inst_ram_wmask = rcore_io_inst_ram_wmask; // @[SimTop.scala 59:49]
  assign inst_ram_wen = rcore_io_inst_ram_wen; // @[SimTop.scala 60:49]
  assign data_ram_clk = clock; // @[SimTop.scala 63:49]
  assign data_ram_en = rcore_io_data_ram_en; // @[SimTop.scala 64:49]
  assign data_ram_rIdx = rcore_io_data_ram_rIdx; // @[SimTop.scala 65:49]
  assign data_ram_wIdx = rcore_io_data_ram_wIdx; // @[SimTop.scala 66:49]
  assign data_ram_wdata = rcore_io_data_ram_wdata; // @[SimTop.scala 67:49]
  assign data_ram_wmask = rcore_io_data_ram_wmask; // @[SimTop.scala 68:49]
  assign data_ram_wen = rcore_io_data_ram_wen; // @[SimTop.scala 69:49]
endmodule
