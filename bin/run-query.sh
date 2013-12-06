#!/bin/bash

set -e

usage() {
  echo "Run a query with a given setting file and a result dir. A query will be executed 5 times."
  echo "Usage: `echo $0| awk -F/ '{print $NF}'` setting-file query-file result-dir DB [slave-hostfile] "
  echo "If a slave-hostfile is provided, we will also drop all caches from those slaves."
  exit
}

if [[ $# -ne 4 && $# -ne 5 ]]
then
  usage
fi

source $BENCH_HOME/conf/benchmarks-env.sh

SETTING=$1
QUERY=$2
RESULT_DIR=$3
DB=$4
HOSTFILE=""
if [[ $# -eq 5 ]]
then
  	HOSTFILE=$5
fi
SETTING_NAME=$(basename $SETTING)
SETTING_NAME=${SETTING_NAME%.*}
QUERY_NAME=$(basename $QUERY)
QUERY_NAME=${QUERY_NAME%.*}

for i in 0 1 2 3 4
do
	if [ $HOSTFILE != "" ]
	then
	  echo "Drop all caches from all nodes list in ${HOSTFILE}"
  	$BENCH_HOME/bin/drop-cache-all.sh $HOSTFILE
	fi
	hive -i ${SETTING} -f ${QUERY} -d DB=${DB} > ${RESULT_DIR}/${QUERY_NAME}.${SETTING_NAME}.${DB}.${i}.txt 2>&1
done