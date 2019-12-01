#!/bin/bash

source job_submit.sh

echo "Waiting for merge_cl_shell..."
wait_for_job $(submit_job "vivado -mode batch -source merge_cl_shell.tcl -tclargs $1 &> merge_cl_shell.log")
cat merge_cl_shell.log
rm merge_cl_shell.log
