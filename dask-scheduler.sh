#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd    )"
cd $_CONDOR_SCRATCH_DIR
source $DIR/venv/bin/activate

sched_file=$DIR/scheduler.txt
hostname > $sched_file

function cleanup {
  rm $sched_file
}

trap cleanup EXIT

log=$DIR/scheduler.log
dask-scheduler > $log 2>&1
