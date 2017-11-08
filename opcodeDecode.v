//-----------------------------------------------------------------------------
// Instruction decode opcode decoder module
//-----------------------------------------------------------------------------

module opcodeDecode(
  input       [5:0]  opcode,
  input       [5:0]  funct,
  output reg         reg_wr,
  output reg         reg_dst,
  output reg         ALU_src,
  output reg  [2:0]  ALU_ctrl,
  output reg         mem_wr,
  output reg         mem_to_reg,
  output reg         jl,
  output reg         jal,
  output reg         jr,
  output reg         branch,
  output reg         zero_ext
  );

  // Define opcode localparams
  localparam
  LW = 6'h23,
  SW = 6'h2b,
  J = 6'h2,
  JAL = 6'h3,
  BNE = 6'h5,
  XORI = 6'he,
  ADDI = 6'h8,
  RTYPE = 6'h0;

  // define funct localparams
  localparam
  r_jr = 6'h8,
  r_add = 6'h20,
  r_sub = 6'h22,
  r_slt = 6'h2a;

  // Concatenate all signals into 1
  // reg_wr, reg_dst, ALU_src, ALU_ctrl, mem_wr, mem_to_reg, jl, jal, jr, branch, zero_ext
  reg [12:0] control;

  // combinational block
  always @(*) begin
    case (opcode)
      LW:
        control = 13'b1_0100_0010_0000;
      SW:
        control = 13'b0_0100_0100_0000;
      J:
        control = 13'b0_0000_0001_0000;
      JAL:
        control = 13'b1_0000_0001_1000;
      BNE:
        control = 13'b0_0000_1000_0010;
      XORI:
        control = 13'b1_0101_0000_0001;
      ADDI:
        control = 13'b1_0100_0000_0000;
      RTYPE: // For R-type instructions we need to check the funct bits
        case (funct)
          r_jr:
            control = 13'b0_0000_0000_0100;
          r_add:
            control = 13'b1_1000_0000_0000;
          r_sub:
            control = 13'b1_1000_1000_0000;
          r_slt:
            control = 13'b1_1001_1000_0000;
          default:
            control = 13'b0;
        endcase
      default: // Just NOP if something goes screwy here
        control = 13'b0;
    endcase
    // Split out control signal assignment
    {reg_wr, reg_dst, ALU_src, ALU_ctrl, mem_wr, mem_to_reg, jl, jal, jr, branch, zero_ext} = control;
  end

endmodule
