defmodule Test do
  def mult_2() do
    num = "Number:" <> "\n"
      |> IO.gets
      |> Integer.parse

      case num do
      :error ->
        IO.puts "Invalid Number"
      {number,_} ->
        IO.puts "Number mult by 2:\n#{number*2}"
    end
  end
end
