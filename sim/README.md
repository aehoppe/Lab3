# Assembly and Verilog simulation example

This code demonstrates several concepts that could be helpful for testing your CPU:

* cpu: Fake CPU Verilog - doesn't do much, but shows instructions loaded into memory and flowing through a pipeline
* asm: Turning assembly code into a memory image on the command line
* filters: GTKWave filter files that may be useful for various MIPS instruction fields, and a saved GTKWave session showing them all in use
* Various Makefiles demonstrating how these tasks can be automated

At the root, run ```make``` to

1. assemble the example program
1. compile the Verilog cpu into a vvp simulator
1. run the simulation, loading the assembly program into CPU memory

You can run ```make scope``` to load the waveform in GTKWave with some nice filters added.

```make clean``` removes all generated files (which you should not be committing in your own repos).

