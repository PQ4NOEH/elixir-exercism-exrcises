# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do

  @not_found_plot {:not_found, "plot is unregistered"}

  def start(opts\\[]), do: Agent.start(fn -> [id: 0, plots: []] end, opts)

  def list_registrations(pid), do: Agent.get(pid, fn state -> state[:plots] end)

  def register(pid, register_to) do
    new_id = Agent.get(pid, fn state -> state[:id] end) + 1
    new_plot = %Plot{plot_id: new_id, registered_to: register_to}
    Agent.get_and_update(pid,fn state -> {
      new_plot,
      [id: new_id, plots: [new_plot | state[:plots]]]}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn state -> [
      id: state[:id],
      plots: Enum.filter(state[:plots], &(&1.plot_id !== plot_id))]
    end)
  end

  def get_registration(pid, plot_id) do
    pid
    |> list_registrations
    |> Enum.find(@not_found_plot, fn plot -> plot.plot_id === plot_id end)
  end
end
