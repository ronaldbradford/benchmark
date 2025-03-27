-- heartbeat.lua
-- 
-- Author: Ronald Bradford https://github.com/ronaldbradford/
--
-- 1. Ensure you have a user (e.g. sysbench) with privileges to manage the heatbeat table in the schema provided.
--    mysql> CREATE USER sysbench IDENTIFIED BY 'T55.#9gTkqYY';
--    mysql> GRANT CREATE,DROP,INSERT,UPDATE ON sysbench.heartbeat TO sysbench;
--    mysql> CREATE SCHEMA sysbench;
--
-- 2. Create and seed the heartbeat table (defaults to 'heartbeat') with:
--
--    $ sysbench --config-file=sysbench.cnf heartbeat.lua prepare
--
--    Options:
--      --table-name=<differenttable>
--
-- 3. Run the heartbeat benchmark with:
--
--    $ sysbench --config-file=sysbench.cnf heartbeat.lua ran
--
-- 4. Verify results
--
--    mysql> SELECT * FROM heatbeat;

if sysbench.cmdline.command == nil then
   error("A command is required. Supported commands are: prepare|run")
end

sysbench.cmdline.options = {
   table_name = {"Heartbeat Table Name", "heartbeat3"},
   threads =    {"Threads", 1},
   time =       {"Execution Time (6hrs)", 21600},
   report_interval = {"Report Interval", 60}
}

function init()
  print("Heartbeat Benchmark Initialized")
end

function thread_init()
  con = sysbench.sql.driver():connect()
  table_name = sysbench.opt.table_name
  query = string.format([[UPDATE %s SET counter = counter + 1, updated = NOW(6)]], table_name)
  stmt = con:prepare(query)
end

function event()
  local rs = stmt:execute()
end

function thread_done()
    stmt:close()
    con:disconnect()
end

function done(thread_id)
  print("Heartbeat Benchmark Done")
end

function prepare()
  print ("Preparing "..table_name.." table")
  con = sysbench.sql.driver():connect()
  con:query("DROP TABLE IF EXISTS "..table_name)
  query = string.format([[
    CREATE TABLE %s (
      id INT NOT NULL,
      counter BIGINT UNSIGNED NOT NULL DEFAULT 0,
      updated TIMESTAMP(6)
    ) ]], table_name)
  con:query(query)

  query = string.format([[INSERT INTO %s VALUES(1,0,NOW(6))]], table_name)
  con:query(query)
end

-- These are not actually needed, sysbench will return it's own version
function cleanup()
  print("cleanup not used in this test")
end
