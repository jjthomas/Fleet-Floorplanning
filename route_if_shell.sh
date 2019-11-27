#!/bin/bash

source job_submit.sh

java -Xmx2G edu.stanford.fleet.rw.ConnectIFShell

echo "Waiting for if_shell..."
wait_for_job $(submit_job "vivado -log if_shell.log -mode batch -source route_if_shell.tcl")
./verify_clear_int_tiles.sh if_shell_routed.dcp
