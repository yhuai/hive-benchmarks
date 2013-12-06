#!/bin/bash

usage() {
  echo "Mount all disks in all nodes"
  echo "Usage: `echo $0| awk -F/ '{print $NF}'` benchmark node-file"
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

#sudo umount /dev/xvdb
#sudo umount /dev/xvdc
#sudo umount /dev/xvdd
#sudo umount /dev/xvde
#sudo mount -o noatime -o data=writeback /dev/xvdb /mnt/mnt0
#sudo mount -o noatime -o data=writeback /dev/xvdc /mnt/mnt1
#sudo mount -o noatime -o data=writeback /dev/xvdd /mnt/mnt2
#sudo mount -o noatime -o data=writeback /dev/xvde /mnt/mnt3
#sudo chmod 777 -R /mnt/mnt0
#sudo chmod 777 -R /mnt/mnt1
#sudo chmod 777 -R /mnt/mnt2
#sudo chmod 777 -R /mnt/mnt3
#rm -rf /mnt/mnt0/hadoop
#rm -rf /mnt/mnt1/hadoop
#rm -rf /mnt/mnt2/hadoop
#rm -rf /mnt/mnt3/hadoop
#mkdir /mnt/mnt0/hadoop
#mkdir /mnt/mnt1/hadoop
#mkdir /mnt/mnt2/hadoop
#mkdir /mnt/mnt3/hadoop

mount() {
  local HOST=$1
	echo "Mount disks and create hadoop dirs in $HOST"
	
	$SSH $HOST eval "sudo umount /dev/xvdb"
  $SSH $HOST eval "sudo umount /dev/xvdc"
  $SSH $HOST eval "sudo umount /dev/xvdd"
  $SSH $HOST eval "sudo umount /dev/xvde"
  
  $SSH $HOST eval "sudo mount -o noatime -o data=writeback /dev/xvdb /mnt/mnt0"
  $SSH $HOST eval "sudo mount -o noatime -o data=writeback /dev/xvdc /mnt/mnt1"
  $SSH $HOST eval "sudo mount -o noatime -o data=writeback /dev/xvdd /mnt/mnt2"
  $SSH $HOST eval "sudo mount -o noatime -o data=writeback /dev/xvde /mnt/mnt3"
  
  $SSH $HOST eval "sudo chmod 777 -R /mnt/mnt0"
  $SSH $HOST eval "sudo chmod 777 -R /mnt/mnt1"
  $SSH $HOST eval "sudo chmod 777 -R /mnt/mnt2"
  $SSH $HOST eval "sudo chmod 777 -R /mnt/mnt3"
  
  $SSH $HOST eval "rm -rf /mnt/mnt0/hadoop"
  $SSH $HOST eval "rm -rf /mnt/mnt1/hadoop"
  $SSH $HOST eval "rm -rf /mnt/mnt2/hadoop"
  $SSH $HOST eval "rm -rf /mnt/mnt3/hadoop"
  
  $SSH $HOST eval "mkdir /mnt/mnt0/hadoop"
  $SSH $HOST eval "mkdir /mnt/mnt1/hadoop"
  $SSH $HOST eval "mkdir /mnt/mnt2/hadoop"
  $SSH $HOST eval "mkdir /mnt/mnt3/hadoop"
}

for HOST in $HOSTLIST; do
	mount $HOST &
done

wait