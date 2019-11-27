#!/bin/bash

source job_submit.sh

echo "Waiting for opt_shell..."
wait_for_job $(submit_job "vivado -log opt_shell.log -mode batch -source opt_shell.tcl -tclargs $1 $2")
