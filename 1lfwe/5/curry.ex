#add = fn x, y -> x + y end

# add = fn x ->
#   fn y -> x + y end
# end

defmodule Curry do

  def curry(fun) do
    {_, arity} = : :erlang.fun_info(fun, :arity)
    curry(fun, arity, [])
  end

  def curry(fun, 0, arguments) do
    apply(fun, Enum.reverse arguments)
  end

  def curry(fun, arity, arguments) do
    fn arg -> curry(fun, arity - 1, [arg | arguments]) end
  end

end
