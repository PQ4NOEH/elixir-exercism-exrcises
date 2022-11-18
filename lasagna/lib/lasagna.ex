defmodule Lasagna do
  @total_oven_time 40
  @preparation_time_per_layer 2

  def expected_minutes_in_oven(), do: @total_oven_time

  def remaining_minutes_in_oven(minutes_in_oven) when minutes_in_oven > @total_oven_time, do: 0
  def remaining_minutes_in_oven(minutes_in_oven), do: expected_minutes_in_oven() - minutes_in_oven

  def preparation_time_in_minutes(layers), do: layers * @preparation_time_per_layer

  def total_time_in_minutes(layers, minutes_in_oven) do
    minutes_in_oven + preparation_time_in_minutes(layers)
  end

  def alarm(), do: "Ding!"
end
