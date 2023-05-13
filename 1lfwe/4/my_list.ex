defmodule MyList do
  def max([]), do: nil
  def max([a]), do: a
  def max([first, second | tail]) when first >= second, do: max([first | tail])
  def max([_first, second | tail]), do: max([second | tail])

  def min([]), do: nil
  def min([a]), do: a
  def min([first, second | tail]) when first >= second, do: min([second | tail])
  def min([first, _second | tail]), do: min([first | tail])
end
