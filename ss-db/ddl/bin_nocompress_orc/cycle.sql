create database if not exists ${DB};
use ${DB};

drop table if exists cycle;

create table cycle
(
    tile                      int,
    x                         int,
    y                         int,
    pix                       int,
    var                       int,
    valid                     int,
    sat                       int,
    v0                        int,
    v1                        int,
    v2                        int,
    v3                        int,
    v4                        int,
    v5                        int,
    v6                        int
)
row format serde '${SERDE}'
stored as ${FILE} tblproperties ("orc.compress"="NONE");

insert overwrite table cycle select * from ${SOURCE}.cycle;