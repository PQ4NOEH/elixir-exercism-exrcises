defmodule BoutiqueInventory do
  @moduledoc """
  Take stock of your inventory to make sure you're ready
  """

  @doc """
  Take the inventory and return it sorted by item price, ascending

  ## Examples


      iex> BoutiqueInventory.sort_by_price([
        %{price: 65, name: "Maxi Brown Dress", quantity_by_size: %{}},
        %{price: 50, name: "Red Short Skirt", quantity_by_size: %{}},
        %{price: 50, name: "Black Short Skirt", quantity_by_size: %{}},
        %{price: 20, name: "Bamboo Socks Cats", quantity_by_size: %{}}
      ])
      [
       %{price: 20, name: "Bamboo Socks Cats", quantity_by_size: %{}},
       %{price: 50, name: "Red Short Skirt", quantity_by_size: %{}},
       %{price: 50, name: "Black Short Skirt", quantity_by_size: %{}},
       %{price: 65, name: "Maxi Brown Dress", price: 65, quantity_by_size: %{}}
     ]


  """
  @spec sort_by_price(list(map())) :: list(map())
  def sort_by_price(inventory), do: Enum.sort_by(inventory, &(&1.price))

  @doc """
  Take the inventory and return a list of items that do not have prices.

  ## EXAMPLES

      iex> BoutiqueInventory.with_missing_price([
        %{price: nil, name: "Maxi Brown Dress", quantity_by_size: %{}},
        %{price: 50, name: "Red Short Skirt", quantity_by_size: %{}},
        %{price: nil, name: "Black Short Skirt", quantity_by_size: %{}},
        %{price: 20, name: "Bamboo Socks Cats", quantity_by_size: %{}}
      ])
      [
        %{price: nil, name: "Maxi Brown Dress", quantity_by_size: %{}},
        %{price: nil, name: "Black Short Skirt", quantity_by_size: %{}}
      ]
  """
  @spec with_missing_price(list(map())) :: list(map())
  def with_missing_price(inventory), do: Enum.filter(inventory, &(&1.price === nil))

  @doc """
  Takes the inventory, the old word that you want to remove, and a new word that you want to use instead.
  It returns a list of items with updated names.

  ## EXAMPLES


        iex> BoutiqueInventory.update_names(
              [
                %{price: 40, name: "Black T-shirt", quantity_by_size: %{}},
                %{price: 70, name: "Denim Pants", quantity_by_size: %{}},
                %{price: 65, name: "Denim Skirt", quantity_by_size: %{}},
                %{price: 40, name: "Orange T-shirt", quantity_by_size: %{}}
              ],
              "T-shirt",
              "Tee"
            )
            [
              %{price: 40, name: "Black Tee", quantity_by_size: %{}},
              %{price: 70, name: "Denim Pants", quantity_by_size: %{}},
              %{price: 65, name: "Denim Skirt", quantity_by_size: %{}},
              %{price: 40, name: "Orange Tee", quantity_by_size: %{}}
            ]


  """
  @spec update_names(list(map()), String.t(), String.t()) :: list(map())
  def update_names(inventory, old_word, new_word) do
    replace_name = fn value -> String.replace(value, old_word, new_word) end
    Enum.map(
      inventory,
      &(Map.update!(&1, :name, replace_name))
    )
  end

  @doc """
  Takes a single item and a number n, and return that item with the quantity for each size increased by n

  ## EXAMPLES
      iex> BoutiqueInventory.increase_quantity(
            %{
              name: "Polka Dot Skirt",
              price: 68,
              quantity_by_size: %{s: 3, m: 5, l: 3, xl: 4}
            },
            6
          )
          %{
            name: "Polka Dot Skirt",
            price: 68,
            quantity_by_size: %{l: 9, m: 11, s: 9, xl: 10}
          }
  """
  @spec increase_quantity(map(), integer()) :: map()
  def increase_quantity(item, count) do
    update_quantity = fn quantity_by_size ->
      Map.new(quantity_by_size, fn {k, v} -> {k, v + count} end)
    end
    Map.update!(item, :quantity_by_size, update_quantity)
  end


  @doc """
  Takes a single item and return how many pieces you have in total, in any size.


  ##EXAMPLES
      iex> BoutiqueInventory.total_quantity(%{
            name: "Red Shirt",
            price: 62,
            quantity_by_size: %{s: 3, m: 6, l: 5, xl: 2}
          })
          16

  """
  def total_quantity(item) do
    Enum.reduce(item.quantity_by_size, 0, fn {_, v}, acc -> acc + v end)
  end
end
