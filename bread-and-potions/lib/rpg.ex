defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  defprotocol  Edible do
    @spec eat(t, RPG.Character.t()) :: {any, RPG.Character.t()}
    def eat(edible, character)
  end

  defimpl Edible, for: RPG.LoafOfBread do
    def eat(_, character) do
      {nil, %{character | health: character.health + 5}}
    end
  end

  defimpl Edible, for: RPG.ManaPotion do
    def eat(mana_potion, character) do
      {%RPG.EmptyBottle{}, %{character | mana: character.mana + mana_potion.strength}}
    end
  end

  defimpl Edible, for: RPG.Poison do
    def eat(_, character) do
      {%RPG.EmptyBottle{}, %{character | health: 0}}
    end
  end
end
