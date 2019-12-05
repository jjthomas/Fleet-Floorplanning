#!/bin/bash

# ./kernel_flow.sh <kernel verilog file> <kernel module>

timestamp=$(date +"%y_%m_%d-%H%M%S")
log=kernel_${2}_${timestamp}.log

{
  ./opt_kernel.sh $1 $2
  ./route_if_kernels.sh $2
} 2>&1 | tee $log

echo; echo "Summary of Exceptions ($log):"
grep -n "[^ ]Exception" $log
echo; echo "Summary of errors ($log):"
grep -n ERROR $log
echo; echo "Summary of critical warnings ($log):"
grep -n "CRITICAL WARNING" $log
echo; echo "Timing summaries:"
grep "TIMING SUMMARY" $log
