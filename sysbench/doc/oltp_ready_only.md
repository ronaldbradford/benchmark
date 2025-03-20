# What does `oltp_read_only` really do?

In short, this test by default runs 16 SQL statements per event, i.e. thread execution (tps).

## Example SQL
```
BEGIN;
SELECT c FROM sbtest1 WHERE id=5048;
SELECT c FROM sbtest1 WHERE id=5015;
SELECT c FROM sbtest1 WHERE id=5033;
SELECT c FROM sbtest1 WHERE id=5889;
SELECT c FROM sbtest1 WHERE id=5269;
SELECT c FROM sbtest1 WHERE id=5043;
SELECT c FROM sbtest1 WHERE id=5036;
SELECT c FROM sbtest1 WHERE id=5037;
SELECT c FROM sbtest1 WHERE id=4981;
SELECT c FROM sbtest1 WHERE id=5012;
SELECT c FROM sbtest1 WHERE id BETWEEN 5012 AND 5111;
SELECT SUM(k) FROM sbtest1 WHERE id BETWEEN 5048 AND 5147;
SELECT c FROM sbtest1 WHERE id BETWEEN 5320 AND 5419 ORDER BY c;
SELECT DISTINCT c FROM sbtest1 WHERE id BETWEEN 5007 AND 5106 ORDER BY c;
COMMIT;
```

## Lua Code

The `event` function of [oltp_ready_only](https://github.com/akopytov/sysbench/blob/master/src/lua/oltp_read_only.lua#L40-L59) consists of 5 executions in addition to transaction management. You can disable transaction management, and run only `point_selects`. You cannot separate out `simple_ranges`, `sum_ranges`, `order_ranges` and `distinct_ranges` separately. See the [oltp_read_only_q? tests](TESTS.md) for individual cases.

```
   if not sysbench.opt.skip_trx then
      begin()
   end

   execute_point_selects()

   if sysbench.opt.range_selects then
      execute_simple_ranges()
      execute_sum_ranges()
      execute_order_ranges()
      execute_distinct_ranges()
   end

   if not sysbench.opt.skip_trx then
      commit()
   end
```


## Unique SQL Statements

```
/* ! skip_trx */      START TRANSACTION;
/* point_selects */   SELECT c FROM sbtest1 WHERE id=?;
/* simple_ranges */   SELECT c FROM sbtest1 WHERE id BETWEEN ? AND ?;
/* sum_ranges */      SELECT SUM(k) FROM sbtest1 WHERE id BETWEEN ? AND ?;
/* order_ranges */    SELECT c FROM sbtest1 WHERE id BETWEEN ? AND ? ORDER BY c;
/* distinct_ranges */ SELECT DISTINCT c FROM sbtest1 WHERE id BETWEEN ? AND ? ORDER BY c;
/* ! skip_trx */      COMMIT;
```

It gets a total of 16 due to the default values for each `SELECT` type.
```
point_selects = 10
simple_ranges = 1
sum_ranges = 1
order_ranges = 1
distinct_ranges = 1
```



## Single SQL Statement

If you want this test to run a single point select, you need to add the options `--range-selects=0 --point-selects=1 --skip-trx=1`

F or example:
```
LUA_PATH="/usr/share/sysbench/?.lua" sysbench --config-file=sysbench.cnf \
     --range-selects=0 --point-selects=1 --skip-trx=1  \
     --time=1 --threads=1 --report-interval=1  --histogram --rand-type=uniform \
     oltp_read_only run
```


### Query Execution Plan (QEP)

```
mysql> explain SELECT c FROM sbtest1 WHERE id=5048;
+----+-------------+---------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
| id | select_type | table   | partitions | type  | possible_keys | key     | key_len | ref   | rows | filtered | Extra |
+----+-------------+---------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
|  1 | SIMPLE      | sbtest1 | NULL       | const | PRIMARY       | PRIMARY | 4       | const |    1 |   100.00 | NULL  |
+----+-------------+---------+------------+-------+---------------+---------+---------+-------+------+----------+-------+

mysql> explain SELECT c FROM sbtest1 WHERE id BETWEEN 5013 AND 5112;
+----+-------------+---------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
| id | select_type | table   | partitions | type  | possible_keys | key     | key_len | ref  | rows | filtered | Extra       |
+----+-------------+---------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | sbtest1 | NULL       | range | PRIMARY       | PRIMARY | 4       | NULL |  100 |   100.00 | Using where |
+----+-------------+---------+------------+-------+---------------+---------+---------+------+------+----------+-------------+

mysql> explain SELECT SUM(k) FROM sbtest1 WHERE id BETWEEN 5029 AND 5128;
+----+-------------+---------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
| id | select_type | table   | partitions | type  | possible_keys | key     | key_len | ref  | rows | filtered | Extra       |
+----+-------------+---------+------------+-------+---------------+---------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | sbtest1 | NULL       | range | PRIMARY,k_1   | PRIMARY | 4       | NULL |  100 |   100.00 | Using where |
+----+-------------+---------+------------+-------+---------------+---------+---------+------+------+----------+-------------+

mysql> explain SELECT c FROM sbtest1 WHERE id BETWEEN 5042 AND 5141 ORDER BY c;
+----+-------------+---------+------------+-------+---------------+---------+---------+------+------+----------+-----------------------------+
| id | select_type | table   | partitions | type  | possible_keys | key     | key_len | ref  | rows | filtered | Extra                       |
+----+-------------+---------+------------+-------+---------------+---------+---------+------+------+----------+-----------------------------+
|  1 | SIMPLE      | sbtest1 | NULL       | range | PRIMARY       | PRIMARY | 4       | NULL |  100 |   100.00 | Using where; Using filesort |
+----+-------------+---------+------------+-------+---------------+---------+---------+------+------+----------+-----------------------------+

mysql> explain SELECT DISTINCT c FROM sbtest1 WHERE id BETWEEN 4270 AND 4369 ORDER BY c;
+----+-------------+---------+------------+-------+---------------+---------+---------+------+------+----------+----------------------------------------------+
| id | select_type | table   | partitions | type  | possible_keys | key     | key_len | ref  | rows | filtered | Extra                                        |
+----+-------------+---------+------------+-------+---------------+---------+---------+------+------+----------+----------------------------------------------+
|  1 | SIMPLE      | sbtest1 | NULL       | range | PRIMARY       | PRIMARY | 4       | NULL |  100 |   100.00 | Using where; Using temporary; Using filesort |
+----+-------------+---------+------------+-------+---------------+---------+---------+------+------+----------+----------------------------------------------+
```

## Table Structure

```
CREATE TABLE `sbtest1` (
  `id` int NOT NULL AUTO_INCREMENT,
  `k` int NOT NULL DEFAULT '0',
  `c` char(120) NOT NULL DEFAULT '',
  `pad` char(60) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `k_1` (`k`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
```
