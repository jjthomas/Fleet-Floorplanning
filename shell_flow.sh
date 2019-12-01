#!/bin/bash

# ./shell_flow.sh <shell verilog file> <shell module> <template kernel verilog file> <template kernel module>

timestamp=$(date +"%y_%m_%d-%H%M%S")
log=shell_${timestamp}.log

{
  ./opt_shell.sh $1 $2
  ./opt_kernel.sh $3 $4
  ./route_shell_kernel_ifs.sh
  ./route_if_shell.sh
} 2>&1 | tee $log

echo "Summary of Exceptions:"
grep -n Exception $log
echo "Summary of errors ($log):"
grep -n ERROR $log
echo "Timing summary:"
grep WNS $log | tail -n 1
