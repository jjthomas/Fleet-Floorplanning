#!/bin/bash

/tools/batonroot/rodin/devkits/lnx64/jdk1.8.0_144/bin/java -Xmx30G com.xilinx.rapidwright.examples.ConnectIFShell

output=$(bsub -R 'select[type=X86_64]' -N -q medium -R 'rusage[mem=50000]' -o if_shell.log -e if_shell.log vivado -mode batch -source route_if_shell.tcl)
job_id=$(echo $output | head -n1 | cut -d'<' -f2 | cut -d'>' -f1)
echo "Waiting for if_shell..."
bwait -w "done($job_id)"
./verify_clear_int_tiles.sh if_shell_routed.dcp
