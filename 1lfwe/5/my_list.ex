defmodule MyList do

  def each([], _function), do: nil
  def each([head | tail], function) do
    function.(head)
    each(tail, function)
  end

  def map([], _function), do: []
  def map([head | tail], function) do
    [function.(head) | map(tail, function)]
  end

  def reduce([], acc, _function), do: acc
  def reduce([head | tail], acc, function) do
    reduce(tail, function.(head, acc), function)
  end

  def filter([], _function), do: []
  def filter([head | tail], function) do
    if function.(head) do
      [head | filter(tail, function)]
    else
      filter(tail, function)
    end
  end

end

#EACH
IO.puts "############ EACH ############"
items_a = ["dogs", "cats", "flowers"]
MyList.each(items_a, fn item -> IO.puts String.upcase(item) end)

#MAP
IO.puts "############ MAP ############"
items = [%{price: 165.0, title: "Edwin's Longsword"},
%{price: 66.0, title: "Healing Potion"},
%{price: 33.0, title: "Edwin's Rope"},
%{price: 110.00000000000001, title: "Dragon's Spear"}]
IO.puts "---------Antes de aumentar precio---------"
IO.inspect items

#increase_price = fn item -> %{price: item.price*1.1, title: item.title} end
increase_price = fn item -> update_in(item.price, &(&1 * 1.1)) end
items_increased = MyList.map(items, increase_price)

IO.puts "---------Precios aumentados---------"
IO.inspect items_increased

#REDUCE
IO.puts "############ REDUCE ############"
sum_price = fn item, sum -> item.price + sum end
IO.puts "Precio total: "
IO.puts MyList.reduce(items, 0, sum_price)
IO.puts "Precio total luego de aumentar: "
IO.puts MyList.reduce(items_increased, 0, sum_price)

#FILTER
IO.puts "############ FILTER ############"
IO.puts "Items más caros que 70: "
IO.inspect MyList.filter(items, fn item -> item.price < 70 end)
