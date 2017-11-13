module InstructionMemory
(
  output[31:0]  DataOut,
  //input regWE, //for actual memory
  input[9:0] Addr,
  //input[31:0] DataIn, //this is for the actual memory
  input clk
);

  reg[31:0] mem[1023:0];


  initial $readmemh("Memories/addingtest.dat", mem);//Memories/mips1.asm

  /*always @(posedge clk) begin
    if (regWE) begin
      mem[Addr] <= DataIn;
    end
  end*/ //This is for the actual memory

  assign DataOut = mem[Addr];
endmodule
