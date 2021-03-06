#!/bin/bash

source job_submit.sh

echo "Waiting for opt_kernel..."
submit_job "vivado -mode batch -source opt_kernel.tcl -tclargs $1 $2 &> opt_${2}.log"
wait_for_job $job_id
cat opt_${2}.log
rm opt_${2}.log
