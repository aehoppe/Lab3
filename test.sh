#!/bin/bash

make clean
make
gtkwave filters/singleCycleCPU-basic_testbench.gtkw
