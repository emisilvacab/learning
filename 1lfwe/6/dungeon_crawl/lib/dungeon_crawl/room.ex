defmodule DungeonCrawl.Room do
  alias DungeonCrawl.Room
  alias DungeonCrawl.Room.Triggers

  import DungeonCrawl.Room.Action

  defstruct description: nil, actions: [], trigger: nil, probability: nil

  def all, do: [
    %Room{
      description: "You can see the light of day. You found the exit!",
      actions: [forward()],
      trigger: Triggers.Exit,
      probability: 6..10
    },
    %Room{
       description: "You can see an enemy blocking your path.",
       actions: [attack(), run()],
       trigger: Triggers.Enemy,
       probability: 11..100
    },
    %Room{
      description: "You can see some healing potions.",
      actions: [forward()],
      trigger: Triggers.Enemy,
      probability: 1..5
   },
#    %Room{
#     description: "You found a quiet place with a BED and a TV?!!",
#     actions: [forward(), rest()],
#     trigger: Triggers.Rest,
#     probability: 1
#  },
  ]
end
