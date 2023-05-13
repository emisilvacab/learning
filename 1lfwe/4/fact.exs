#Recursion anonymous functions

fact = fn me ->
  fn
    0 -> 1
    n when n > 0 -> n * me.(me).(n-1)
  end
end

factorial = fact.(fact)
IO.puts factorial.(3)
