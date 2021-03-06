// 32-bit D Flip-Flop with enable
//   Positive edge triggered

module negRegister32
(
output reg[31:0] q,
input[31:0] d,
input wrenable,
input	clk
);
  initial begin
    q = 32'b0;
  end

  always @(negedge clk) begin
    if(wrenable) begin
      q = d;
    end
  end

endmodule
