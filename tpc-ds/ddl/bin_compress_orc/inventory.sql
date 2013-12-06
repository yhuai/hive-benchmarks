create database if not exists ${DB};
use ${DB};

drop table if exists inventory;

create table inventory
(
    inv_date_sk			int,
    inv_item_sk			int,
    inv_warehouse_sk		int,
    inv_quantity_on_hand	int
)
row format serde '${SERDE}'
stored as ${FILE} tblproperties ("orc.compress"="SNAPPY");

insert overwrite table inventory select * from ${SOURCE}.inventory;
