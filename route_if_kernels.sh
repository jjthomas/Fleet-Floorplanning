#!/bin/bash

source job_submit.sh

java -Xmx2G edu.stanford.fleet.rw.ConnectIFKernel $1

num_cols=$(java -Xmx2G edu.stanford.fleet.rw.FloorplanUtils)
job_ids=()
for i in $(seq 0 $(($num_cols - 1))); do
  job_ids+=($(submit_job "vivado -mode batch -source route_if_kernel.tcl -tclargs $1 $i &> if_${1}${i}.log"))
done

for i in $(seq 0 $(($num_cols - 1))); do
  echo "Waiting for if_${1}${i}..."
  wait_for_job ${job_ids[$i]}
  cat if_${1}${i}.log
  rm if_${1}${i}.log
  ./filter_clock_pips.sh $1 $i
done
