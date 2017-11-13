//------------------------------------------------------------------------
// Data Memory
//   Positive edge triggered
//   dataOut always has the value mem[address]
//   If writeEnable is true, writes dataIn to mem[address]
//------------------------------------------------------------------------

module dataMemory
#(
  parameter addresswidth  = 7,
  parameter depth         = 2**addresswidth,
  parameter width         = 8
)
(
  output reg [width-1:0]      dataOut,
  input [addresswidth-1:0]    address,
  input                       writeEnable,
  input [width-1:0]           dataIn,
  input 		                  clk
);
  reg [width-1:0] memory [depth-1:0];

  always @(posedge clk) begin
    if(writeEnable)
      memory[address] <= dataIn;
    dataOut <= memory[address];
  end

endmodule