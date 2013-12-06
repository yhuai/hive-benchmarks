create database if not exists ${DB};
use ${DB};

drop table if exists customer;

create table customer
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
row format serde '${SERDE}'
stored as ${FILE} tblproperties ("orc.compress"="SNAPPY");

insert overwrite table customer select * from ${SOURCE}.customer;