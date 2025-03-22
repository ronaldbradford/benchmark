# `sysbench` Lua Scripts

The following is a list of Lua scripts online that can be found for `sysbench` database tests from various authors.


| Lua script  | Author | Additional Options |Summary  |
| ----------- | ------ | -------- |----------|
| [oltp_point_select.lua](https://github.com/akopytov/sysbench/blob/master/src/lua/oltp_point_select.lua) | Alexey Kopytov | `point_selects` | Performs 1 select |
| [oltp_insert.lua](https://github.com/akopytov/sysbench/blob/master/src/lua/oltp_delete.lua) | Alexey Kopytov | `auto_inc` | Insert 1 row, no transaction support |  
|[oltp_update_index.lua](https://github.com/akopytov/sysbench/blob/master/src/lua/oltp_update_index.lua) | Alexey Kopytov |  | Updates 1 row with indexed column  |
| [oltp_update_non_index.lua](https://github.com/akopytov/sysbench/blob/master/src/lua/oltp_update_non_index.lua) | Alexey Kopytov |  | Updates 1 row [Analysis](oltp_update_non_index.md) |
| [oltp_delete.lua](https://github.com/akopytov/sysbench/blob/master/src/lua/oltp_delete.lua) | Alexey Kopytov |  | Deletes 1 row. No transaction support |  
| [oltp_ready_only.lua](https://github.com/akopytov/sysbench/blob/master/src/lua/oltp_read_only.lua) | Alexey Kopytov | `range_selects`, `skip_trx` | Performs 16 statements [Analysis](oltp_read_only.md)  |  
| [oltp_write_only.lua](https://github.com/akopytov/sysbench/blob/master/src/lua/oltp_write_only.lua) | Alexey Kopytov | `skip_trx` | Combines `oltp_update_index`, `oltp_update_non_index` and additional delete + re-insert |
| [oltp_read_write.lua](https://github.com/akopytov/sysbench/blob/master/src/lua/oltp_read_write.lua) | Alexey Kopytov | `range_selects`, `skip_trx`  | Combines `oltp_ready_only`, `oltp_write_only` |  
| [bulk_insert.lua](https://github.com/akopytov/sysbench/blob/master/src/lua/bulk_insert.lua) | Alexey Kopytov |  |  |
| [oltp_common.lua](https://github.com/akopytov/sysbench/blob/master/src/lua/oltp_common.lua) | Alexey Kopytov |  | Not Executable. Common code for oltp_* tests |
| [oltp_inlist_select.lua](https://github.com/mdcallag/mytools/blob/master/bench/sysbench.lua/lua/oltp_inlist_select.lua) | Mark Callaghan | `random_points`, `hot_points` |
| [oltp_points_covered.lua](https://github.com/mdcallag/mytools/blob/master/bench/sysbench.lua/lua/oltp_points_covered.lua) | Mark Callaghan |`random_points`, `on_id`, `covered` ||
| [oltp_range_covered.lua](https://github.com/mdcallag/mytools/blob/master/bench/sysbench.lua/lua/oltp_range_covered.lua) | Mark Callaghan | `random_points`, `on_id`, `covered` |  |
| [oltp_inlist_update.lua](https://github.com/mdcallag/mytools/blob/master/bench/sysbench.lua/lua/oltp_inlist_update.lua) | Mark Callaghan | `random_points`, `hot_points` |  |
| [oltp_update_rate.lua](https://github.com/mdcallag/mytools/blob/master/bench/sysbench.lua/lua/oltp_update_rate.lua) | Mark Callaghan | `update_rate` |  |
| [oltp_scan.lua](https://github.com/mdcallag/mytools/blob/master/bench/sysbench.lua/lua/oltp_scan.lua) | Mark Callaghan |  | Scans the table but filters all rows to avoid stressing client/server network |
| [oltp_read_only_count.lua](https://github.com/mdcallag/mytools/blob/master/bench/sysbench.lua/lua/oltp_read_only_count.lua)| Mark Callaghan | `count_ranges` | Requires custom [oltp_common.lua](https://github.com/mdcallag/mytools/blob/master/bench/sysbench.lua/lua/oltp_common.lua) |
| [oltp_read_only_q1.lua](https://github.com/mdcallag/mytools/blob/master/bench/sysbench.lua/lua/oltp_read_only_q1.lua)| Mark Callaghan||point_selects query of `oltp_read_only`  |
| [oltp_read_only_q2.lua](https://github.com/mdcallag/mytools/blob/master/bench/sysbench.lua/lua/oltp_read_only_q1.lua)| Mark Callaghan|| simple_ranges subset of `oltp_read_only`  |
| [oltp_read_only_q3.lua](https://github.com/mdcallag/mytools/blob/master/bench/sysbench.lua/lua/oltp_read_only_q1.lua)| Mark Callaghan||sum_ranges query of `oltp_read_only` |
| [oltp_read_only_q4.lua](https://github.com/mdcallag/mytools/blob/master/bench/sysbench.lua/lua/oltp_read_only_q1.lua)| Mark Callaghan|| order_ranges query of `oltp_read_only` |
| [oltp_read_only_q5.lua](https://github.com/mdcallag/mytools/blob/master/bench/sysbench.lua/lua/oltp_read_only_q1.lua)| Mark Callaghan|| distinct_ranges query of `oltp_read_only`  |
| [tpcc.lua *](https://github.com/Percona-Lab/sysbench-tpcc/blob/master/tpcc.lua) | Percona || A sysbench implementation of TPCC |
| [iibench.lua](https://github.com/Dmitree-Max/sysbench-iibench/blob/main/iibench.lua) | Dmitrii Maximenko || A sysbench implementation of iibench |
| [select_random_ranges.lua](https://github.com/yugabyte/sysbench/blob/master/src/lua/select_random_ranges.lua) | Yugabyte | `number_of_ranges`, `delta` ||
| [oltp_sequential_scan.lua](https://github.com/yugabyte/sysbench/blob/master/src/lua/oltp_sequential_scan.lua) | Yugabyte | |
| [oltp_join.lua](https://github.com/yugabyte/sysbench/blob/master/src/lua/oltp_join.lua) | Yubabyte ||
| [oltp_multi_value_insert.lua](https://github.com/yugabyte/sysbench/blob/master/src/lua/oltp_multi_value_insert.lua)| YugaByte | `smaller_row_sizes`, `batch_insert_count`
| [select_one.lua](https://github.com/yugabyte/sysbench/blob/master/src/lua/select_one.lua)| YugaByte || `SELECT 1`|
| [idleconnection.lua](https://github.com/yugabyte/sysbench/blob/master/src/lua/idleconnection.lua) | Yugabyte | | Idle Connections|
| [oltp_transaction_benchmarks.lua](https://github.com/icyflame/sysbench-custom/blob/custom-benchmarks/src/lua/oltp_transaction_benchmarks.lua) | Siddharth Kannan | |
| [imdb_workload.lua](https://gist.github.com/utdrmac/92d00a34149565bc155cdef80b6cba12) |Matthew Boehm || See [Creating Custom Sysbench Scripts](https://www.percona.com/blog/creating-custom-sysbench-scripts/) |
| [oltp-xa.lua](https://github.com/zettadb/sysbench-xa/blob/main/sysbench/tests/db/oltp-xa.lua)| ZettaDB |||
| [oltp_pg_udf.lua](https://github.com/digoal/sysbench/blob/master/sysbench/lua/oltp_pg_udf.lua)| Digoal Zhou ||This 0.5 repo supports Oracle|
| [insert-roll.lua](https://bazaar.launchpad.net/~vadim-tk/sysbench/insert-roll/view/head:/sysbench/tests/db/common_roll.lua)| Vadim Tkachenko || Tokutek DB Tests |
| [filler.lua](https://gist.github.com/ronaldbradford/93a810971d62c8b1a4c92e1874000811)| Ronald Bradford | | Basic example of a Insert |
| [core.lua](https://github.com/ronaldbradford/benchmark/blob/main/mysql/imdb/core.lua) | Ronald Bradford | `type` | Runs configurable SELECT SQL and data per `type` |
