# Create a function that calculates income tax following these rules: a salary
# equal or below $2,000 pays no tax; below or equal to $3,000 pays 5%; below
# or equal to $6,000 pays 10%; everything higher than $6,000 pays 15%.
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
