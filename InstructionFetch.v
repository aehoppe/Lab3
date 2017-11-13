`include "regfile-dependencies/register32.v"
`include "signExtend.v"
`include "alu.v"
`include "InstructionMemory.v"

module InstructionFetch
(
  output[31:0] Instr,
  output[9:0] PC,
  input[25:0] TargetAddr,
  input[15:0] Imm16,
  input zero,
  input Branch,
  input[31:0] Da,
  input jr,
  input jl,
  input clk
);
  //Jumping
  wire[31:0] newAddr;
  wire[31:0] jumpaddr;
  wire[31:0] addunit;
  wire[31:0] added;
  wire[31:0] same_branch_addr;
  wire[31:0] signextimm;
  wire muxsig1;
  //wire nextAddr;
  register32 PC_module (PC, newAddr, 1'b1, clk);
  signExtend IF_SE (signextimm, Imm16, 1'b0);
  InstructionMemory InstMem(Instr, {PC[31:2], 2'b00}, clk);
  assign jumpaddr = {PC[31:28],TargetAddr, 2'b00};
  assign muxsig1 = (!zero && Branch);
  assign addunit = muxsig1 ? signextimm : 32'b0;
  assign added = addunit + PC + 1;
  assign same_branch_addr = jr ? Da : added;
  assign newAddr = jl ? jumpaddr : same_branch_addr;

endmodule
