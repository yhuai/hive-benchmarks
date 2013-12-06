create database if not exists ${DB};
use ${DB};

drop table if exists cycle;

create table cycle
row format serde '${SERDE}'
stored as ${FILE}
as select * from ${SOURCE}.cycle;