#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd    )"
source $DIR/venv/bin/activate
scheduler=$(cat $DIR/scheduler.txt)
dask-worker $scheduler:8786 \
	--local-directory $_CONDOR_SCRATCH_DIR \
	--nprocs 1 \
	--nthreads 1 \
	--memory-limit 1.9e9
