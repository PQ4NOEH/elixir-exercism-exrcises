defmodule DNA do
  @moduledoc """
  This module has function to decode and encode charlist
  """

  @encode_map %{
    ?\s  => 0b0000,
    ?A => 0b0001,
    ?C => 0b0010,
    ?G => 0b0100,
    ?T => 0b1000
  }

  @decode_map %{
    0b0000 => ?\s,
    0b0001 => ?A,
    0b0010 => ?C,
    0b0100 => ?G,
    0b1000 => ?T
  }

  @doc """
  Encodes a one of the following code points ' ACGT' in a 4 bits bitstring
  """
  @spec encode_nucleotide(charlist)::bitstring
  def encode_nucleotide(code_point), do: @encode_map[code_point]

  @doc """
  Encodes a charlist containing valid codepoints ' ACGT' in a bitstring
  """
  @spec encode(charlist)::bitstring
  def encode(codes), do: do_encode(codes, <<>>)

  @doc """
  """
  @spec do_encode(charlist, bitstring) :: bitstring
  defp do_encode([], result), do: result
  defp do_encode([h|t], result) do
    do_encode(t, <<result::bitstring, encode_nucleotide(h)::4>>)
  end

  @doc """
  Decodes a single 4 bits bitstring into a single character charlist
  """
  @spec decode_nucleotide(bitstring)::charlist
  def decode_nucleotide(encoded_code), do:  @decode_map[encoded_code]

  @doc """
  Deodes a bitstring to a charlist
  """
  @spec decode(bitstring)::charlist
  def decode(<<>>), do: []
  def decode(<<head::4, rest :: bitstring>>) do
   [decode_nucleotide(head) | decode(rest)]
  end
end
