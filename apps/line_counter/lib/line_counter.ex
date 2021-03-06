defmodule LineCounter do
  @moduledoc """
  Counts lines in a file, doing this for exersize in Elixir in Action
  """
  @doc """
  Counts the number of lines in a file.
  """
  @spec count(String.t()) :: non_neg_integer() | {:error, File.posix()}
  def count(path) do
    File.read(path)
    |> lines_num
  end

  defp lines_num({:ok, contents}) do
    contents
    |> String.split("\n")
    |> length()
  end

  defp lines_num(error), do: error
end
