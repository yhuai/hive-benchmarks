set hive.enforce.bucketing=true;
set hive.enforce.sorting=true;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.max.dynamic.partitions.pernode=1000000;
set hive.exec.max.dynamic.partitions=1000000;
set hive.exec.max.created.files=1000000;
set hive.exec.parallel=false;
set hive.stats.autogather=false;

set mapred.min.split.size=536870912;
set mapred.max.split.size=536870912;
set mapred.min.split.size.per.node=536870912;
set mapred.min.split.size.per.rack=536870912;
set mapred.job.map.memory.mb=2048;
set mapred.job.reduce.memory.mb=2048;
set mapred.map.child.java.opts=-server -Xmx3072m -Djava.net.preferIPv4Stack=true;
set mapred.reduce.child.java.opts=-server -Xmx3072m -Djava.net.preferIPv4Stack=true;