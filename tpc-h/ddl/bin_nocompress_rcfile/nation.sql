create database if not exists ${DB};
use ${DB};

drop table if exists nation;

create table nation
row format serde '${SERDE}'
stored as ${FILE}
as select * from ${SOURCE}.nation;
