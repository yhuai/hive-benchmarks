use ${DB};

EXPLAIN
select
   i_item_id,
   s_state,
   avg(ss_quantity) agg1,
   avg(ss_list_price) agg2,
   avg(ss_coupon_amt) agg3,
   avg(ss_sales_price) agg4
FROM store_sales
JOIN date_dim on (store_sales.ss_sold_date_sk = date_dim.d_date_sk)
JOIN item on (store_sales.ss_item_sk = item.i_item_sk)
JOIN customer_demographics on (store_sales.ss_cdemo_sk = customer_demographics.cd_demo_sk)
JOIN store on (store_sales.ss_store_sk = store.s_store_sk)
where
   cd_gender = 'F' and
   cd_marital_status = 'U' and
   cd_education_status = 'Primary' and
   d_year = 2002 and
   s_state in ('GA','PA', 'LA', 'SC', 'MI', 'AL')
group by
   i_item_id,
   s_state
order by
   i_item_id,
   s_state
limit 100;

select
   i_item_id,
   s_state,
   avg(ss_quantity) agg1,
   avg(ss_list_price) agg2,
   avg(ss_coupon_amt) agg3,
   avg(ss_sales_price) agg4
FROM store_sales
JOIN date_dim on (store_sales.ss_sold_date_sk = date_dim.d_date_sk)
JOIN item on (store_sales.ss_item_sk = item.i_item_sk)
JOIN customer_demographics on (store_sales.ss_cdemo_sk = customer_demographics.cd_demo_sk)
JOIN store on (store_sales.ss_store_sk = store.s_store_sk)
where
   cd_gender = 'F' and
   cd_marital_status = 'U' and
   cd_education_status = 'Primary' and
   d_year = 2002 and
   s_state in ('GA','PA', 'LA', 'SC', 'MI', 'AL')
group by
   i_item_id,
   s_state
order by
   i_item_id,
   s_state
limit 100;