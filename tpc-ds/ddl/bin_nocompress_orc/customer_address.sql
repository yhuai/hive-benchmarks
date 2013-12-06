create database if not exists ${DB};
use ${DB};

drop table if exists customer_address;

create table customer_address
(
    ca_address_sk             int,
    ca_address_id             string,
    ca_street_number          string,
    ca_street_name            string,
    ca_street_type            string,
    ca_suite_number           string,
    ca_city                   string,
    ca_county                 string,
    ca_state                  string,
    ca_zip                    string,
    ca_country                string,
    ca_gmt_offset             float,
    ca_location_type          string
)
row format serde '${SERDE}'
stored as ${FILE} tblproperties ("orc.compress"="NONE");

insert overwrite table customer_address select * from ${SOURCE}.customer_address;