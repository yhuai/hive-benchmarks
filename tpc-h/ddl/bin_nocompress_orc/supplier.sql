create database if not exists ${DB};
use ${DB};

drop table if exists supplier;

create table supplier
(
    s_suppkey                 int,
    s_name                    string,
    s_address                 string,
    s_nationkey               int,
    s_phone                   string,
    s_acctbal                 float,
    s_comment                 string
)
row format serde '${SERDE}'
stored as ${FILE} tblproperties ("orc.compress"="NONE");

insert overwrite table supplier select * from ${SOURCE}.supplier;