create database if not exists ${DB};
use ${DB};

drop table if exists region;

create table region
(
    r_regionkey               int,
    r_name                    string,
    r_comment                 string
)
row format serde '${SERDE}'
stored as ${FILE} tblproperties ("orc.compress"="SNAPPY");

insert overwrite table region select * from ${SOURCE}.region;