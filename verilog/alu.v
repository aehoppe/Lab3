//------------------------------------------------------------------------------
// Arithmetic Logic Unit
//   2 inputs of width: 32 bits
//   input: 3 bit control signal
//   output width: 32 bits
//   output: carryout, overflow, zero flags
//------------------------------------------------------------------------------

module ALU
(
    output reg[31:0] out,
    output reg carryout, ovf, zero,
    input signed[31:0] a,
    input signed[31:0] b,
    input[2:0] cmd
);
    localparam
    ADD = 3'd0,
    SUB = 3'd1,
    XOR = 3'd2,
    SLT = 3'd3,
    AND = 3'd4,
    NAND = 3'd5,
    NOR = 3'd6,
    OR  = 3'd7;

    always @(*) begin
      case (cmd)
        ADD: begin
          {carryout, out} = {1'b0, a} + {1'b0, b};
          ovf = (a[31] ~^ b[31]) && (a[31] ^ out[31]) ? 1 : 0;
          zero = (a + b == 0) ? 1 : 0;
        end

        SUB: begin
          {carryout, out} = {1'b0, a} + {1'b0, ~b} + 32'b1;
          ovf = (a[31] ^ b[31]) && (a[31] ^ out[31]) ? 1 : 0;
          zero = (a - b == 0) ? 1 : 0;
        end

        XOR: begin
          out = a ^ b;
          {carryout, ovf, zero} = 3'b0;
        end

        SLT: begin
          out = (a < b) ? 32'b1 : 0;
          {carryout, ovf, zero} = 3'b0;
        end

        AND: begin
          out = a & b;
          {carryout, ovf, zero} = 3'b0;
        end

        NAND: begin
          out = a ~& b;
          {carryout, ovf, zero} = 3'b0;
        end

        NOR: begin
          out = a ~| b;
          {carryout, ovf, zero} = 3'b0;
        end

        OR: begin
          out = a | b;
          {carryout, ovf, zero} = 3'b0;
        end
      endcase
    end

endmodule
