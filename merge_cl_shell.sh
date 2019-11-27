#!/bin/bash

source job_submit.sh

echo "Waiting for merge_cl_shell..."
wait_for_job $(submit_job "vivado -log merge_cl_shell.log -mode batch -source merge_cl_shell.tcl")
