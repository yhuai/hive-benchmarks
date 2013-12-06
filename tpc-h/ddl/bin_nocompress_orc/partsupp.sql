create database if not exists ${DB};
use ${DB};

drop table if exists partsupp;

create table partsupp
(
    ps_partkey                int,
    ps_suppkey                int,
    ps_availqty               int,
    ps_supplycost             float,
    ps_comment                string 
)
row format serde '${SERDE}'
stored as ${FILE} tblproperties ("orc.compress"="NONE");

insert overwrite table partsupp select * from ${SOURCE}.partsupp;