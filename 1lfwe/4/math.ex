defmodule Math do
  def sum([]), do: 0
  def sum([x | xs]), do: x + sum(xs)
end
