create database if not exists ${DB};
use ${DB};

drop table if exists nation;

create external table nation
(
    n_nationkey               int,
    n_name                    string,
    n_regionkey               int,
    n_comment                 string
)
row format delimited fields terminated by '|' 
location '${LOCATION}';
