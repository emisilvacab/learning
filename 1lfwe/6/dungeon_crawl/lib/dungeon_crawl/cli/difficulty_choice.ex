defmodule DungeonCrawl.CLI.DifficultyChoice do
  alias Mix.Shell.IO, as: Shell
  import DungeonCrawl.CLI.BaseCommands

  def start do
    Shell.cmd("clear")#para tirar un clear en consola
    Shell.info("Start by choosing the game difficulty:")

    # difficulties  = ~w(Hard Normal Easy)
    # #heroes = DungeonCrawl.Heroes.all()
    # find_difficulty_by_index = &Enum.at(difficulties, &1)

    # difficulties
    # |> display_options
    # |> generate_question
    # |> Shell.prompt
    # |> parse_answer
    # |> find_difficulty_by_index.()
    # |> confirm_difficulty
    ~w(Hard Normal Easy)
    |> ask_for_option
    |> confirm_difficulty

  end

  defp confirm_difficulty(chosen_difficulty) do
    Shell.cmd("clear")
    #Shell.info(chosen_difficulty.description)
    if Shell.yes?("Confirm?"), do: chosen_difficulty, else: start()
  end

  # defp apply_difficulty("Hard") do

  # end
  # defp apply_difficulty("Normal") do

  # end
  # defp apply_difficulty("Easy") do

  # end
end
