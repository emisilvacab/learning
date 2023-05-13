defmodule Sum do
  def up_to(0), do: 0
  def up_to(n), do: n + up_to(n-1)

  def tr_up_to(n), do: tr(n, 0)
  defp tr(0, acc), do: acc
  defp tr(n, acc), do: tr(n - 1, acc + n)
end
