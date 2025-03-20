# Small Datum

[Small Datum](https://smalldatum.blogspot.com/) by the well renowned database expert Mark Callaghan goes into detailed testing of MySQL, MariaDB and RocksDB.  His work is very technical including compiling source code for multiple versions across different architecture, and performing extensive instrumentation to product very detailed results.

For MySQL and PostgreSQL he runs an expanded list  `sysbench` tests over the default available and these are very valuable to understand. These are included in the [`sysbench` available tests](TESTS.md) list.

His tests based on [`run.sh`](https://github.com/mdcallag/mytools/blob/master/bench/sysbench.lua/run.sh) include the following lua scripts and arguments.

```
Test Type            Default    LUA Script                 ARGS
read-only               Y       oltp_read_only.lua        --rand-type=uniform
read-write              Y       oltp_read_write.lua       --rand-type=uniform
write-only              Y       oltp_write_only.lua       --rand-type=uniform
delete                  Y       oltp_delete.lua           --rand-type=uniform
update-inlist           MC      oltp_inlist_update.lua    --rand-type=uniform
update-one              Y       oltp_update_non_index.lua --rand-type=uniform --table-size=1  ***
update-nonindex         Y       oltp_update_non_index.lua --rand-type=uniform
update-zipf             Y       oltp_update_non_index.lua --rand-type=zipfian     ***
update-index            Y       oltp_update_index.lua     --rand-type=uniform
update-rate             MC      oltp_update_rate.lua      --rand-type=uniform --update-rate=1000
point-query             Y       oltp_point_select.lua     --rand-type=uniform --skip-trx
random-points           MC      oltp_inlist_select.lua    --rand-type=uniform --random-points=$range --skip-trx
hot-points              MC      oltp_inlist_select.lua    --rand-type=uniform --random-points=$range --hot-points --skip-trx
points-covered-pk       MC      oltp_points_covered.lua   --rand-type=uniform --random-points=$range --skip-trx
points-covered-si       MC      oltp_range_covered.lua    --rand-type=uniform --random-points=$range --skip-trx --on-id=false
points-notcovered-pk    MC      oltp_range_covered.lua    --rand-type=uniform --random-points=$range --skip-trx --covered=false
points-notcovered-si    MC      oltp_range_covered.lua    --rand-type=uniform --random-points=$range --skip-trx --on-id=false --covered=false
range-covered-pk        MC      oltp_range_covered.lua    --rand-type=uniform --random-points=$range --skip-trx
range-covered-si        MC      oltp_range_covered.lua    --rand-type=uniform --random-points=$range --skip-trx --on-id=false
range-notcovered-pk     MC      oltp_range_covered.lua    --rand-type=uniform --random-points=$range --skip-trx --covered=false
range-notcovered-si     MC      oltp_range_covered.lua    --rand-type=uniform --random-points=$range --skip-trx --on-id=false --covered=false
insert                  Y       oltp_insert.lua           --rand-type=uniform
scan                    MC      oltp_scan.lua             --rand-type=uniform
```
