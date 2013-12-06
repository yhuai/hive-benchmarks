#!/bin/bash

usage() {
  echo "Download this repo to all nodes and compile all benchmarks in all nodes."
  echo "Usage: `echo $0| awk -F/ '{print $NF}'` slave-node-file os bash-profile [username] [password]"
  echo "Supported benchmarks: tpc-h tpc-ds ss-db"
  echo "Supported operating systems: osx linux"
  echo "If this repo is private, you also need to provide username and password."
  exit
}

if [[ $# -ne 3 && $# -ne 5 ]]
then
  usage
fi

if [ "$BENCH_HOME" == "" ]; then
  echo "\$BENCH_HOME is not set: please set \$BENCH_HOME to $( cd "$( dirname "${BASH_SOURCE[0]}" )/../" && pwd )";
  exit 4;
fi

source $BENCH_HOME/conf/benchmarks-env.sh
HOSTLIST="$(cat $1)"
OS=$2
BASH_PROFILE=$3

AUTH=""
if [[ $# -eq 5 ]]
then
  AUTH="$4:$5@"
fi

prepare() {
  local HOST=$1
  $SSH $HOST eval "rm -rf $BENCH_HOME"
  $SSH $HOST eval "git clone https://${AUTH}${REPO_URL} $BENCH_HOME"
  $SSH $HOST eval "source $BASH_PROFILE && $BENCH_HOME/bin/prepare.sh tpc-h ${OS}"
  $SSH $HOST eval "source $BASH_PROFILE && $BENCH_HOME/bin/prepare.sh tpc-ds ${OS}"
  $SSH $HOST eval "source $BASH_PROFILE && $BENCH_HOME/bin/prepare.sh ss-db ${OS}"
}

for HOST in $HOSTLIST; do
  prepare $HOST &
done

wait