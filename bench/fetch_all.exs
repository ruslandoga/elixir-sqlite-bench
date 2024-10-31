sql = """
with recursive cte(i) as (
  values(1)
  union all
  select i + 1 from cte where i < ?
)
select
  i as integer,
  i / 1.0 as float,
  'hello' || i as text,
  x'534F53' as blob,
  null
from cte
"""

Benchee.run(
  %{
    "xqlite" =>
      {&Bench.xqlite_fetch_all/1,
       before_scenario: fn rows ->
         db = XQLite.open(":memory:", [:readonly, :nomutex])
         stmt = XQLite.prepare(db, sql, [:persistent])
         XQLite.bind_integer(stmt, 1, rows)
         %{stmt: stmt}
       end},
    "exqlite" =>
      {&Bench.exqlite_fetch_all/1,
       before_scenario: fn rows ->
         {:ok, db} = Exqlite.Sqlite3.open(":memory:", mode: [:readonly, :nomutex])
         {:ok, stmt} = Exqlite.Sqlite3.prepare(db, sql)
         :ok = Exqlite.Sqlite3.bind(db, stmt, [rows])
         %{db: db, stmt: stmt}
       end}
  },
  inputs: %{
    "10 rows" => 10,
    "100 rows" => 100,
    "1000 rows" => 1000,
    "10000 rows" => 10000
  }
)
