//------------------------------------------------------------------------------
// Sign Extend or Zero Extend
//   input: 16 bit immediate
//   input: 1 bit selector signal
//   output width: 32 bits
//------------------------------------------------------------------------------

module signExtend
(
  output[31:0] out,
  input[15:0] imm16,
  input zeroExtend
);

  assign out = zeroExtend ? {16'b0, imm16} : {{16{imm16[15]}}, imm16};

endmodule
