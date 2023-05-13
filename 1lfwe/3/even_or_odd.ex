defmodule EvenOrOdd do
  require Integer
  def is_even(number) do
    #require Integer
    #you must require Integer before invoking the macro Integer.is_odd/1
    #even_or_odd.ex:6: EvenOrOdd.is_odd/1
    Integer.is_even(number)
  end
  def is_odd(number), do: Integer.is_odd(number)
end
IO.puts EvenOrOdd.is_even(3)
