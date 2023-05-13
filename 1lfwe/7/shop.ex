defmodule Shop do

  def ask_number(message) do
    message <> "\n"
      |> IO.gets
      |> Integer.parse
  end
#case ----------------------------------------------------------------
  def checkout_1(price) do
    case ask_number("Quantity?") do
      :error -> IO.puts("Invalid number")
      {quantity, _} -> quantity * price
    end
  end

  def checkout_2() do
    case ask_number("Quantity?") do
      :error ->
        IO.puts "Invalid number"
      {quantity,_} ->
        case ask_number("Price?") do
          :error ->
            IO.puts("Invalid Number")
          {price,_} ->
            quantity * price
        end
    end
  end
#pm -------------------------------------------------------------------------
  def checkout_3() do
    quantity = ask_number("Quantity?")
    price = ask_number("Price?")
    calculate(quantity, price)
  end

  def calculate(:error, _), do: IO.puts("Quantity is not a number")
  def calculate(_, :error), do: IO.puts("Price is not a number")
  def calculate({quantity,_}, {price,_}), do: quantity * price
#try Rescue ------------------------------------------------------------------
  def checkout_tr() do
    try do
      {quantity,_} = ask_number("Quantity?")
      {price,_} = ask_number("Price?")
      quantity * price
    rescue
      MatchError -> "Invalid number"
    end
  end
#with ------------------------------------------------------------------
  def checkout_w1() do
    result =
      with {quantity,_} <- ask_number("Quantity?"),
        {price,_} <- ask_number("Price?"),
         do: quantity * price
      if result == :error, do: IO.puts("Invalid number"), else: result
  end

  def checkout_w2() do
    with {quantity,_} <- ask_number("Quantity?"),
         {price,_} <- ask_number("Price?") do
      quantity * price
    else
      :error ->
        IO.puts "Invalid number"
    end
  end
end
