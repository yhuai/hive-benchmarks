create database if not exists ${DB};
use ${DB};

drop table if exists region;

create table region
row format serde '${SERDE}'
stored as ${FILE}
as select * from ${SOURCE}.region;