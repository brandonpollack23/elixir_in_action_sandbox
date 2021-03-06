defmodule TailRecurTestTest do
  use ExUnit.Case
  doctest TailRecurTest

  test "greets the world" do
    assert TailRecurTest.hello() == :world
  end
end
