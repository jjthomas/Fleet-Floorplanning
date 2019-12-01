#!/bin/bash

source job_submit.sh

echo "Waiting for opt_${2}..."
wait_for_job $(submit_job "vivado -mode batch -source opt_kernel.tcl -tclargs $1 $2")
