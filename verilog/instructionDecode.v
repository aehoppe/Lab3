//------------------------------------------------------------------------------
// Instruction decoder module
//------------------------------------------------------------------------------

`include "opcodeDecode.v"

module instructionDecode(
  output  [25:0]    target_address,
  output  [4:0]     rs,
  output  [4:0]     rt,
  output  [4:0]     rd,
  output  [15:0]    imm16,
  output            reg_wr,
  output            reg_dst,
  output            ALU_src,
  output  [2:0]     ALU_ctrl,
  output            mem_wr,
  output            mem_to_reg,
  output            jl,
  output            jal,
  output            jr,
  output            branch,
  output            zero_ext,
  input   [31:0]    instruction
  );

  wire [5:0] opcode, funct;

  // R-type instructions
  assign opcode = instruction[31:26];
  assign rs = instruction[25:21];
  assign rt = instruction[20:16];
  assign rd = instruction[15:11];
  assign funct = instruction[5:0];

  // J-type instructions
  assign imm16 = instruction[15:0];

  // I-type instructions
  assign target_address = instruction[25:0];

  // Instantiate LUT for opcodes
  opcodeDecode op_decoder(
    .reg_wr(reg_wr),
    .reg_dst(reg_dst),
    .ALU_src(ALU_src),
    .ALU_ctrl(ALU_ctrl),
    .mem_wr(mem_wr),
    .mem_to_reg(mem_to_reg),
    .jl(jl),
    .jal(jal),
    .jr(jr),
    .branch(branch),
    .zero_ext(zero_ext),
    .opcode(opcode),
    .funct(funct)
    );

endmodule
