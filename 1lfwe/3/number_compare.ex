defmodule NumberCompare do
#---------------------------------------------
#   def greater(num_a, num_b \\ 0) do
#   #Si no hay segundo valor se fija que el primero sea mayor o igual a 0
#     check(num_a >= num_b, num_a, num_b)
#   end
#   defp check(true, num_a, _), do: num_a
#   defp check(false, _, num_b), do: num_b
#---------------------------------------------
#Asi queda mejor (se usa cuando la condicion del when es trivial):
  def greater(first_num, second_num \\ 0)#default values van en Header
  def greater(first_num, second_num) when first_num >= second_num, do: first_num
  def greater(_, second_number), do: second_number

  # def greater_2(first_num) when first_num <= 0 do: 0#default values van en Header
  # def greater_2(first_num, second_num) when first_num >= second_num, do: first_num
  # def greater_2(_, second_number), do: second_number

  def greater_3(first_num) when first_num <= 0 do: 0
  def greater_3(num_1), do: num_1
  def greater_3(num_1, num_2) do
    if num_1 >= num 2 do
      num_1
    end
  end
#---------------------
#Version anonima
#number_compare = fn
#  number, other_number when number >= other_number -> number
#  _, other_number -> other_number
#end
end
IO.puts NumberCompare.greater(3,1)#3
IO.puts NumberCompare.greater(1,3)#3
IO.puts NumberCompare.greater(4,4)#4
IO.puts NumberCompare.greater(-3,-4)#-3
IO.puts NumberCompare.greater(-3)#Devuelve 0 (segundo valor default)
IO.puts NumberCompare.greater(3)#Devuelve 3 (Ya que es mayor a igual a 0)
