`include "regfile-dependencies/register32.v"
`include "signExtend.v"

module InstructionFetchUnit
(
  output[31:0] Instr,
  input[25:0] TargetAddr,
  input Imm16,
  input zero,
  input Branch,
  input Da,
  input jr,
  input j,
  input clk
);
  //Jumping
  wire[31:0] regOut;
  wire[31:0] currAddr;
  register32 PC (regOut, currAddr, 1'b1, clk);
  wire[31:0] jumpaddr;
  assign jumpaddr = {currAddr[31:28],TargetAddr, 2'b00};
  wire nextAddr;

  //Branching and continuing
  wire muxsig1;
  assign muxsig1 = (not zero && Branch);
  wire add;
  SignExtend(Imm16, 1'b0)
  assign
endmodule
