//------------------------------------------------------------------------------
// 32-bit Single Cycle CPU top level module
// Implements MIPS reduced ISA of:
//    `LW`, `SW`, `J`, `JR`, `JAL`, `BNE`, `XORI`, `ADDI`, `ADD`, `SUB`, `SLT`
// 4Gb memory, single-cycle operation
//------------------------------------------------------------------------------

`include "dataPath.v"
`include "instructionFetch.v"
`include "instructionDecode.v"
`include "dataMemory.v"

module singleCycleCPU (
  input clk
  );

  wire            carryout, ovf, zero;
  wire  [31:0]    Da;
  wire  [31:0]    PC;
  wire  [25:0]    target_address;
  wire  [4:0]     rs;
  wire  [4:0]     rt;
  wire  [4:0]     rd;
  wire  [15:0]    imm16;
  wire            reg_wr;
  wire            reg_dst;
  wire            ALU_src;
  wire  [2:0]     ALU_ctrl;
  wire            mem_wr;
  wire            mem_to_reg;
  wire            jl;
  wire            jal;
  wire            jr;
  wire            branch;
  wire            zero_ext;
  wire  [31:0]    instruction;

  wire  [31:0]    ALU_out;
  wire  [31:0]    Db;
  wire  [31:0]    mem_dout;
  wire  [31:0]    InstrAddr;

  instructionFetch instr_fetch(
      //instruction,
      PC,
      target_address,
      imm16,
      zero,
      branch,
      Da,
      jr,
      jl,
      clk
    );

  instructionDecode instr_decode(
      target_address,
      rs,
      rt,
      rd,
      imm16,
      reg_wr,
      reg_dst,
      ALU_src,
      ALU_ctrl,
      mem_wr,
      mem_to_reg,
      jl,
      jal,
      jr,
      branch,
      zero_ext,
      instruction
    );

  dataPath data_path(
      carryout, ovf, zero,
      Da,
      ALU_out,
      Db,
      mem_dout,
      PC,
      rs,
      rt,
      rd,
      imm16,
      reg_wr,
      reg_dst,
      ALU_src,
      ALU_ctrl,
      //mem_wr,
      mem_to_reg,
      jl,
      jal,
      jr,
      branch,
      zero_ext,
      clk
    );
    dataMemory #(.addresswidth(32),.depth(32'h4000),.width(32))
    data_mem (
      .dataOut(mem_dout),
      .InstrOut(instruction),
      .address(ALU_out),
      .InstrAddr(PC),
      .writeEnable(mem_wr),
      .dataIn(Db),
      .clk(clk)
      );



endmodule
