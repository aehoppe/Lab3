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
  output reg [width-1:0]      InstrOut,
  input [addresswidth-1:0]    address,
  input [addresswidth-1:0]    InstrAddr,
  input                       writeEnable,
  input [width-1:0]           dataIn,
  input 		                  clk
);
  reg [width-1:0] memory [depth-1:0];

  always @(address) begin
    dataOut <= memory[address];
  end

  always @(InstrAddr) begin
    InstrOut <= memory[InstrAddr];
  end

  always @(negedge clk) begin
    if(writeEnable)
      memory[address] <= dataIn;
  end

endmodule
