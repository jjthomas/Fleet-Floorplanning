#!/bin/bash

# ./kernel_flow.sh <kernel verilog file> <kernel module>

set -e
export SHELLOPTS

timestamp=$(date +"%y_%m_%d-%H%M%S")
log=kernel_${2}_${timestamp}.log

{
  ./opt_kernel.sh $1 $2
  ./route_if_kernels.sh $2
} 2>&1 | tee $log

echo "Summary of errors ($log):"
grep -n ERROR $log
echo "Timing summary:"
grep WNS $log | tail -n 1
