defmodule TodoList do
  @moduledoc """
  TodoList implementation from chapter 4 of EiA
  """

  defstruct auto_id: 1, entries: Map.new()

  @doc """
  creates a new TodoList
  """
  def new, do: %TodoList{}

  @doc """
  Adds a new entry to the given TodoList
  """
  def add_entry(%TodoList{entries: entries, auto_id: auto_id} = todo_list, entry) do
    entry = Map.put(entry, :id, auto_id)
    new_entries = Map.put(entries, auto_id, entry)

    %TodoList{todo_list | entries: new_entries, auto_id: auto_id + 1}
  end

  @doc """
  Return all entries for a given date or an empty list
  """
  def entries(%TodoList{entries: entries}, date) do
    entries
    |> Stream.filter(fn {_, entry} -> entry.date == date end)
    |> Enum.map(fn {_, entry} -> entry end)
  end
end
