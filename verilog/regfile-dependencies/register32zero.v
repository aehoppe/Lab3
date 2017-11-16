// 32-bit D Flip-Flop with enable
//   Positive edge triggered

module register32zero
(
output reg[31:0] q,
input[31:0] d,
input wrenable,
input	clk
);

  always @(posedge clk) begin
    q = 32'b0;
  end

endmodule
