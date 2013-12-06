create database if not exists ${DB};
use ${DB};

drop table if exists orders;

create external table orders
(
    o_orderkey                int,
    o_custkey                 int,
    o_orderstatus             string,
    o_totalprice              float,
    o_orderdate               string,
    o_orderpriority           string,
    o_clerk                   string,
    o_shippriority            int,
    o_comment                 string
)
row format delimited fields terminated by '|' 
location '${LOCATION}';
