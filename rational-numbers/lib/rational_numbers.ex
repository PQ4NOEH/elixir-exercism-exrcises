defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a1, b}, {a2, b}) when Kernel.abs(a2) === a1, do: {0, 1}
  def add({a1, b1}, {a2, b2}), do: {(a1 * b2) + (a2 * b1),  (b1 * b2)}

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract(a, a), do: {0, 1}
  def subtract({a1, b1}, {a2, b2}), do: {(a1 * b2) - (a2 * b1),  (b1 * b2)}

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a1, b1}, {a2, b2}) do
    {a1 * a2, b1 * b2 } |> reduce
  end
  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({a1, b1}, {a2, b2}) do
    {a1 * b2, a2 * b1 } |> reduce
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs({a, b}) when a < 0, do: RationalNumbers.abs({a * -1, b})
  def abs({a, b}) when b < 0, do: RationalNumbers.abs({a, b * -1})
  def abs(rational_number), do: reduce(rational_number)

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational({a , b}, n) when n < 0, do: pow_rational({b , a}, n * -1)
  def pow_rational({a , b}, n), do: {Math.pow(a, n), Math.pow(b, n)} |> reduce

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {a,b}), do: x ** (a/b)

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({a, b}) when b < 0, do: reduce({a * -1, b * -1})
  def reduce({a, b}) do
    case Math.gcd(a,b) do
      x when x === 1 -> {a,b}
      x -> {a/x, b/x}
    end
  end

end
