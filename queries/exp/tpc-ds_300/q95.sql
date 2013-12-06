use ${DB};

EXPLAIN
select count(distinct ws1.ws_order_number) as order_count,
       sum(ws1.ws_ext_ship_cost) as total_shipping_cost,
       sum(ws1.ws_net_profit) as total_net_profit
from web_sales ws1
join customer_address ca on (ws1.ws_ship_addr_sk = ca.ca_address_sk)
join web_site s on (ws1.ws_web_site_sk = s.web_site_sk)
join date_dim d on (ws1.ws_ship_date_sk = d.d_date_sk)
left semi join (select ws2.ws_order_number as ws_order_number
              from web_sales ws2 join web_sales ws3
              on (ws2.ws_order_number = ws3.ws_order_number)
              where ws2.ws_warehouse_sk <> ws3.ws_warehouse_sk) ws_wh1
        on (ws1.ws_order_number = ws_wh1.ws_order_number)
left semi join (select wr_order_number
              from web_returns wr
              join (select ws4.ws_order_number as ws_order_number
                    from web_sales ws4 join web_sales ws5
                    on (ws4.ws_order_number = ws5.ws_order_number)
                    where ws4.ws_warehouse_sk <> ws5.ws_warehouse_sk) ws_wh2
              on (wr.wr_order_number = ws_wh2.ws_order_number)) tmp1
        on (ws1.ws_order_number = tmp1.wr_order_number)
where d.d_date >= '2001-05-01' and
      d.d_date <= '2001-06-30' and
      ca.ca_state = 'NC' and
      s.web_company_name = 'pri';

select count(distinct ws1.ws_order_number) as order_count,
       sum(ws1.ws_ext_ship_cost) as total_shipping_cost,
       sum(ws1.ws_net_profit) as total_net_profit
from web_sales ws1
join customer_address ca on (ws1.ws_ship_addr_sk = ca.ca_address_sk)
join web_site s on (ws1.ws_web_site_sk = s.web_site_sk)
join date_dim d on (ws1.ws_ship_date_sk = d.d_date_sk)
left semi join (select ws2.ws_order_number as ws_order_number
              from web_sales ws2 join web_sales ws3
              on (ws2.ws_order_number = ws3.ws_order_number)
              where ws2.ws_warehouse_sk <> ws3.ws_warehouse_sk) ws_wh1
        on (ws1.ws_order_number = ws_wh1.ws_order_number)
left semi join (select wr_order_number
              from web_returns wr
              join (select ws4.ws_order_number as ws_order_number
                    from web_sales ws4 join web_sales ws5
                    on (ws4.ws_order_number = ws5.ws_order_number)
                    where ws4.ws_warehouse_sk <> ws5.ws_warehouse_sk) ws_wh2
              on (wr.wr_order_number = ws_wh2.ws_order_number)) tmp1
        on (ws1.ws_order_number = tmp1.wr_order_number)
where d.d_date >= '2001-05-01' and
      d.d_date <= '2001-06-30' and
      ca.ca_state = 'NC' and
      s.web_company_name = 'pri';