#!/bin/bash

source job_submit.sh

echo "Waiting for opt_kernel..."
wait_for_job $(submit_job "vivado -log opt_$2.log -mode batch -source opt_kernel.tcl -tclargs $1 $2")
