create database if not exists ${DB};
use ${DB};

drop table if exists nation;

create table nation
(
    n_nationkey               int,
    n_name                    string,
    n_regionkey               int,
    n_comment                 string
)
row format serde '${SERDE}'
stored as ${FILE} tblproperties ("orc.compress"="SNAPPY");

insert overwrite table nation select * from ${SOURCE}.nation;
