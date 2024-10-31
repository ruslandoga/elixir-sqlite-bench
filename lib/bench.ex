defmodule Bench do
  @moduledoc false

  def xqlite_bind_all(%{stmt: stmt, params: params}) do
    xqlite_bind_all(params, 1, stmt)
  end

  defp xqlite_bind_all([param | params], idx, stmt) do
    case param do
      i when is_integer(i) -> XQLite.bind_integer(stmt, idx, i)
      f when is_float(f) -> XQLite.bind_float(stmt, idx, f)
      t when is_binary(t) -> XQLite.bind_text(stmt, idx, t)
      nil -> XQLite.bind_null(stmt, idx)
    end

    xqlite_bind_all(params, idx + 1, stmt)
  end

  defp xqlite_bind_all([], _index, _stmt), do: :ok

  def exqlite_bind_all(%{db: db, stmt: stmt, params: params}) do
    Exqlite.Sqlite3.bind(db, stmt, params)
  end

  def xqlite_fetch_all(%{stmt: stmt}) do
    XQLite.fetch_all(stmt)
  end

  def exqlite_fetch_all(%{db: db, stmt: stmt}) do
    Exqlite.Sqlite3.fetch_all(db, stmt)
  end

  def xqlite_insert_all(%{rows: rows, insert: insert, begin: begin, commit: commit}) do
    XQLite.step(begin)
    XQLite.insert_all(insert, [:integer, :float, :text, :blob, :text], rows)
    XQLite.step(commit)
  end

  def exqlite_insert_all(%{db: db, sql: sql, rows: rows}) do
    full_sql = [sql, "(?, ?, ?, ?, ?)" | List.duplicate(", (?, ?, ?, ?, ?)", length(rows) - 1)]
    {:ok, stmt} = Exqlite.Sqlite3.prepare(db, full_sql)
    :ok = Exqlite.Sqlite3.bind(db, stmt, List.flatten(rows))
    :done = Exqlite.Sqlite3.step(db, stmt)
    :ok = Exqlite.Sqlite3.release(db, stmt)
  end
end
