# Lab 3 Writeup
### William Derksen, Alexander Hoppe, Sam Myers, Taylor Sheneman

## Processor architecture

In this lab we designed a Single Cycle CPU complete with an Instruction Fetch Unit, Instruction Decoding, Execution Hub, Memory Accessing, and WriteBack to Registers.  We designed it fairly similar to the designs seen in class with a couple important changes in order to accommodate different instructions.

The quick explanation of the architecture in that our architecture uses the value from the Program counter to fetch instructions from the first piece of the memory (from address 0 - 8192).  We then decode this instruction into each of the essential pieces of the I- J- and R-type signals, as well as into an array of control signals depending on the op code.  Next these signals and controls affect the Program counter in the instruction fetch unit (in order to branch and jump), the ALU (in order to do different math operations), the Memory (in order to load and store), and the RegFile (for determining I J and R type instructions).

ChangeLog:

In order to correctly to do the new instruction xori, we needed to create a more versatile Sign Extend that could also Zero Extend,  We came up with a nice design that allowed for both of these processes without needing a bitwise mux.  We managed to do this by creating a Sign Extend control signal, by setting the seventeenth value of the input to the and of the control signal and the sixteenth value of the input.  Then we sign extend naturally from the 17th value.

Additionally, for jump and link we added two new muxes, one for choosing register $31 in order to do jal, and one right before the write back to the Dw port for the regfile.  This sets the PC to the value that is to be written to register $31.  For jal, the jump part is the same as a normal jump instruction.


### Block Diagram


### RTL Examples and Walkthroughs



## Test Plan

### Results


## Performance/Area Design analysis



## Work Plan Reflection
