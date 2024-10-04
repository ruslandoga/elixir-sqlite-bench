defmodule Bench do
  @moduledoc false

  def xqlite_bind_all(%{db: db, stmt: stmt, params: params}) do
    xqlite_bind_all(params, 1, db, stmt)
  end

  defp xqlite_bind_all([param | params], idx, db, stmt) do
    case param do
      num when is_number(num) -> XQLite.bind_number(db, stmt, idx, num)
      txt when is_binary(txt) -> XQLite.bind_text(db, stmt, idx, txt)
      nil -> XQLite.bind_null(db, stmt, idx)
    end

    xqlite_bind_all(params, idx + 1, db, stmt)
  end

  defp xqlite_bind_all([], _index, _db, _stmt), do: :ok

  def exqlite_bind_all(%{db: db, stmt: stmt, params: params}) do
    Exqlite.Sqlite3.bind(db, stmt, params)
  end

  def xqlite_fetch_all(%{db: db, stmt: stmt}) do
    XQLite.fetch_all(db, stmt)
  end

  def exqlite_fetch_all(%{db: db, stmt: stmt}) do
    Exqlite.Sqlite3.fetch_all(db, stmt)
  end
end
