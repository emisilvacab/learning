# Create an Elixir script where users can type their salary and see the
# income tax and the net wage. You can use the module from the previous
# exercise, but this script should parse the user input and display a message
# when users type something that is not a valid number.
defmodule Finances do
  def income_tax(salary) when salary <= 2000, do: 0
  def income_tax(salary) when salary <= 3000, do: salary*0.05
  def income_tax(salary) when salary <= 6000, do: salary*0.10
  def income_tax(salary), do: salary*0.15

  def net_wage(salary) when salary <= 2000, do: salary
  def net_wage(salary) when salary <= 3000, do: salary*0.95
  def net_wage(salary) when salary <= 6000, do: salary*0.90
  def net_wage(salary), do: salary*0.85
end

salary = IO.gets("Person's salary:\n")

result = case Integer.parse(salary) do
  :error ->
    "Invalid salary: #{salary}"
  {salary, _} when salary >= 0 ->
    "Income tax: #{round(Finances.income_tax(salary))}" <> "\n" <> "Net wage: #{round(Finances.net_wage(salary))}"
end

IO.puts result

# input = IO.gets "Your salary:\n"

# case Float.parse(input) do
#   :error -> IO.puts "Invalid salary: #{input}"
#   {salary, _} ->
#     tax = IncomeTax.total(salary)
#     IO.puts "Net wage: #{salary - tax} - Income tax: #{tax}"
# end
