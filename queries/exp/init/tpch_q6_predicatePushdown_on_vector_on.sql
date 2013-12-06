set mapred.job.map.memory.mb=2048;
set mapred.job.reduce.memory.mb=2048;
set mapred.map.child.java.opts=-server -Xmx3072m -Djava.net.preferIPv4Stack=true;
set mapred.reduce.child.java.opts=-server -Xmx3072m -Djava.net.preferIPv4Stack=true;

set mapred.reduce.tasks=1;

set hive.stats.autogather=false;
set hive.exec.parallel=false;
set hive.enforce.bucketing=true;
set hive.enforce.sorting=true;
set hive.map.aggr=true;
set hive.optimize.bucketmapjoin=true;
set hive.optimize.bucketmapjoin.sortedmerge=true;
set hive.mapred.reduce.tasks.speculative.execution=false;
set hive.auto.convert.join=true;
set hive.auto.convert.sortmerge.join=true;
set hive.auto.convert.sortmerge.join.noconditionaltask=true;
set hive.auto.convert.join.noconditionaltask=true;
set hive.auto.convert.join.noconditionaltask.size=100000000;
set hive.optimize.reducededuplication.min.reducer=1;
set hive.input.format=org.apache.hadoop.hive.ql.io.HiveInputFormat;

set hive.optimize.index.filter=true;
set hive.vectorized.execution.enabled=true;