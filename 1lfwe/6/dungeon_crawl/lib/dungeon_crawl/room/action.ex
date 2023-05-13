defmodule DungeonCrawl.Room.Action do
  alias DungeonCrawl.Room.Action
  defstruct label: nil, id: nil
  @type t :: %Action{id: atom, label: String.t}

  def forward, do: %Action{id: :forward, label: "Move forward."}
  def rest, do: %Action{id: :rest, label: "Watch some Netflix and relax."}
  def search, do: %Action{id: :search, label: "Search the room."}
  def run, do: %Action{id: :run, label: "Run away."}
  def attack, do: %Action{id: :attack, label: "Attack."}
  def heal, do: %Action{id: :heal, label: "Take potion"}

  defimpl String.Chars do
    def to_string(action), do: action.label
  end

end
