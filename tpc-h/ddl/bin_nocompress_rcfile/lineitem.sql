create database if not exists ${DB};
use ${DB};

drop table if exists lineitem;

create table lineitem
row format serde '${SERDE}'
stored as ${FILE}
as select * from ${SOURCE}.lineitem;