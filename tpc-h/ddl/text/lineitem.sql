create database if not exists ${DB};
use ${DB};

drop table if exists lineitem;

create external table lineitem
(
    l_orderkey                int,
    l_partkey                 int,
    l_suppkey                 int,
    l_linenumber              int,
    l_quantity                float,
    l_extendedprice           float,
    l_discount                float,
    l_tax                     float,
    l_returnflag              string,
    l_linestatus              string,
    l_shipdate                string,
    l_commitdate              string,
    l_receiptdate             string,
    l_shipinstruct            string,
    l_shipmode                string,
    l_comment                 string
)
row format delimited fields terminated by '|' 
location '${LOCATION}';
