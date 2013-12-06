create database if not exists ${DB};
use ${DB};

drop table if exists customer;

create external table customer
(
    c_custkey                 int,
    c_name                    string,
    c_address                 string,
    c_nationkey               int,
    c_phone                   string,
    c_acctbal                 float,
    c_mktsegment              string,
    c_comment                 string
)
row format delimited fields terminated by '|' 
location '${LOCATION}';
