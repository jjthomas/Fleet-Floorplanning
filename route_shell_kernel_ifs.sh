#!/bin/bash

source job_submit.sh

java -Xmx2G edu.stanford.fleet.rw.CreateFFShellKernelIF

num_cols=$(java -Xmx2G edu.stanford.fleet.rw.FloorplanUtils)
job_ids=()
for i in $(seq 0 $(($num_cols - 1))); do
  job_ids+=($(submit_job "vivado -mode batch -source route_shell_kernel_if.tcl -tclargs $i &> shell_kernel_if${i}.log"))
done

for i in $(seq 0 $(($num_cols - 1))); do
  echo "Waiting for shell_kernel_if${i}..."
  wait_for_job ${job_ids[$i]}
  cat shell_kernel_if${i}.log
  rm shell_kernel_if${i}.log
done
