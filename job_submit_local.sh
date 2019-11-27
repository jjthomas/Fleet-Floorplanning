submit_job() {
  $1 &
  echo $!
}

wait_for_job() {
  wait $1
}
