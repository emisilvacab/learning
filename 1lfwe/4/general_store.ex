defmodule GeneralStore do
  def test_data do
    [
      %{title: "Longsword", price: 50, magic: false},
      %{title: "Healing Potion", price: 60, magic: true},
      %{title: "Rope", price: 10, magic: false},
      %{title: "Dragon's Spear", price: 100, magic: true},
    ]
  end
  def filter_items([], _), do: []
  def filter_items([item = %{magic: true} | incoming_items], true), do: [item | filter_items(incoming_items, true)]
  def filter_items([item = %{magic: false} | incoming_items], false), do: [item | filter_items(incoming_items, false)]
  def filter_items([_item | incoming_items], magic), do: filter_items(incoming_items, magic)
end
