defmodule PlateSlate.OrderingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PlateSlate.Ordering` context.
  """

  @doc """
  Generate a order.
  """
  def order_fixture(attrs \\ %{}) do
    {:ok, order} =
      attrs
      |> Enum.into(%{
        customer_number: 42,
        items: %{},
        ordered_at: ~U[2023-07-05 18:30:00Z],
        state: "some state"
      })
      |> PlateSlate.Ordering.create_order()

    order
  end
end
