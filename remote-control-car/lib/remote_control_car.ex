defmodule RemoteControlCar do
 @moduledoc """
 Playing around with a remote controlled car, which you've finally saved enough money for to buy.
 """
  @enforce_keys [:nickname]
  defstruct [
    :nickname,
    battery_percentage: 100,
    distance_driven_in_meters: 0
  ]


  @doc """
  brand-new remote controlled car struct with defined nickname
  """
  def new(nickname \\ "none"), do: %RemoteControlCar{nickname: nickname}


  def display_distance(remote_car) when is_struct(remote_car, RemoteControlCar), do: "#{remote_car.distance_driven_in_meters} meters"
  def display_distance(_), do: raise FunctionClauseError, message: "remote_car argument has to be RemoteControlCar struct"

  def display_battery(remote_car) when not is_struct(remote_car, RemoteControlCar), do: display_distance(remote_car)
  def display_battery(remote_car) when remote_car.battery_percentage === 0, do: "Battery empty"
  def display_battery(remote_car), do: "Battery at #{remote_car.battery_percentage}%"

  def drive(remote_car) when not is_struct(remote_car, RemoteControlCar), do: display_distance(remote_car)
  def drive(remote_car) when remote_car.battery_percentage === 0, do: remote_car
  def drive(remote_car) do
    %{
      remote_car |
      battery_percentage: remote_car.battery_percentage - 1,
      distance_driven_in_meters: remote_car.distance_driven_in_meters + 20
    }
  end

end
