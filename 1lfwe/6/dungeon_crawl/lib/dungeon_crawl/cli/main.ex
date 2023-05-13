defmodule DungeonCrawl.CLI.Main do
  alias Mix.Shell.IO, as: Shell

  def start_game do
    welcome_message()
    Shell.prompt("Press Enter to continue..")
    # difficulty_choice()
    rnd = Enum.random(1..100)
    crawl(difficulty_choice(), hero_choice(), DungeonCrawl.Room.all(), rnd)
  end

  defp welcome_message do
    Shell.info("||||||||||||||||| Dungeon Crawl ||||||||||||||||||")
    Shell.info("|| You are awake in a dungeon full of monsters. ||")
    Shell.info("|| You need to survive and find the exit.       ||")
    Shell.info("||||||||||||||||||||||||||||||||||||||||||||||||||")
  end

  defp difficulty_choice do
    DungeonCrawl.CLI.DifficultyChoice.start()
  end

  defp hero_choice do
    hero = DungeonCrawl.CLI.HeroChoice.start()
    %{hero | name: "You"}
  end

  defp crawl(difficulty, character, rooms, rnd) do
    Shell.cmd("clear")
    #Basado en difficulty dar mas probabilidad a una habitacion
    #                     aumentar ataque de los enemigos

    Shell.info(DungeonCrawl.Character.current_stats(character))

    rooms
    |> take_random_room(rnd)
    |> DungeonCrawl.CLI.RoomActionsChoice.start
    |> trigger_action(character)
    |> handle_action_result

    #Cambiar tomar una random a generar un numero random entre 1..100
    # Enum.random(1..100)
    # depende del numero me fijo en que room.probability cae (es un rango)
  end

  defp crawl(%{hit_points: 0}, _, _) do
    Shell.prompt("")
    Shell.cmd("clear")
    Shell.info("|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||")
    Shell.info("|| Unfortunately your wounds are too many to keep walking. ||")
    Shell.info("|| You fall onto the floor without strength to carry on.   ||")
    Shell.info("|||||||||||||||||||||||| GAME OVER ||||||||||||||||||||||||||")
    Shell.prompt("")
  end

  defp crawl(character, rooms, rnd) do
    Shell.info("You keep moving forward to the next room.")
    Shell.prompt("Press Enter to continue..")
    Shell.cmd("clear")

    Shell.info(DungeonCrawl.Character.current_stats(character))
    #+1 la probabilidad de que aparezca la salida y bajo a la de monstruos
    rooms
    |> take_random_room(rnd)
    |> DungeonCrawl.CLI.RoomActionsChoice.start
    |> trigger_action(character)
    |> handle_action_result

  end

  defp take_random_room(rooms, rnd) do
    Enum.find(rooms, fn room -> Enum.member?(room.probability, rnd) end)
  end

  defp trigger_action({room, action}, character) do
    Shell.cmd("clear")
    room.trigger.run(character, action)
  end

  defp handle_action_result({_, :exit}) do
    Shell.info("||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||")
    Shell.info("|| You found the exit. You won the game. Congratulations! ||")
    Shell.info("||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||")
  end

  defp handle_action_result({character, _}) do
    rnd = Enum.random(1..100)
    crawl(character, DungeonCrawl.Room.all(), rnd)
  end
end
