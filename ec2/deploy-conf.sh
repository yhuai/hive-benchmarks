#!/bin/bash

usage() {
  echo "Copy hadoop conf files (from source-hadoop-conf-dir) and hive conf files (from source-hive-conf-dir) to all nodes (all slaves nodes and this node)."
  echo "Usage: `echo $0| awk -F/ '{print $NF}'` slave-hostfile source-hadoop-conf-dir source-hive-conf-dir username [optional private key]"
  exit
}

if [[ $# -ne 4 && $# -ne 5 ]]
then
  usage
fi

if [ "$BENCH_HOME" == "" ]; then
  echo "\$BENCH_HOME is not set: please set \$BENCH_HOME to $( cd "$( dirname "${BASH_SOURCE[0]}" )/../" && pwd )";
  exit 4;
fi

source $BENCH_HOME/conf/benchmarks-env.sh
HOSTLIST="$(cat $1)"
SOURCE_HADOOP_CONF_DIR=$2
SOURCE_HIVE_CONF_DIR=$3
USERNAME=$4

SCP="scp"
if [[ $# -eq 5 ]]
then
  SCP="$SCP -i $5"
fi

copy() {
  local HOST=$1
  $SCP ${SOURCE_HADOOP_CONF_DIR}/hadoop-env.sh $USERNAME@$HOST:"/home/ubuntu/hadoop-1.2.1/conf/"
  $SCP ${SOURCE_HADOOP_CONF_DIR}/core-site.xml $USERNAME@$HOST:"/home/ubuntu/hadoop-1.2.1/conf/"
  $SCP ${SOURCE_HADOOP_CONF_DIR}/hdfs-site.xml $USERNAME@$HOST:"/home/ubuntu/hadoop-1.2.1/conf/"
  $SCP ${SOURCE_HADOOP_CONF_DIR}/mapred-site.xml $USERNAME@$HOST:"/home/ubuntu/hadoop-1.2.1/conf/"
  $SCP ${SOURCE_HADOOP_CONF_DIR}/slaves $USERNAME@$HOST:"/home/ubuntu/hadoop-1.2.1/conf/"
  $SCP ${SOURCE_HIVE_CONF_DIR}/hive-site.xml $USERNAME@$HOST:"/home/ubuntu/apache-hive-0.13.0-SNAPSHOT-bin/conf/"
  
  $SCP ${SOURCE_HADOOP_CONF_DIR}/hadoop-env.sh $USERNAME@$HOST:"/mnt/mnt0/hive-benchmarks/ec2/hadoop-conf/"
  $SCP ${SOURCE_HADOOP_CONF_DIR}/core-site.xml $USERNAME@$HOST:"/mnt/mnt0/hive-benchmarks/ec2/hadoop-conf/"
  $SCP ${SOURCE_HADOOP_CONF_DIR}/hdfs-site.xml $USERNAME@$HOST:"/mnt/mnt0/hive-benchmarks/ec2/hadoop-conf/"
  $SCP ${SOURCE_HADOOP_CONF_DIR}/mapred-site.xml $USERNAME@$HOST:"/mnt/mnt0/hive-benchmarks/ec2/hadoop-conf/"
  $SCP ${SOURCE_HADOOP_CONF_DIR}/slaves $USERNAME@$HOST:"/mnt/mnt0/hive-benchmarks/ec2/hadoop-conf/"
  $SCP ${SOURCE_HIVE_CONF_DIR}/hive-site.xml $USERNAME@$HOST:"/mnt/mnt0/hive-benchmarks/ec2/hive-conf/"
}

for HOST in $HOSTLIST; do
  copy $HOST &
done

wait