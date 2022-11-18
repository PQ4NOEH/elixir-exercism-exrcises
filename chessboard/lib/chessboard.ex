defmodule Chessboard do
  @moduledoc """
  own version of the game
  """

  @doc """
  A range of integers, from 1 to 8
  """
  @spec rank_range() :: struct()
  def rank_range, do: 1..8

  @doc """
  A range of code points, from ?A to ?H
  """
  @spec file_range() :: struct()
  def file_range, do: ?A..?H

  @doc """
  A list of integers, from 1 to 8
  """
  @spec ranks() :: list(integer())
  def ranks, do: rank_range() |> Enum.to_list

  @doc """
  A list of string, from "A" to "H"
  """
  @spec ranks() :: list(String.t())
  def files, do: file_range() |> Enum.map(&(<<&1>>))
end
