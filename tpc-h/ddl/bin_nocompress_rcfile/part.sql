create database if not exists ${DB};
use ${DB};

drop table if exists part;

create table part
row format serde '${SERDE}'
stored as ${FILE}
as select * from ${SOURCE}.part;
