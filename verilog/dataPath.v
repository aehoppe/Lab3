//------------------------------------------------------------------------------
// Instruction decoder module
//------------------------------------------------------------------------------

`include "alu.v"
//`include "dataMemory.v"
`include "regfile.v"
`include "signExtend.v"

module dataPath(
  output            carryout, ovf, zero,
  output  [31:0]    Da,
  output  [31:0]    ALU_out,
  output  [31:0]    Db,
  input   [31:0]    mem_dout,
  input   [31:0]    PC,
  input   [4:0]     Rs,
  input   [4:0]     Rt,
  input   [4:0]     Rd,
  input   [15:0]    imm16,
  input             reg_wr,
  input             reg_dst,
  input             ALU_src,
  input   [2:0]     ALU_ctrl,
  //input             mem_wr,
  input             mem_to_reg,
  input             jl,
  input             jal,
  input             jr,
  input             branch,
  input             zero_ext,
  input             clk
  );

  // Declare internal wires
  wire  [4:0]   dest_reg;         // Output of reg_dst mux
  wire  [4:0]   Aw;               // Output of jal mux
  wire  [31:0]  Dw;               // Output of writeback/PC+8 mux for JAL
  wire  [31:0]  se_ze_imm16;      // Output of sign/zero extender
  wire  [31:0]  A, B;             // Inputs to ALU
  //wire  [31:0]  ALU_out;          // Output of ALU
  wire  [31:0]  writeback;        // Output of mem_to_reg mux
  wire  [31:0]  mem_dout;         // Output of memory

  // Set up MUXes for regfile write address
  assign dest_reg = reg_dst ? Rd : Rt;
  assign Aw = jal ? 5'd31 : dest_reg;

  // Set up jal link register mux
  assign Dw = jal ? ((PC << 2) + 32'd8) : writeback;

  // Set up regfile
  regfile reg_file(Da, Db, Dw, Rs, Rt, Aw, reg_wr, clk);

  // Set up ALU immediate/register source mux
  assign B = ALU_src ? se_ze_imm16 : Db;
  signExtend sign_extend(se_ze_imm16, imm16, zero_ext);

  // Set up ALU
  assign A = Da;
  ALU alu(ALU_out, carryout, ovf, zero, A, B, ALU_ctrl);

  // Set up data memory
  //dataMemory #(32,32'h4000,32) data_mem (mem_dout, ALU_out, mem_wr, Db, clk);
  // Set up load/result mux
  assign writeback = mem_to_reg ? mem_dout : ALU_out;







endmodule
