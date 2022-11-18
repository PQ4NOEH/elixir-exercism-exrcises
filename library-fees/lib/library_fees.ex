defmodule LibraryFees do
  @moduledoc """
  Automatically calculate library late fees
  """

  @noon 12
  @first_day_of_week 1
  @first_day_of_week_offer 0.50
  @days_to_return_before_noon 28
  @days_to_return_after_noon 29

  @doc """
  Converts an ISO8601 datetime string to a NaiveDateTime struct
  """
  @spec datetime_from_string(String.t()) :: NaiveDateTime.t()
  def datetime_from_string(string), do: NaiveDateTime.from_iso8601!(string)

  @doc """
  Determine if a book was checked out before noon
  """
  @spec before_noon?(NaiveDateTime.t()) :: boolean()
  def before_noon?(datetime), do: datetime.hour < @noon


  @doc """
  Based on the checkout datetime, calculate the return date
  """
  @spec return_date(NaiveDateTime.t()) :: Date.t()
  def return_date(checkout_datetime) do
    if before_noon?(checkout_datetime) do
      Date.add(checkout_datetime, @days_to_return_before_noon)
    else
      Date.add(checkout_datetime, @days_to_return_after_noon)
    end
  end

  @doc """
  Determine how late the return of the book was
  """
  @spec days_late(NaiveDateTime.t(), NaiveDateTime.t()) :: integer()
  def days_late(planned_return_date, actual_return_datetime) do
    case Date.diff(actual_return_datetime, planned_return_date) do
      x when x < 0 -> 0
      x -> x
    end
  end


  @doc """
  Determine if the book was returned on a Monday
  """
  @spec monday?(NaiveDateTime.t() | Date.t()) :: boolean()
  def monday?(date),do: Date.day_of_week(date) === @first_day_of_week

  @doc """
  Calculate the late fee
  """
  @spec calculate_late_fee(NaiveDateTime.t(), NaiveDateTime.t(), integer) :: integer
  def calculate_late_fee(checkout, return, rate) do
    checkout_datetime = datetime_from_string(checkout)
    return_datetime = datetime_from_string(return)
    real_rate = if monday?(return_datetime) do rate * @first_day_of_week_offer else rate end

    return_date(checkout_datetime)
    |> days_late(return_datetime)
    |> Kernel.*(real_rate)
    |> floor
  end
end
