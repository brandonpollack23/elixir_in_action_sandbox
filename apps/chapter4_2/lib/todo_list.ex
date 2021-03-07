defmodule TodoList.TodoEntry do
  defstruct id: -1, value: nil

  def new(id, value), do: %__MODULE__{id: id, value: value}

  def change_value(%__MODULE__{id: id}, value), do: %__MODULE__{id: id, value: value}
end

defmodule TodoList do
  @moduledoc """
  TodoList implementation from chapter 4 of EiA
  """
  alias TodoList.TodoEntry, as: TodoEntry

  defstruct auto_id: 1, entries: Map.new()

  @doc """
  creates a new TodoList
  """
  def new, do: %TodoList{}

  def new(entries) do
    Enum.reduce(entries, %TodoList{}, &add_entry(&2, &1))
  end

  @doc """
  Adds a new entry to the given TodoList
  """
  def add_entry(%TodoList{entries: entries, auto_id: auto_id} = todo_list, entry) do
    new_entries = Map.put(entries, auto_id, entry)

    %TodoList{todo_list | entries: new_entries, auto_id: auto_id + 1}
  end

  def update_entry(%TodoList{} = todo_list, %TodoEntry{} = new_entry) do
    update_entry(todo_list, new_entry.id, fn _ -> new_entry end)
  end

  def update_entry(%TodoList{} = todo_list, %TodoEntry{id: id}, updater_fun) do
    update_entry(todo_list, id, updater_fun)
  end

  def update_entry(%TodoList{entries: entries} = todo_list, entry_id, updater_fun) do
    case entries[entry_id] do
      nil ->
        todo_list

      old_value ->
        # Ensure the old entry is unchanged and run update function.
        new_value = updater_fun.(old_value)
        new_entries = Map.put(entries, entry_id, new_value)
        %TodoList{todo_list | entries: new_entries}
    end
  end

  @doc """
  Return all entries for a given date or an empty list
  """
  def entries(%TodoList{entries: entries}, date) do
    entries
    |> Stream.filter(fn {_, entry} -> entry.date == date end)
    |> Enum.map(fn {id, entry} -> %TodoEntry{id: id, value: entry} end)
  end
end
