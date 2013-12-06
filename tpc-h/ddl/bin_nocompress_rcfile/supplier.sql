create database if not exists ${DB};
use ${DB};

drop table if exists supplier;

create table supplier
row format serde '${SERDE}'
stored as ${FILE}
as select * from ${SOURCE}.supplier;