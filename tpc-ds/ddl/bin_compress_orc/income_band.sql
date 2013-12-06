create database if not exists ${DB};
use ${DB};

drop table if exists income_band;

create table income_band
(
    ib_income_band_sk         int,
    ib_lower_bound            int,
    ib_upper_bound            int   
)
row format serde '${SERDE}'
stored as ${FILE} tblproperties ("orc.compress"="SNAPPY");

insert overwrite table income_band select * from ${SOURCE}.income_band;
