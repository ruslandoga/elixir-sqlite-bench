create = """
create table test(
  i integer,
  f real,
  t text,
  b blob,
  n
)
"""

rows = fn count ->
  Stream.cycle([_row = [1, 1.0, "hello", <<83, 79, 83>>, nil]])
  |> Enum.take(count)
end

# xqlite reuses the same prepared statement for each row
# insert into test(i, f, t, b, n) values (?, ?, ?, ?, ?)
# exqlite prepares a new statement for each collection of rows to insert them all at once
# insert into test(i, f, t, b, n) values (?, ?, ?, ?, ?), (?, ?, ?, ?, ?), ...

Benchee.run(
  %{
    "xqlite" =>
      {&Bench.xqlite_insert_all/1,
       before_scenario: fn rows ->
         db = XQLite.open(":memory:", [:readwrite, :nomutex])
         :done = XQLite.step(db, XQLite.prepare(db, create))
         insert = "insert into test(i, f, t, b, n) values (?, ?, ?, ?, ?)"
         insert = XQLite.prepare(db, insert, [:persistent])
         begin = XQLite.prepare(db, "begin immediate", [:persistent])
         commit = XQLite.prepare(db, "commit", [:persistent])
         %{db: db, rows: rows, insert: insert, begin: begin, commit: commit}
       end,
       after_scenario: fn %{db: db, insert: insert, begin: begin, commit: commit} ->
         XQLite.finalize(insert)
         XQLite.finalize(begin)
         XQLite.finalize(commit)
         XQLite.close(db)
       end},
    "exqlite" =>
      {&Bench.exqlite_insert_all/1,
       before_scenario: fn rows ->
         {:ok, db} = Exqlite.Sqlite3.open(":memory:", mode: [:readwrite, :nomutex])
         :ok = Exqlite.Sqlite3.execute(db, create)

         rows =
           Enum.map(rows, fn row ->
             [i, f, t, b, n] = row
             [i, f, t, {:blob, b}, n]
           end)

         %{db: db, sql: "insert into test(i, f, t, b, n) values ", rows: rows}
       end,
       after_scenario: fn %{db: db} ->
         :ok = Exqlite.Sqlite3.close(db)
       end}
  },
  inputs: %{
    "1 row" => rows.(1),
    "10 rows" => rows.(10),
    "100 rows" => rows.(100),
    "1000 rows" => rows.(1000)
  },
  time: 1
)
