defmodule Checkout do
  def total_cost(price, tax_rate) do
    price * (tax_rate + 1)
  end
  #mult_by_2 = & 1& * 2
  #mult_by_2 = &(1& * 2)
  #mult_by_2 = fn num -> num * 2 end
end
