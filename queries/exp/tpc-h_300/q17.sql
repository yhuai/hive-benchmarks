use ${DB};

EXPLAIN
select
  sum(tmp1.l_extendedprice) / 7.0 as avg_yearly
from (select
        l_partkey,
        l_quantity,
        l_extendedprice
      from lineitem join part on (lineitem.l_partkey = part.p_partkey)
      where
        part.p_brand = 'Brand#25'
        and part.p_container = 'JUMBO BAG') tmp1
join (select
        l_partkey as lp,
        0.2 * avg(l_quantity) as lq
      from lineitem
      group by
        l_partkey) tmp2
on (tmp1.l_partkey = tmp2.lp)
where
  tmp1.l_quantity < tmp2.lq;

select
  sum(tmp1.l_extendedprice) / 7.0 as avg_yearly
from (select
        l_partkey,
        l_quantity,
        l_extendedprice
      from lineitem join part on (lineitem.l_partkey = part.p_partkey)
      where
        part.p_brand = 'Brand#25'
        and part.p_container = 'JUMBO BAG') tmp1
join (select
        l_partkey as lp,
        0.2 * avg(l_quantity) as lq
      from lineitem
      group by
        l_partkey) tmp2
on (tmp1.l_partkey = tmp2.lp)
where
  tmp1.l_quantity < tmp2.lq;