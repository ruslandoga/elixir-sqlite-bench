sql = """
with recursive cte(i) as (
  select 1
  union all
  select i + 1 from cte where i < ?
)
select i, 'hello' || i, null from cte
"""

Benchee.run(
  %{
    "xqlite" =>
      {&Bench.xqlite_fetch_all/1,
       before_scenario: fn rows ->
         db = XQLite.open(":memory:", [:readonly, :nomutex])
         stmt = XQLite.prepare(db, sql, [:persistent])
         XQLite.bind_number(db, stmt, 1, rows)
         %{db: db, stmt: stmt}
       end,
       after_scenario: fn %{db: db, stmt: stmt} ->
         XQLite.finalize(stmt)
         XQLite.close(db)
       end},
    "exqlite" =>
      {&Bench.exqlite_fetch_all/1,
       before_scenario: fn rows ->
         {:ok, db} = Exqlite.Sqlite3.open(":memory:", mode: [:readonly, :nomutex])
         {:ok, stmt} = Exqlite.Sqlite3.prepare(db, sql)
         :ok = Exqlite.Sqlite3.bind(db, stmt, [rows])
         %{db: db, stmt: stmt}
       end,
       after_scenario: fn %{db: db, stmt: stmt} ->
         :ok = Exqlite.Sqlite3.release(db, stmt)
         :ok = Exqlite.Sqlite3.close(db)
       end}
  },
  inputs: %{
    "10 rows" => 10,
    "100 rows" => 100,
    "1000 rows" => 1000,
    "10000 rows" => 10000
  }
)