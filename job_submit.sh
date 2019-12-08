submit_job() {
  output=$(bsub -R 'select[type=X86_64]' -N -q medium -R 'rusage[mem=50000]' $1)
  job_id=$(echo $output | head -n1 | cut -d'<' -f2 | cut -d'>' -f1)
}

wait_for_job() {
  bwait -w "done($1)"
}
