defmodule LucasNumbers do
  @moduledoc """
  Lucas numbers are an infinite sequence of numbers which build progressively
  which hold a strong correlation to the golden ratio (φ or ϕ)

  E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...
  """

  def generate(count)
    when not is_number(count)
    when count < 1 do
    raise ArgumentError, message: "count must be specified as an integer >= 1"
  end

  def generate(count, elements\\[2,1])
    when is_number(count)
    when count >= 1 do
    case count do
      2 -> elements
      1 -> Enum.take(elements, 1)
      _ ->
        new_value = Enum.take(elements, -2) |> Enum.sum()
        generate(count-1, elements ++ [new_value])
    end
  end
end
