defmodule BoutiqueSuggestions do
  @maximum_default_price 100

  def get_combinations(tops, bottoms, options \\ []) do
    for t <- tops,
        b <- bottoms,
        different_base_color?(t, b),
        within_budget?(t, b, options[:maximum_price]) do
      {t, b}
    end
  end

  defp different_base_color?(top, bottom), do: top.base_color != bottom.base_color

  defp within_budget?(top, bottom, nil), do: within_budget?(top, bottom, @maximum_default_price)
  defp within_budget?(top, bottom, max_price), do: top.price + bottom.price <  max_price

end
