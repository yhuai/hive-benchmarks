#!/bin/bash

usage() {
  echo "Load tables of a benchmark to hive"
  echo "Usage: `echo $0| awk -F/ '{print $NF}'` benchmark slave-hostfile"
  echo "Supported benchmarks: tpc-h tpc-ds ss-db"
  exit
}

tpc-ds() {
  local PARTS="$1"
  local HOST=$2
  for part in $PARTS; do
    echo "Generate part ${part}/${CHUNK_NUM} of tpcds on ${HOST} ..."
    $SSH $HOST eval "cd $DBGEN_DIR && $DBGEN_DIR/dsdgen -force Y -scale $SCALE -parallel $CHUNK_NUM -child $part"
    sleep 4;
    echo "Copy the part ${part} of dataset to hdfs from $HOST ..."
    for table in $TABLES; do
      $SSH $HOST eval "${HADOOP_HOME}/bin/hadoop dfs -copyFromLocal $DBGEN_DIR/${table}_${part}_${CHUNK_NUM}.dat ${EXTERNAL_DIR}/${SCALE}/${table}"
      $SSH $HOST eval "rm $DBGEN_DIR/${table}_${part}_${CHUNK_NUM}.dat"
    done
  done
}

tpc-h() {
  local PARTS="$1"
  local HOST=$2
  for part in $PARTS; do
    echo "Generate part ${part}/${CHUNK_NUM} of tpch on ${HOST} ..."
    $SSH $HOST eval "cd $DBGEN_DIR && $DBGEN_DIR/dbgen -f -s $SCALE -C $CHUNK_NUM -S $part"
    sleep 4;
    echo "Copy the part ${part} of dataset to hdfs from $HOST ..."
    for table in $TABLES; do
      # region and nation are not generated with -C
      if [[ "$table" != "region" && "$table" != "nation" ]]; then
        $SSH $HOST eval "${HADOOP_HOME}/bin/hadoop dfs -copyFromLocal $DBGEN_DIR/${table}.tbl.${part} ${EXTERNAL_DIR}/${SCALE}/${table}"
        $SSH $HOST eval "rm $DBGEN_DIR/${table}.tbl.${part}"
      fi
    done
  done
}

ss-db() {
  local PARTS="$1"
  local HOST=$2
  for part in $PARTS; do
    echo "Generate part $((${part}+1))/${CHUNK_NUM} of ss-db on ${HOST} ..."
    $SSH $HOST eval "cd $DBGEN_DIR && $DBGEN_DIR/benchGen -f bench_${part} -t -c $SCALE -n $CHUNK_NUM -i $part ./"
    sleep 4;
    echo "Copy the part ${part} of dataset to ss-db from $HOST ..."
    for table in $TABLES; do
      $SSH $HOST eval "ls $DBGEN_DIR| grep bench_${part}_ | xargs -I % ${HADOOP_HOME}/bin/hadoop dfs -copyFromLocal ${DBGEN_DIR}/% ${EXTERNAL_DIR}/${SCALE}/${table}"
      $SSH $HOST eval "ls $DBGEN_DIR| grep bench_${part} | xargs -I % rm $DBGEN_DIR/%"
    done
  done
}

if [ $# -ne 2 ]
then
  usage
fi

if [ "$BENCH_HOME" == "" ]; then
  echo "\$BENCH_HOME is not set: please set \$BENCH_HOME to $( cd "$( dirname "${BASH_SOURCE[0]}" )/../" && pwd )";
  exit 4;
fi

BENCHMARK=$1
HOSTLIST="$(cat $2)"
HOST_NUM=$(echo $HOSTLIST| wc -w);
BENCHMARK_DIR=$BENCH_HOME/$BENCHMARK

source $BENCH_HOME/conf/benchmarks-env.sh
source $BENCHMARK_DIR/conf/env.sh
DBGEN_DIR=$BENCHMARK_DIR/$DBGEN_TOOL_DIR

for table in $TABLES; do
  hadoop dfs -mkdir ${EXTERNAL_DIR}/${SCALE}/${table}
done

HINDEX=1;
PART_NUM=$CHUNK_NUM
if [ "$BENCHMARK" == "ss-db" ]; then
  PART_NUM=$(($IMAGES_PER_CYCLE-1))
  HINDEX=0;
fi

if [ "$BENCHMARK" == "tpc-h" ]; then
  # Have to generate tables of nation and region first
  cd $DBGEN_DIR && $DBGEN_DIR/dbgen -f -s $SCALE -T l
  $HADOOP_HOME/bin/hadoop dfs -copyFromLocal $DBGEN_DIR/nation.tbl ${EXTERNAL_DIR}/${SCALE}/nation
  $HADOOP_HOME/bin/hadoop dfs -copyFromLocal $DBGEN_DIR/region.tbl ${EXTERNAL_DIR}/${SCALE}/region
  rm $DBGEN_DIR/nation.tbl
  rm $DBGEN_DIR/region.tbl
fi

for host in $HOSTLIST; do
  parts="$(seq $HINDEX $HOST_NUM $PART_NUM)"
  if [ "$parts" != "" ]; then
    $BENCHMARK "$parts" $host &
  fi
  HINDEX=$(($HINDEX + 1))
done

wait