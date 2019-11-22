#!/bin/bash

/tools/batonroot/rodin/devkits/lnx64/jdk1.8.0_144/bin/java -Xmx30G com.xilinx.rapidwright.examples.CreateFFShellKernelIF

num_cols=$(/tools/batonroot/rodin/devkits/lnx64/jdk1.8.0_144/bin/java -Xmx30G com.xilinx.rapidwright.examples.FloorplanUtils)
job_ids=()
for i in $(seq 0 $(($num_cols - 1))); do
  log=shell_kernel_if${i}.log
  output=$(bsub -R 'select[type=X86_64]' -N -q medium -R 'rusage[mem=50000]' -o $log -e $log vivado -mode batch -source route_shell_kernel_if.tcl -tclargs $i)
  job_ids+=($(echo $output | head -n1 | cut -d'<' -f2 | cut -d'>' -f1))
done

for i in $(seq 0 $(($num_cols - 1))); do
  echo "Waiting for shell_kernel_if${i}..."
  bwait -w "done(${job_ids[$i]})"
done
