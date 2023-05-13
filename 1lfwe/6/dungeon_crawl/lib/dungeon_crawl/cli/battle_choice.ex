defmodule DungeonCrawl.CLI.BattleChoice do
  alias Mix.Shell.IO, as: Shell
  import DungeonCrawl.CLI.BaseCommands
  import DungeonCrawl.Room.Action

  def start() do
    # battle_actions = [attack(), run()]
    # find_action_by_index = &(Enum.at(battle_actions, &1))

    # chosen_action =
    #   battle_actions
    #   |> display_options
    #   |> generate_question
    #   |> Shell.prompt
    #   |> parse_answer
    #   |> find_action_by_index.()

    #   chosen_action
    ask_for_option([attack(), run()])
  end
end
