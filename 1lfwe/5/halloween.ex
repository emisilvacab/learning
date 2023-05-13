defmodule Halloween do
  def give_candy(kids) do
    ~w(chocolate jelly mint)#=~ ["chocolate", "jelly", "mint"]
    |> Stream.cycle()#=~Creates a stream that cycles through the given enumerable, infinitely.
    |> Enum.zip(kids)#=~Genera lista de duplas con elementos de dos enums, termina cuando llega al final de algun enum
  end
end
