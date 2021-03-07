defmodule TodoList.CsvImporter do
  @moduledoc """
  import from a simple csv file assuming that the file is always there and
  there are no commas in any fields
  """

  def import(path) do
    path
    |> File.stream!()
    |> Stream.map(&String.split(&1, ~r/,/))
    |> Stream.map(fn [date, title] -> %{date: date, title: remove_newline(title)} end)
    |> Enum.to_list()
  end

  def remove_newline(str), do: String.replace(str, "\n", "")
end
