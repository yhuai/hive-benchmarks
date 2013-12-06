#!/bin/bash

usage() {
  echo "For every node provided in the hostfile, this script frees all cached objects, and then frees OS page cache, dentries and inodes."
  echo "Usage: `echo $0| awk -F/ '{print $NF}'` hostfile"
  echo "Note: this script should be used when you do not need to provide a sudo password."
  exit
}

if [[ $# -ne 1 ]]
then
  usage
fi

if [ "$BENCH_HOME" == "" ]; then
  echo "\$BENCH_HOME is not set: please set \$BENCH_HOME to $( cd "$( dirname "${BASH_SOURCE[0]}" )/../" && pwd )";
  exit 4;
fi

source $BENCH_HOME/conf/benchmarks-env.sh
HOSTLIST="$(cat $1)"

for HOST in $HOSTLIST; do
  ssh -t -t $HOST 'echo "free && sync && echo 3 > /proc/sys/vm/drop_caches && free"|sudo su' &
done

wait
