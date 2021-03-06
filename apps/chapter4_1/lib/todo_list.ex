defmodule TodoList do
  @moduledoc """
  TodoList implementation from chapter 4 of EiA
  """
  @doc """
  creates a new TodoList
  """
  def new, do: MultiMap.new()

  @doc """
  Adds a new entry to the given TodoList
  """
  def add_entry(todo_list, entry) do
    MultiMap.add(todo_list, entry.date, entry)
  end

  @doc """
  Return all entries for a given date or an empty list
  """
  def entries(todo_list, date) do
    MultiMap.get(todo_list, date)
  end
end
