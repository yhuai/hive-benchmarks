use ${DB};

drop table if exists q18;

EXPLAIN
create table q18 as
select
  c.c_name,
  c.c_custkey,
  tmp3.o_orderkey,
  tmp3.o_orderdate,
  tmp3.o_totalprice,
  sum(tmp3.l_quantity)
from (select
        o_custkey,
        o_orderkey,
        o_orderdate,
        o_totalprice,
        l_quantity
      from (select
              o.o_custkey,
              o.o_orderkey,
              o.o_orderdate,
              o.o_totalprice,
              l.l_quantity
            from orders o join lineitem l on (l.l_orderkey = o.o_orderkey)) tmp1
      join (select
              l_orderkey,
              sum(l_quantity) as t_sum_quantity
            from lineitem
            group by
              l_orderkey) tmp2
      on (tmp1.o_orderkey = tmp2.l_orderkey)
      where
        tmp2.t_sum_quantity > 315) tmp3
join customer c
on (tmp3.o_custkey = c.c_custkey)
group by
  c.c_name,
  c.c_custkey,
  tmp3.o_orderkey,
  tmp3.o_orderdate,
  tmp3.o_totalprice
order by
  tmp3.o_totalprice desc,
  tmp3.o_orderdate;

create table q18 as
select
  c.c_name,
  c.c_custkey,
  tmp3.o_orderkey,
  tmp3.o_orderdate,
  tmp3.o_totalprice,
  sum(tmp3.l_quantity)
from (select
        o_custkey,
        o_orderkey,
        o_orderdate,
        o_totalprice,
        l_quantity
      from (select
              o_custkey,
              o_orderkey,
              o_orderdate,
              o_totalprice,
              l_quantity
            from orders o join lineitem l on (l.l_orderkey = o.o_orderkey)) tmp1
      join (select
              l_orderkey,
              sum(l_quantity) as t_sum_quantity
            from lineitem
            group by
              l_orderkey) tmp2
      on (tmp1.o_orderkey = tmp2.l_orderkey)
      where
        tmp2.t_sum_quantity > 315) tmp3
join customer c
on (tmp3.o_custkey = c.c_custkey)
group by
  c.c_name,
  c.c_custkey,
  tmp3.o_orderkey,
  tmp3.o_orderdate,
  tmp3.o_totalprice
order by
  tmp3.o_totalprice desc,
  tmp3.o_orderdate;

drop table if exists q18;