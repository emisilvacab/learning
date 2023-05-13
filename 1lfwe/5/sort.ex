defmodule QuickSort do
  def ascending([]), do: []
  #def ascending([a]), do: [a]
  def ascending([pivot | list]) do
    {list_less , list_greater} = Enum.split_with(list, &(&1 <= pivot))
    ascending(list_less) ++ [pivot] ++ ascending(list_greater)
    #Con [ascending(list_less) , [pivot] | ascending(list_greater)] se hace append de listas vacias
  end

  def descending([]), do: []
  def descending([pivot | list]) do
    {list_less , list_greater} = Enum.split_with(list, &(&1 <= pivot))
    descending(list_greater) ++ [pivot] ++ descending(list_less)
  end
end
