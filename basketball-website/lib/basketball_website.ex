defmodule BasketballWebsite do
  @moduledoc """
  Extract data from a series of nested maps to facilitate rapid developmen
  """

  @doc """
  Extract data from a variable of nested maps:
  1. data: a nested map structure with data about the basketball team.
  2. path: a string consisting of period-delimited keys to obtain the value associated with the last key

  ## Examples
    iex> BasketballWebsite.extract_from_path(%{"trainer"=> %{"name" => "Carlo Ancelotti", "age"=> 63} }, "trainer.name")
    "Carlo Ancelotti"


  """
  @spec extract_from_path(map(), String.t()) :: any()
  def extract_from_path(data, path), do: extract_from_map(data, String.split(path, "."))

  @spec extract_from_map(map(), list(String.t())) :: any()
  defp extract_from_map(data, []), do: data
  defp extract_from_map(data, [h|t]), do: extract_from_map(data[h], t)

  @doc """
  Extract data from a variable of nested maps:
  1. data: a nested map structure with data about the basketball team.
  2. path: a string consisting of period-delimited keys to obtain the value associated with the last key

  ## Examples
    iex> BasketballWebsite.get_in_path(%{"trainer"=> %{"name" => "Carlo Ancelotti", "age"=> 63} }, "trainer.name")
    "Carlo Ancelotti"


  """
  @spec get_in_path(map(), String.t()) :: any()
  def get_in_path(data, path), do: get_in(data, String.split(path, "."))
end
