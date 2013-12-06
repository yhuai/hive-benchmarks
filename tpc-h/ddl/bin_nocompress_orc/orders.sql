create database if not exists ${DB};
use ${DB};

drop table if exists orders;

create table orders
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
row format serde '${SERDE}'
stored as ${FILE} tblproperties ("orc.compress"="NONE");

insert overwrite table orders select * from ${SOURCE}.orders;