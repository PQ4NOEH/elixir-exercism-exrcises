defmodule FreelancerRates do
  @hours_perday 8.0
  @monthly_billable_days 22

  def daily_rate(hourly_rate) do
    hourly_rate * @hours_perday
  end

  def apply_discount(before_discount, discount) do
    before_discount - ((before_discount/100)*discount)
  end

  def monthly_rate(hourly_rate, discount) do
    hourly_rate
    |> daily_rate
    |> Kernel.*(@monthly_billable_days)
    |> apply_discount(discount)
    |> Float.ceil
    |> trunc

  end

  def days_in_budget(budget, hourly_rate, discount) do
    daily_price = hourly_rate |> daily_rate |> apply_discount(discount)
    Float.floor(budget/daily_price,1)
  end
end
