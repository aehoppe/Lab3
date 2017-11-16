//------------------------------------------------------------------------------
// Top-level test for single-cycle CPU
//------------------------------------------------------------------------------

`include "singleCycleCPU.v"

module singleCycleCPUTestHarness();

  //
  reg clk;

  // Clock generation
  initial clk=0;
  always #10 clk = !clk;

  // Instantiate fake CPU
  singleCycleCPU cpu(.clk(clk));

  // Test sequence
  initial begin

    // // Get command line arguments for memory image and VCD dump file
    // //   http://iverilog.wikia.com/wiki/Simulation
    // //   http://www.project-veripage.com/plusarg.php
    // if (! $value$plusargs("mem_fn=%s", mem_fn)) begin
    //   $display("ERROR: provide +mem_fn=[path to memory image] argument");
    //   $finish();
    // end
    // if (! $value$plusargs("dump_fn=%s", dump_fn)) begin
    //   $display("ERROR: provide +dump_fn=[path for VCD dump] argument");
    //   $finish();
    // end


    // Load CPU memory from (assembly) dump file
    $readmemh("~/Documents/CompArch/Lab3/asm/quicksort.text.hex", cpu.data_mem.memory, 0, 32'h0FFC);
    $readmemh("~/Documents/Comparch/Lab3/asm/quicksort.data.hex", cpu.data_mem.memory, 32'h2000, 32'h3FFF);
    // Alternate: Explicitly state which array element range to read into
    //$readmemh("mymem.hex", memory, 10, 80);

    // Dump waveforms to file
    // Note: arrays (e.g. memory) are not dumped by default
    $dumpfile("quicksort.vcd");
    $dumpvars();

    // Display a few cycles just for quick checking
  	// Note: I'm just dumping instruction bits, but you can do some
  	// self-checking test cases based on your CPU and program and
  	// automatically report the results.
  	$display("Time | PC       | Instruction");
  	repeat(10) begin
          $display("%4t | %h | %h", $time, cpu.PC, cpu.instruction); #20 ;
          end
  	$display("... more execution (see waveform)");

  	// End execution after some time delay - adjust to match your program
  	// or use a smarter approach like looking for an exit syscall or the
  	// PC to be the value of the last instruction in your program.
  	#2000 $finish();

  end

endmodule
