create database if not exists ${DB};
use ${DB};

drop table if exists region;

create external table region
(
    r_regionkey               int,
    r_name                    string,
    r_comment                 string
)
row format delimited fields terminated by '|' 
location '${LOCATION}';
