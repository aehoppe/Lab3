`include "counter.v"

//------------------------------------------------------------------------
// Fake CPU with three "pipeline stages" A -> B -> C
//------------------------------------------------------------------------

module fake_cpu
(
    input clk,
    input reset
);

    //--------------------------------------------------------------------
    // Stage A - "Instruction Fetch"

    wire [31:0] PC_A;
    wire [31:0] INS_A;

    // Simplified PC generation unit - increments by 4 every cycle
    counter #(.width(32), .increment(4)) pc_incr(.count(PC_A), 
	                                         .clk(clk),
						 .reset(reset));


    // 16KiB memory, organized as 4096 element array of 32-bit words
    reg [31:0] memory [4095:0];
    // Alternate: 16KiB memory, organized as 16384 element array of bytes
    // reg [7:0] memory [2**14-1:0];


    // Simplified memory "read port"
    assign INS_A = memory[ PC_A[13:2] ];
    // Note: Discards the low 2 bits of the PC (should be zero) since I've
    // implemented my memory as an array of words instead of bytes. Discards
    // upper 18 bits of PC (should be zero) because my memory is only 16 KiB
    // (smaller than maximum addressible 2^32 bytes).

    // Non-synthesizable debugging code for checking assertions about PC
    always @(PC_A) begin
        if (| PC_A[1:0]) begin	// Lower PC bits != 00
	    $display("Warning: misaligned PC access, truncating: %h", PC_A);
	end
	if (| PC_A[31:14]) begin  // Upper PC bits non-zero
	    $display("Error: PC outside implemented memory range: %h", PC_A);
	    $stop();
	end
    end

    //--------------------------------------------------------------------
    // Stages B and C - fake functionality to see more signals propagate

    reg [31:0] PC_B, PC_C;
    reg [31:0] INS_B, INS_C;

    // Op-code is the upper 6 bits, for all instruction formats
    wire [5:0] OP_B;
    reg  [5:0] OP_C;
    assign OP_B = INS_B[31:26];

    // Funct code is the lowest 6 bits for R type (not meaningful for others)
    wire [5:0] FUNCT_C;
    assign FUNCT_C = INS_C[5:0];

    // Register addresses (not meaningful for J-type instructions) 
    wire [4:0] RS_C, RT_C;
    assign RS_C = INS_C[25:21];
    assign RT_C = INS_C[20:16];


    //--------------------------------------------------------------------
    // Registers between pipeline stages
    
    always @(posedge clk) begin
	// A-B registers
        PC_B  <= PC_A;
	INS_B <= INS_A;

	// B-C registers
        PC_C  <= PC_B;
	INS_C <= INS_B;
	OP_C  <= OP_B;
    end

endmodule
