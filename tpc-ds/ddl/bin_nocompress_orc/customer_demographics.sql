create database if not exists ${DB};
use ${DB};

drop table if exists customer_demographics;

create table customer_demographics
(
    cd_demo_sk                int,
    cd_gender                 string,
    cd_marital_status         string,
    cd_education_status       string,
    cd_purchase_estimate      int,
    cd_credit_rating          string,
    cd_dep_count              int,
    cd_dep_employed_count     int,
    cd_dep_college_count      int 
)
row format serde '${SERDE}'
stored as ${FILE} tblproperties ("orc.compress"="NONE");

insert overwrite table customer_demographics select * from ${SOURCE}.customer_demographics;