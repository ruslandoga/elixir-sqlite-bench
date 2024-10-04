Benchee.run(
  %{
    "xqlite" =>
      {&Bench.xqlite_bind_all/1,
       before_scenario: fn _input ->
         db = XQLite.open(":memory:", [:readonly, :nomutex])
         stmt = XQLite.prepare(db, "select ?, ?, ?")
         %{db: db, stmt: stmt, params: [1, "hello", nil]}
       end,
       after_scenario: fn %{db: db, stmt: stmt} ->
         XQLite.finalize(stmt)
         XQLite.close(db)
       end},
    "exqlite" =>
      {&Bench.exqlite_bind_all/1,
       before_scenario: fn _input ->
         {:ok, db} = Exqlite.Sqlite3.open(":memory:", mode: [:readonly, :nomutex])
         {:ok, stmt} = Exqlite.Sqlite3.prepare(db, "select ?, ?, ?")
         %{db: db, stmt: stmt, params: [1, "hello", nil]}
       end,
       after_scenario: fn %{db: db, stmt: stmt} ->
         :ok = Exqlite.Sqlite3.release(db, stmt)
         :ok = Exqlite.Sqlite3.close(db)
       end}
  },
  time: 3
)
