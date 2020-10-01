#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd    )"

function show_help() {
  echo "lol no"
}

nworkers=0

do_sched=0
while getopts "hw:s" opt; do
  case "$opt" in
    h|\?)
      show_help
      exit 0
      ;;
    w)
      nworkers=$OPTARG
      ;;
    s)
      do_sched=1
      ;;
  esac
done

if [[ $nworkers == 0 ]]; then
  echo "NO worker count given"
  exit 1
fi



echo "Will launch $nworkers workers"

sched_file=$DIR/scheduler.txt

if [[ $do_sched == "1" ]]; then 
  rm -f $sched_file
  condor_submit $DIR/dask-scheduler.htc
  echo "Waiting for scheduler to launch"

  while [ ! -f $sched_file ]; do 
    sleep 1
  done
fi

echo "Scheduler running on host $(cat $sched_file)"

condor_submit $DIR/dask-worker.htc -queue $nworkers
