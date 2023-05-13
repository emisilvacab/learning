defmodule EnchanterShop do
  def test_data do
    [
      %{title: "Longsword", price: 50, magic: false},
      %{title: "Healing Potion", price: 60, magic: true},
      %{title: "Rope", price: 10, magic: false},
      %{title: "Dragon's Spear", price: 100, magic: true},
    ]
  end
  @enchanter_name "Edwin"
  #Encanta todos los items de la lista => cambia title, price*3 y magic=true
  def enchant_for_sale([]), do: []
  # def enchant_for_sale(items) do
  #   items
  #   |> Enum.filter(fn item -> item.magic end)
  #   |> Enum.map(fn item -> update_in(item.price, &(&1 * 3)) end)
  #   |> Enum.map(fn item -> update_in(item.title, fn item -> "#{@enchanter_name}'s #{item.title}"))
  #   #|> Enum.map(fn item -> update_in(item.magic, fn item -> true))
  # end

  #Recorro dos veces items (no es eficiente)
  def enchant_for_sale(items) do
    items
    |> Enum.reject(fn item -> item.magic end)
    |> Enum.map(fn item ->
      %{
        title: "#{@enchanter_name}'s #{item.title}",
        magic: true,
        price: item.price * 3
      }
    end)
  end

  # def enchant_for_sale_filter_map(items) do
  #   items
  #   |> Enum.filter_map(fn item -> !item.magic end, fn item ->
  #     %{
  #       title: "#{@enchanter_name}'s #{item.title}",
  #       magic: true,
  #       price: item.price * 3
  #     }
  #   end)
  # end

  def enchant_for_sale_for(items) do
    for item <- items, !item.magic do
      %{
        title: "#{@enchanter_name}'s #{item.title}",
        magic: true,
        price: item.price * 3
      }
    end
  end

  #Se recorre una única vez, usamos enum.map y mediante pm filtramos los que queremos
  def enchant_for_sale_for_22(items) do
    Enum.map(items, &(enchant(&1)))
  end

  def enchant(%{magic: false} = item) do
    %{
      title: "#{@enchanter_name}'s #{item.title}",
      magic: true,
      price: item.price * 3
    }
  end

  def enchant(item), do: item
end
