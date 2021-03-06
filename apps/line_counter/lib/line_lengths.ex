defmodule LineLengths do
  @moduledoc """
  Line length related functions (EiA ch 3.4)
  """

  @spec lines_lengths!(String.t()) :: Stream.default()
  def lines_lengths!(path) do
    path
    |> File.stream!()
    |> Stream.map(&String.length/1)
  end

  def longest_line_length!(path) do
    path
    |> lines_lengths!
    |> Enum.max()
  end

  def longest_line!(path) do
    path
    |> File.stream!()
    |> Enum.reduce(
      {0, ""},
      fn x, acc ->
        length = String.length(x)

        if length > elem(acc, 0) do
          {length, x}
        else
          acc
        end
      end
    )
    |> elem(1)
  end

  def longest_line2!(path) do
    path
    |> File.stream!()
    |> Enum.max_by(&String.length/1)
  end

  def words_per_line(path) do
    path
    |> File.stream!()
    |> Enum.map(&(String.split(&1) |> length))
  end
end
