defmodule HigherOrderFunctions do
  def compose(f, g) do
    fn arg -> f.(g.(arg)) end
  end
end

#first_letter_and_upcase = HigherOrderFunctions.compose(&String.upcase/1, &String.first/1)
#IO.puts first_letter_and_upcase.("hola")#H

# ===========================================
first_letter_and_upcase = &(&1 |> String.first |> String.upcase) #&1 para tomar el primer parámetro (único en este caso)
IO.puts first_letter_and_upcase.("hola")#H
