user_input = IO.gets "Write your ability score: "
# version 1
# {ability_score, _} = Integer.parse(user_input)
# ability_modifier = (ability_score - 10) / 2
# IO.puts "Your ability modifier is #{ability_modifier}"
#---------------------------------------------------
# version 2 usando case
# case Integer.parse(user_input) do
#   :error -> IO.puts "Invalid ability score: #{user_input}"
#   {ability_score, _} ->
#     ability_modifier = (ability_score - 10) / 2
#     IO.puts "Your ability modifier is #{ability_modifier}"
# end
#---------------------------------------------------
# version 3 usando un unico IO.puts
# result = case Integer.parse(user_input) do
#   :error ->
#     "Invalid ability score: #{user_input}"
#   {ability_score, _} ->
#     ability_modifier = (ability_score - 10) / 2
#     "Your ability modifier is #{ability_modifier}"
# end

#IO.puts result
# version 4 se fija que ability_score sea mayor que 0 en otro caso tira error
result = case Integer.parse(user_input) do
  :error ->
    "Invalid ability score: #{user_input}"
  {ability_score, _} when ability_score >= 0 ->
    ability_modifier = (ability_score - 10) / 2
    "Your ability modifier is #{ability_modifier}"
end
IO.puts result
