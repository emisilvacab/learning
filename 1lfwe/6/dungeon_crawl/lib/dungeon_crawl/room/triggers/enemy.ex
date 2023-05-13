defmodule DungeonCrawl.Room.Triggers.Enemy do
  @behaviour DungeonCrawl.Room.Trigger

  alias Mix.Shell.IO, as: Shell

  def run(character, action) do
    enemy = Enum.random(DungeonCrawl.Enemies.all)

    Shell.info(enemy.description)
    Shell.info("The enemy #{enemy.name} wants to fight.")
    choice = DungeonCrawl.CLI.BattleChoice.start
    {updated_char, _enemy} = DungeonCrawl.Battle.fight(character, enemy, choice)
    {updated_char, :forward}
  end

end
