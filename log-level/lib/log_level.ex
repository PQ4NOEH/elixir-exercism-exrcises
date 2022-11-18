defmodule LogLevel do
  @legacy_log_levels %{ 1 => :debug, 2 => :info, 3 => :warning, 4 => :error}
  @log_levels Map.merge(%{ 0 => :trace, 5 => :fatal}, @legacy_log_levels)

  @alert_teams %{4 => :ops}
  @legacy_alert_teams Map.merge(%{0 => :dev1, 5 => :dev1, 6=> :dev1}, @alert_teams)
  @no_legacy_alert_teams Map.merge(%{ 6 => :dev2, 5 => :ops}, @alert_teams)

  def to_label(level, legacy?) do
    cond do
      legacy? -> log_Label(@legacy_log_levels[level])
      legacy? === false -> log_Label(@log_levels[level])
    end
  end

  defp log_Label(nil), do: :unknown
  defp log_Label(label), do: label

  def alert_recipient(level, legacy?) do
    cond do
      legacy? -> @legacy_alert_teams[level]
      legacy? === false -> @no_legacy_alert_teams[level]
    end
  end
end
