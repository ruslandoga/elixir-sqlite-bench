Benchee.run(
  %{
    "xqlite" =>
      {&Bench.xqlite_bind_all/1,
       before_scenario: fn _input ->
         db = XQLite.open(":memory:", [:readonly, :nomutex])
         stmt = XQLite.prepare(db, "select ?, ?, ?")
         %{stmt: stmt, params: [1, "hello", nil]}
       end},
    "exqlite" =>
      {&Bench.exqlite_bind_all/1,
       before_scenario: fn _input ->
         {:ok, db} = Exqlite.Sqlite3.open(":memory:", mode: [:readonly, :nomutex])
         {:ok, stmt} = Exqlite.Sqlite3.prepare(db, "select ?, ?, ?")
         %{db: db, stmt: stmt, params: [1, "hello", nil]}
       end}
  },
  time: 3
)
