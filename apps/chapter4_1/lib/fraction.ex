defmodule Fraction do
  @moduledoc """
  Fraction example from chapter 4.1
  """
  defstruct a: nil, b: nil

  @spec new(number(), number()) :: %Fraction{}
  def new(a, b) do
    %Fraction{a: a, b: b}
  end

  def value(%Fraction{a: a, b: b}) do
    a / b
  end

  def add(%Fraction{a: a1, b: b1}, %Fraction{a: a2, b: b2}) do
    new(a1 * b2 + a2 * b1, b2 * b1)
  end

  def normalize(fraction) do
    do_normalize(fraction, fraction.a)
  end

  def do_normalize(fract, factor) when factor == 1 do
    fract
  end

  def do_normalize(fract = %Fraction{a: a, b: b}, factor) do
    if Integer.mod(a, factor) == 0 && Integer.mod(b, factor) == 0 do
      next = %Fraction{a: trunc(a / factor), b: trunc(b / factor)}
      do_normalize(next, next.a)
    else
      do_normalize(fract, factor - 1)
    end
  end

  defimpl Inspect, for: Fraction do
    import Inspect.Algebra

    def inspect(fract, opts) do
      concat(["%Fraction< ", to_doc(fract.a, opts), " / ", to_doc(fract.b, opts), " >"])
    end
  end
end
