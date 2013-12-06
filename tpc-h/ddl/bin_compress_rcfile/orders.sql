create database if not exists ${DB};
use ${DB};

drop table if exists orders;

create table orders
row format serde '${SERDE}'
stored as ${FILE}
as select * from ${SOURCE}.orders;