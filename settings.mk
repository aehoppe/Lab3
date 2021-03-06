# Project-specific settings

## Assembly settings

# Assembly program (minus .asm extension)
PROGRAM := basic_testbench

# Memory image(s) to create from the assembly program
MEMDUMP := $(PROGRAM).text.hex


## Verilog settings

# Top-level module/filename (minus .v/.t.v extension)
TOPLEVEL := singleCycleCPU

# All circuits included by the toplevel $(TOPLEVEL).t.v
CIRCUITS := $(TOPLEVEL).v
