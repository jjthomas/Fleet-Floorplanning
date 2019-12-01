submit_job() {
  eval $1 &
  echo $!
}

wait_for_job() {
  wait $1
}
