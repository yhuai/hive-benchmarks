# hive-benchmarks

some benchmarking queries for Apache Hive

## Setup
This repo was prepared for benchmarks of SS-DB, TPC-H and TPC-DS running in the following environment.

* Hadoop version: Hadoop 1.2.1
* Hive version: Hive 0.13-SNAPSHOT (Nov. 28, 2013)
* Cluster setup:
	* A 11-node (1 master + 10 slaves) EC2 cluster in `us-east-1d`
	* Instance type: m1.xlarge
	* OS Image: `ami-a73264ce` (Ubuntu Server 12.04.3 LTS 64-bit)
	* OS kernel image version: the result of `cat /proc/version` is `Linux version 3.2.0-56-virtual (buildd@roseapple) (gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #86-Ubuntu SMP Wed Oct 23 09:43:22 UTC 2013`.

## Notes
### Data types
Right now, `int` is used for the type of `identifier`. If the scale factor is very large, `bitint` is needed.

Because we may need to to compare the current version of Hive with a older version (e.g. 0.10.0) of it,
we have to use data types supported by the older version to create columns. Here are mappings:

* decimal    -> float
* char       -> string
* vacahr     -> string
* date       -> string
