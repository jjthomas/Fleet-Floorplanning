submit_job() {
  eval $1 &
  job_id=$!
}

wait_for_job() {
  wait $1
}
