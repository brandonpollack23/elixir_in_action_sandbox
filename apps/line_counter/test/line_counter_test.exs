defmodule LineCounterTest do
  use ExUnit.Case
  doctest LineCounter

  test "has 8 lines when looking at the test file" do
    assert LineCounter.count("./test/known_line_count.txt") === 10
  end

  test "returns error for unknown file" do
    assert {:error, _} = LineCounter.count("/fizzle/bizzle/bop")
  end
end
