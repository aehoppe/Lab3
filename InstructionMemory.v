module InstructionMemory
(
  output[31:0]  DataOut,
  input clk, regWE,
  input[9:0] Addr,
  input[31:0] DataIn
);

  reg[31:0] mem[1023:0];


  initial $readmemh("Memories/addingtest.dat", mem);//Memories/mips1.asm

  always @(posedge clk) begin
    if (regWE) begin
      mem[Addr] <= DataIn;
    end
  end

  assign DataOut = mem[Addr];
endmodule
