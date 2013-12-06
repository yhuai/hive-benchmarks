create database if not exists ${DB};
use ${DB};

drop table if exists warehouse;

create table warehouse
(
    w_warehouse_sk            int,
    w_warehouse_id            string,
    w_warehouse_name          string,
    w_warehouse_sq_ft         int,
    w_street_number           string,
    w_street_name             string,
    w_street_type             string,
    w_suite_number            string,
    w_city                    string,
    w_county                  string,
    w_state                   string,
    w_zip                     string,
    w_country                 string,
    w_gmt_offset              float
)
row format serde '${SERDE}'
stored as ${FILE} tblproperties ("orc.compress"="SNAPPY");

insert overwrite table warehouse select * from ${SOURCE}.warehouse;