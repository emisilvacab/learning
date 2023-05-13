# Create a function that returns Tic-Tac-Toe game winners.
# oou can represent the board with a tuple of nine elements, where each group of three
# items is a row. The return of the function should be a tuple. When we
# have a winner, the first element should be the atom :winner, and the second
# should be the plaoer. When we have no winner, the tuple should contain
# one item that is the atom :no_winner. It should work like this:
# TicTacToe.winner({
# :x, :o, :x,
# :o, :x, :o,
# :o, :o, :x
# })
# {:winner, :x}
# TicTacToe.winner({
# :x, :o, :x,
# :o, :x, :o,
# :o, :x, :o
# })
# :no_winner
defmodule TicTacToe do
  def winner({
    a,a,a,
    _,_,_,
    _,_,_
  }), do: {:winner, a}
  def winner({_,_,_,a,a,a,_,_,_}), do: {:winner, a}
  def winner({_,_,_,_,_,_,a,a,a}), do: {:winner, a}

  def winner({_,_,a,_,_,a,_,_,a}), do: {:winner, a}
  def winner({_,a,_,_,a,_,_,a,_}), do: {:winner, a}
  def winner({a,_,_,a,_,_,a,_,_}), do: {:winner, a}

  def winner({a,_,_,_,a,_,_,_,a}), do: {:winner, a}
  def winner({_,_,a,_,a,_,a,_,_}), do: {:winner, a}

  #def winner({_,_,_,_,_,_,_,_,_}), do: :no_winner
  def winner(), do: :no_winner
end

IO.inspect TicTacToe.winner({:x,:x,:x,:x,:o,:o,:o,:o,:x})#x
IO.inspect TicTacToe.winner({:x,:o,:x,:x,:o,:o,:o,:o,:x})#o
IO.puts "\n"
IO.inspect TicTacToe.winner({:o,:o,:o,:x,:x,:o,:o,:o,:x})#o
IO.inspect TicTacToe.winner({:o,:o,:x,:x,:x,:o,:o,:o,:o})#o
IO.inspect TicTacToe.winner({:x,:o,:x,:o,:o,:o,:x,:x,:o})#o
IO.puts "\n"
IO.inspect TicTacToe.winner({:x,:o,:o,:o,:x,:o,:x,:o,:o})#o
IO.inspect TicTacToe.winner({:o,:o,:x,:x,:o,:o,:x,:o,:x})#o
IO.inspect TicTacToe.winner({:o,:x,:o,:o,:o,:x,:o,:o,:x})#o
IO.puts "\n"
IO.inspect TicTacToe.winner({:x,:o,:o,:o,:x,:o,:o,:o,:x})#x
IO.inspect TicTacToe.winner({:x,:x,:o,:x,:o,:x,:o,:x,:x})#o
IO.puts "\n"
IO.inspect TicTacToe.winner({:x,:o,:x,:o,:x,:o,:o,:x,:o})#:no_winner
