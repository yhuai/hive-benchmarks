create database if not exists ${DB};
use ${DB};

drop table if exists reason;

create table reason
(
    r_reason_sk               int,
    r_reason_id               string,
    r_reason_desc             string
)
row format serde '${SERDE}'
stored as ${FILE} tblproperties ("orc.compress"="SNAPPY");

insert overwrite table reason select * from ${SOURCE}.reason;