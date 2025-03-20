# `sysbench` Lua Scripts

The following is a list of Lua scripts online that can be found for `sysbench` database tests from various authors.


| Lua script  | Author | Additional Options |Summary  |
| ----------- | ------ | -------- |----------|
| [oltp_point_select.lua](https://github.com/akopytov/sysbench/blob/master/src/lua/oltp_point_select.lua) | Alexey Kopytov | `point_selects` | Performs 1 select |
| [oltp_insert.lua](https://github.com/akopytov/sysbench/blob/master/src/lua/oltp_delete.lua) | Alexey Kopytov | `auto_inc` | Insert 1 row, no transaction support |  
|[oltp_update_index](https://github.com/akopytov/sysbench/blob/master/src/lua/oltp_update_index.lua) | Alexey Kopytov |  | Updates 1 row with indexed column  |
| [oltp_update_non_index.lua](https://github.com/akopytov/sysbench/blob/master/src/lua/oltp_update_non_index.lua) | Alexey Kopytov |  | Updates 1 row |
| [oltp_delete.lua](https://github.com/akopytov/sysbench/blob/master/src/lua/oltp_delete.lua) | Alexey Kopytov |  | Deletes 1 row. No transaction support |  
| [oltp_ready_only.lua](https://github.com/akopytov/sysbench/blob/master/src/lua/oltp_read_only.lua) | Alexey Kopytov | `range_selects`, `skip_trx` | Performs 16 statements [Analysis](oltp_read_only.md)  |  
| [oltp_write_only.lua](https://github.com/akopytov/sysbench/blob/master/src/lua/oltp_write_only.lua) | Alexey Kopytov | `skip_trx` | Combines `oltp_update_index`, `oltp_update_non_index` and additional delete + re-insert |
| [oltp_read_write.lua](https://github.com/akopytov/sysbench/blob/master/src/lua/oltp_read_write.lua) | Alexey Kopytov | `range_selects`, `skip_trx`  | Combines `oltp_ready_only`, `oltp_write_only` |  
| [bulk_insert.lua](https://github.com/akopytov/sysbench/blob/master/src/lua/bulk_insert.lua) | Alexey Kopytov |  |  |
| [oltp_common.lua](https://github.com/akopytov/sysbench/blob/oltp_common.lua) | Alexey Kopytov |  | Not Executable. Common code for oltp_* tests |
| [oltp_inlist_select.lua](https://github.com/mdcallag/mytools/blob/master/bench/sysbench.lua/lua/oltp_inlist_select.lua) | Mark Callaghan | `random_points`, `hot_points` |
| [oltp_points_covered.lua](https://github.com/mdcallag/mytools/blob/master/bench/sysbench.lua/lua/oltp_points_covered.lua) | Mark Callaghan |`random_points`, `on_id`, `covered` ||
| [oltp_range_covered.lua](https://github.com/mdcallag/mytools/blob/master/bench/sysbench.lua/lua/oltp_range_covered.lua) | Mark Callaghan | `random_points`, `on_id`, `covered` |  |
| [oltp_inlist_update.lua](https://github.com/mdcallag/mytools/blob/master/bench/sysbench.lua/lua/oltp_inlist_update.lua) | Mark Callaghan | `random_points`, `hot_points` |  |
| [oltp_update_rate.lua](https://github.com/mdcallag/mytools/blob/master/bench/sysbench.lua/lua/oltp_update_rate.lua) | Mark Callaghan | `update_rate` |  |
| [oltp_scan.lua](https://github.com/mdcallag/mytools/blob/master/bench/sysbench.lua/lua/oltp_scan.lua) | Mark Callaghan |  | Scans the table but filters all rows to avoid stressing client/server network |
| [oltp_read_only_count.lua](https://github.com/mdcallag/mytools/blob/master/bench/sysbench.lua/lua/oltp_read_only_count.lua)| Mark Callaghan | `count_ranges` | Requires custom [oltp_common.lua](https://github.com/mdcallag/mytools/blob/master/bench/sysbench.lua/lua/oltp_common.lua) |
| [oltp_read_only_q1](https://github.com/mdcallag/mytools/blob/master/bench/sysbench.lua/lua/oltp_read_only_q1.lua)| Mark Callaghan||subset of `oltp_read_only` point_selects |
| [oltp_read_only_q2](https://github.com/mdcallag/mytools/blob/master/bench/sysbench.lua/lua/oltp_read_only_q1.lua)| Mark Callaghan||subset of `oltp_read_only` simple_ranges |
| [oltp_read_only_q3](https://github.com/mdcallag/mytools/blob/master/bench/sysbench.lua/lua/oltp_read_only_q1.lua)| Mark Callaghan||subset of `oltp_read_only` sum_ranges|
| [oltp_read_only_q4](https://github.com/mdcallag/mytools/blob/master/bench/sysbench.lua/lua/oltp_read_only_q1.lua)| Mark Callaghan||subset of `oltp_read_only` order_ranges|
| [oltp_read_only_q5](https://github.com/mdcallag/mytools/blob/master/bench/sysbench.lua/lua/oltp_read_only_q1.lua)| Mark Callaghan|| subset of `oltp_read_only` distinct_ranges |
| [iibench.lua](https://github.com/Dmitree-Max/sysbench-iibench/blob/main/iibench.lua) | Dmitrii Maximenko ||
| [core.lua](https://github.com/ronaldbradford/benchmark/blob/main/mysql/imdb/core.lua) | Ronald Bradford | `type` | Runs configurable SELECT SQL and data per `type` |
