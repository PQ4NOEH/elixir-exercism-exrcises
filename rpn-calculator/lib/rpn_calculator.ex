defmodule RPNCalculator do
  def calculate!(stack, operation), do: operation.(stack)

  def calculate(stack, operation) do
    case calculate_verbose(stack, operation) do
      {:ok, _} = success -> success
      {:error, _} -> :error
    end
  end

  def calculate_verbose(stack, operation) do
    try do
      {:ok, calculate!(stack, operation)}
    rescue
      e -> {:error, Exception.message(e)}
    end

  end
end
