defmodule TailRecurTest do
  @moduledoc """
  odd/even test with tail recursion to see if its eliminated
  """
  def is_even(0), do: true
  def is_even(1), do: false

  def is_even(x) when is_number(x) do
    IO.puts(stack_length())
    is_odd(x - 1)
  end

  def is_odd(1), do: true
  def is_odd(0), do: false

  def is_odd(x) when is_number(x) do
    IO.puts(stack_length())
    is_even(x - 1)
  end

  def one(x) do
    IO.puts(stack_length())
    two(x + 1)
  end

  def two(x) do
    IO.puts(stack_length())
    three(x + 1)
  end

  def three(x) do
    IO.puts(stack_length())
    four(x + 1)
  end

  def four(_) do
    IO.puts(stack_length())
  end

  def not_tail_sum(0), do: 0

  def not_tail_sum(x) do
    IO.puts(stack_length())
    1 + not_tail_sum(x - 1)
  end

  def list_len(ls) do
    do_list_len(ls, 0)
  end

  defp do_list_len([], x), do: x

  defp do_list_len([_ | tail], x) do
    do_list_len(tail, x + 1)
  end

  defp stack_length do
    Process.info(self(), :stack_size) |> elem(1)
  end
end
