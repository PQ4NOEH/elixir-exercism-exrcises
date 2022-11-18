defmodule KitchenCalculator do
  @conversion_measure_table %{
    :milliliter => 1,
    :cup => 240,
    :fluid_ounce => 30,
    :teaspoon => 5,
    :tablespoon => 15
  }

  def get_volume({_, volume}), do: volume

  def to_milliliter(source), do: convert(source, :milliliter)

  def from_milliliter(source, target), do: convert(source, target)

  def convert({source_unit, amount}, target_unit) do
    source_volumen = @conversion_measure_table[source_unit]
    target_volumen = @conversion_measure_table[target_unit]
    convert(target_unit, amount, target_volumen, source_volumen)
  end
  defp convert(target_unit, amount, target_volumen, source_volumen) when target_volumen > source_volumen do
    conversion_factor = trunc(target_volumen / source_volumen)
    {target_unit, amount / conversion_factor}
  end
  defp convert(target_unit, amount, target_volumen, source_volumen) do
    conversion_factor = trunc(source_volumen / target_volumen)
    {target_unit, amount * conversion_factor}
  end
end
