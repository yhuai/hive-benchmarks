create database if not exists ${DB};
use ${DB};

drop table if exists ship_mode;

create table ship_mode
(
    sm_ship_mode_sk           int,
    sm_ship_mode_id           string,
    sm_type                   string,
    sm_code                   string,
    sm_carrier                string,
    sm_contract               string
)
row format serde '${SERDE}'
stored as ${FILE} tblproperties ("orc.compress"="SNAPPY");

insert overwrite table ship_mode select * from ${SOURCE}.ship_mode;