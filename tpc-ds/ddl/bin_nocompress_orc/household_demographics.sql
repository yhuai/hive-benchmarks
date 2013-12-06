create database if not exists ${DB};
use ${DB};

drop table if exists household_demographics;

create table household_demographics
(
    hd_demo_sk                int,
    hd_income_band_sk         int,
    hd_buy_potential          string,
    hd_dep_count              int,
    hd_vehicle_count          int
)
row format serde '${SERDE}'
stored as ${FILE} tblproperties ("orc.compress"="NONE");

insert overwrite table household_demographics select * from ${SOURCE}.household_demographics;
