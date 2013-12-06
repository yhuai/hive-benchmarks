#!/bin/bash
set -x

set -e

usage() {
  echo "Load tables of a benchmark to hive"
  echo "Usage: `echo $0| awk -F/ '{print $NF}'` benchmark slave-hostfile"
  echo "Supported benchmarks: tpc-h tpc-ds ss-db"
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

TEXT_STORAGE_FORMAT="text"
BIN_STORAGE_FORMATS="bin_nocompress_rcfile bin_compress_rcfile bin_nocompress_orc bin_compress_orc"

BENCHMARK=$1
HOSTFILE=$2
BENCHMARK_DIR=$BENCH_HOME/$BENCHMARK
BENCHMARK_DDL_DIR=$BENCHMARK_DIR/ddl

source $BENCH_HOME/conf/benchmarks-env.sh
source $BENCHMARK_DIR/conf/env.sh
echo "Start to load tables in $BENCHMARK into Hive ..."
echo "Tables: $TABLES"
echo "Scale factor: $SCALE"

echo "Start to load tables with the format of ${TEXT_STORAGE_FORMAT} ..."
INIT_FILE="${BENCH_HOME}/init/load_${TEXT_STORAGE_FORMAT}.sql"
source ${BENCHMARK_DDL_DIR}/conf/${TEXT_STORAGE_FORMAT}.sh
DB="${DB_PREFIX}_${SCALE}"
for t in ${TABLES}
do
  hive -i ${INIT_FILE} -f ${BENCHMARK_DDL_DIR}/${TEXT_STORAGE_FORMAT}/${t}.sql -d DB=${DB} -d LOCATION=${EXTERNAL_DIR}/${SCALE}/${t}
done
echo "Total size of ${DB}."
hadoop fs -lsr ${EXTERNAL_DIR}/${SCALE}/ | awk '{print $5}' | paste -sd+ | bc

for f in ${BIN_STORAGE_FORMATS}
do
	echo "Drop all OS caches in all nodes ..."
	$BENCH_HOME/bin/drop-cache-all.sh $HOSTFILE
  INIT_FILE="${BENCH_HOME}/init/load_${f}.sql"
  source ${BENCHMARK_DDL_DIR}/conf/${f}.sh
  DB="${DB_PREFIX}_${SCALE}_${HIVE_VERSION}"
  SOURCE="${SOURCE_PREFIX}_${SCALE}"
  echo "Start to load tables with the format of ${f} into ${DB} from ${SOURCE}..."
  for t in ${TABLES}
  do
    hive -i ${INIT_FILE} -f ${BENCHMARK_DDL_DIR}/${f}/${t}.sql -d DB=${DB} -d SOURCE=${SOURCE} -d FILE=${FILE} -d SERDE=${SERDE}
  done
  echo "Total size of ${DB}."
  hadoop fs -lsr /user/hive/warehouse/${DB}.db/ | awk '{print $5}' | paste -sd+ | bc
done
