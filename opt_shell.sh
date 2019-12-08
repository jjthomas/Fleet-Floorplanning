#!/bin/bash

source job_submit.sh

echo "Waiting for opt_shell..."
submit_job "vivado -mode batch -source opt_shell.tcl -tclargs $1 $2 &> opt_shell.log"
wait_for_job $job_id
cat opt_shell.log
rm opt_shell.log
