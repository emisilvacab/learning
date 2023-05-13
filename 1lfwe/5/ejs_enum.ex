medals = [
  %{medal: :gold, player: "Anna"},
  %{medal: :silver, player: "Joe"},
  %{medal: :gold, player: "Zoe"},
  %{medal: :bronze, player: "Anna"},
  %{medal: :silver, player: "Anderson"},
  %{medal: :silver, player: "Peter"}
]

IO.inspect Enum.group_by(medals, &(&1.medal), &(&1.player))

IO.inspect for a <- [1,2], b <- [3,4], do: {a,b}
[{1, 3}, {1, 4}, {2, 3}, {2, 4}]
