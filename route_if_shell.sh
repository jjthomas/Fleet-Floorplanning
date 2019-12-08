#!/bin/bash

source job_submit.sh

java -Xmx2G edu.stanford.fleet.rw.ConnectIFShell

echo "Waiting for if_shell..."
submit_job "vivado -mode batch -source route_if_shell.tcl &> if_shell.log"
wait_for_job $job_id
cat if_shell.log
rm if_shell.log
./verify_clear_int_tiles.sh if_shell_routed.dcp
