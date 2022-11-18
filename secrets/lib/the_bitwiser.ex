
# defmodule TheBitwiser do
#   use Bitwise
#   @doc """
#     Negates the number

#     ## Examples
#       iex> TheBitwiser.negate(-5)
#       5
#   """
#   def negate(number), do: bnot(number) + 1

#    @doc """
#     and operator

#     ## Examples
#       iex> TheBitwiser.and_operator(6,1)
#       0
#   """
#   def and_operator(a, b) do
#     band(a,b)
#   end

#    @doc """
#     or operator

#     ## Examples
#       iex> TheBitwiser.or_operator(5,3)
#       7
#   """
#   def or_operator(a,b), do: bor(a, b)

#    @doc """
#     xor operator

#     ## Examples
#       iex> TheBitwiser.xor_operator(2,10)
#       8
#   """
#   def xor_operator(a,b), do: bxor(a, b)
# end
