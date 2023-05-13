{age, _} = Integer.parse IO.gets("Person's age:\n")

#cond
result = cond do
  age < 0 -> "Edad invalida"
  age < 18 -> "Menor"
  true -> "Mayor"
end

IO.puts "Result: #{result.(age)}"
