defmodule TodoServer do
  def start do
    spawn(fn ->
      initial_state = TodoList.new()
      loop(initial_state)
    end)
  end

  def add_entry(todo_server, entry) do
    send(todo_server, {:add_entry, entry})
  end

  def update_entry(todo_server, entry) do
    send(todo_server, {:update_entry, entry})
  end

  def entries(todo_server, date) do
    send(todo_server, {:entries, self(), date})

    receive do
      {:reply, value} -> value
    after
      5000 ->
        {:error, :timeout}
    end
  end

  def get_all(todo_server) do
    send(todo_server, {:get_all, self()})

    receive do
      {:reply, value} -> value
    after
      5000 ->
        {:error, :timeout}
    end
  end

  defp loop(current_state) do
    new_state =
      receive do
        message -> process_message(current_state, message)
      end

    loop(new_state)
  end

  defp process_message(current_state, {:add_entry, entry}) do
    TodoList.add_entry(current_state, entry)
  end

  defp process_message(current_state, {:update_entry, new_entry}) do
    TodoList.update_entry(current_state, new_entry)
  end

  defp process_message(current_state, {:entries, sender, date}) do
    send(sender, {:reply, TodoList.entries(current_state, date)})
    current_state
  end

  defp process_message(current_state, {:get_all, sender}) do
    send(sender, {:reply, TodoList.get_all(current_state)})
    current_state
  end

  defp process_message(current_state, message) do
    IO.puts("Unknown message #{message}")
  end
end
