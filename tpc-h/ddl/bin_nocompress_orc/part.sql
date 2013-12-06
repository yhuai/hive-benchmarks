create database if not exists ${DB};
use ${DB};

drop table if exists part;

create table part
(
    p_partkey                 int,
    p_name                    string,
    p_mfgr                    string,
    p_brand                   string,
    p_type                    string,
    p_size                    int,
    p_container               string,
    p_retailprice             float,
    p_comment                 string
)
row format serde '${SERDE}'
stored as ${FILE} tblproperties ("orc.compress"="NONE");

insert overwrite table part select * from ${SOURCE}.part;
