create database if not exists ${DB};
use ${DB};

drop table if exists partsupp;

create external table partsupp
(
    ps_partkey                int,
    ps_suppkey                int,
    ps_availqty               int,
    ps_supplycost             float,
    ps_comment                string 
)
row format delimited fields terminated by '|' 
location '${LOCATION}';
