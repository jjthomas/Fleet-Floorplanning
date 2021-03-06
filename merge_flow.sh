#!/bin/bash

# ./merge_flow.sh <kernel module>

timestamp=$(date +"%y_%m_%d-%H%M%S")
log=merge_${1}_${timestamp}.log

{
  ./merge_shell_kernel.sh $1
  ./merge_cl_shell.sh $1
} 2>&1 | tee $log

echo; echo "Summary of Exceptions ($log):"
grep -n "[^ ]Exception" $log
echo; echo "Summary of errors ($log):"
grep -n ERROR $log
echo; echo "Routing status:"
grep "nets with routing errors" $log
echo; echo "Timing issues:"
grep "Slack (VIOLATED)" $log
