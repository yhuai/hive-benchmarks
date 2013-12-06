#!/bin/bash

usage() {
  echo "Download and compile a specific benchmark"
  echo "Usage: `echo $0| awk -F/ '{print $NF}'` benchmark os"
  echo "Supported benchmarks: tpc-h tpc-ds ss-db"
  echo "Supported operating systems: osx linux"
  exit
}

if [ $# -ne 2 ]
then
  usage
fi

if [ "$BENCH_HOME" == "" ]; then
  echo "\$BENCH_HOME is not set: please set \$BENCH_HOME to $( cd "$( dirname "${BASH_SOURCE[0]}" )/../" && pwd )";
  exit 4;
fi

source $BENCH_HOME/conf/benchmarks-env.sh

BENCHMARK=$1
OS=$2
BENCHMARK_DIR=$BENCH_HOME/$BENCHMARK
BENCHMARK_CONF_DIR=$BENCHMARK_DIR/conf

source $BENCHMARK_CONF_DIR/env.sh
DBGEN_TOOL_DIR=$BENCHMARK_DIR/$DBGEN_TOOL_DIR
if [[ ! -e $DBGEN_TOOL_DIR ]]; then
    echo "Download $BENCHMARK dbgen tool"
    cd $BENCHMARK_DIR
    git clone $REPO_URL
    cd $BENCH_HOME
fi

echo "Compile $BENCHMARK dbgen tool for $OS"
cd $BENCHMARK_DIR
./compile.sh $OS
