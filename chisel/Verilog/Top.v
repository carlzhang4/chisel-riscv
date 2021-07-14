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
  output [6:0]  io_fu_op_type
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
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
  wire [6:0] _decode_list_T_146 = _decode_list_T_73 ? 7'h7 : 7'h40; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_147 = _decode_list_T_71 ? 7'h6 : _decode_list_T_146; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_148 = _decode_list_T_69 ? 7'hd : _decode_list_T_147; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_149 = _decode_list_T_67 ? 7'h5 : _decode_list_T_148; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_150 = _decode_list_T_65 ? 7'h4 : _decode_list_T_149; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_151 = _decode_list_T_63 ? 7'h3 : _decode_list_T_150; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_152 = _decode_list_T_61 ? 7'h2 : _decode_list_T_151; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_153 = _decode_list_T_59 ? 7'h1 : _decode_list_T_152; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_154 = _decode_list_T_57 ? 7'h8 : _decode_list_T_153; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_155 = _decode_list_T_55 ? 7'h40 : _decode_list_T_154; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_156 = _decode_list_T_53 ? 7'hd : _decode_list_T_155; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_157 = _decode_list_T_51 ? 7'h5 : _decode_list_T_156; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_158 = _decode_list_T_49 ? 7'h1 : _decode_list_T_157; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_159 = _decode_list_T_47 ? 7'h7 : _decode_list_T_158; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_160 = _decode_list_T_45 ? 7'h6 : _decode_list_T_159; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_161 = _decode_list_T_43 ? 7'h4 : _decode_list_T_160; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_162 = _decode_list_T_41 ? 7'h3 : _decode_list_T_161; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_163 = _decode_list_T_39 ? 7'h2 : _decode_list_T_162; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_164 = _decode_list_T_37 ? 7'h40 : _decode_list_T_163; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_165 = _decode_list_T_35 ? 7'h0 : _decode_list_T_164; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_166 = _decode_list_T_33 ? 7'h0 : _decode_list_T_165; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_167 = _decode_list_T_31 ? 7'h0 : _decode_list_T_166; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_168 = _decode_list_T_29 ? 7'h0 : _decode_list_T_167; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_169 = _decode_list_T_27 ? 7'h0 : _decode_list_T_168; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_170 = _decode_list_T_25 ? 7'h0 : _decode_list_T_169; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_171 = _decode_list_T_23 ? 7'h0 : _decode_list_T_170; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_172 = _decode_list_T_21 ? 7'h0 : _decode_list_T_171; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_173 = _decode_list_T_19 ? 7'h17 : _decode_list_T_172; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_174 = _decode_list_T_17 ? 7'h16 : _decode_list_T_173; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_175 = _decode_list_T_15 ? 7'h15 : _decode_list_T_174; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_176 = _decode_list_T_13 ? 7'h14 : _decode_list_T_175; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_177 = _decode_list_T_11 ? 7'h11 : _decode_list_T_176; // @[Lookup.scala 33:37]
  wire [6:0] _decode_list_T_178 = _decode_list_T_9 ? 7'h10 : _decode_list_T_177; // @[Lookup.scala 33:37]
  reg [6:0] io_fu_op_type_REG; // @[Id_stage.scala 66:40]
  assign io_fu_op_type = io_fu_op_type_REG; // @[Id_stage.scala 66:25]
  always @(posedge clock) begin
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
  io_fu_op_type_REG = _RAND_0[6:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Exe(
  input  [6:0]  io_fu_op_type,
  output [63:0] io_wb_data
);
  wire  wb_en = 7'h40 == io_fu_op_type; // @[Mux.scala 80:60]
  assign io_wb_data = wb_en ? 64'h1 : 64'h0; // @[Mux.scala 80:57]
endmodule
module MemStage(
  input         clock,
  input  [63:0] io_wb_data,
  output [63:0] io_wb_data_r
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] io_wb_data_r_REG; // @[Mem_stage.scala 18:40]
  assign io_wb_data_r = io_wb_data_r_REG; // @[Mem_stage.scala 18:25]
  always @(posedge clock) begin
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
  _RAND_0 = {2{`RANDOM}};
  io_wb_data_r_REG = _RAND_0[63:0];
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
  wire [6:0] m_id_io_fu_op_type; // @[Top.scala 19:47]
  wire [6:0] m_exe_io_fu_op_type; // @[Top.scala 20:47]
  wire [63:0] m_exe_io_wb_data; // @[Top.scala 20:47]
  wire  m_mem_clock; // @[Top.scala 21:47]
  wire [63:0] m_mem_io_wb_data; // @[Top.scala 21:47]
  wire [63:0] m_mem_io_wb_data_r; // @[Top.scala 21:47]
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
    .io_fu_op_type(m_id_io_fu_op_type)
  );
  Exe m_exe ( // @[Top.scala 20:47]
    .io_fu_op_type(m_exe_io_fu_op_type),
    .io_wb_data(m_exe_io_wb_data)
  );
  MemStage m_mem ( // @[Top.scala 21:47]
    .clock(m_mem_clock),
    .io_wb_data(m_mem_io_wb_data),
    .io_wb_data_r(m_mem_io_wb_data_r)
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
  assign m_exe_io_fu_op_type = m_id_io_fu_op_type; // @[Top.scala 42:41]
  assign m_mem_clock = clock;
  assign m_mem_io_wb_data = m_exe_io_wb_data; // @[Top.scala 47:57]
endmodule
