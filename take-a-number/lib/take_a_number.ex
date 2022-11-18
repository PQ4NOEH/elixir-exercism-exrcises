defmodule TakeANumber do
  def start() do
    spawn(&loop/0)
  end

  defp loop(number \\ 0) do
    receive do
      {:report_state, sender_pid} ->
        send(sender_pid, number)
        loop(number)
      {:take_a_number, sender_pid} ->
        number = number + 1
        send(sender_pid, number)
        loop(number)
      :stop ->
        nil
      _ ->
        loop(number)
    end
  end
end
