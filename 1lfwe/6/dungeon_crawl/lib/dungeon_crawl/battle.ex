defmodule DungeonCrawl.Battle do
  alias DungeonCrawl.Character
  alias Mix.Shell.IO, as: Shell

  def fight(
    char_a = %{hit_points: hit_points_a},
    char_b = %{hit_points: hit_points_b},
    _choice
  ) when hit_points_a == 0 or hit_points_b == 0, do: {char_a, char_b}
  def fight(char_a, char_b, %{id: :run}) do
    char_a_after_damage = attack(char_b, char_a)
    {char_a_after_damage, char_b}
  end
  def fight(char_a, char_b, %{id: :attack}) do
    #Se puede hacer que el primer ataque sea random quien lo da
    #50/50 o cambiar segun dificultad
    char_b_after_damage = attack(char_a, char_b)
    char_a_after_damage = attack(char_b_after_damage, char_a)
    choice = DungeonCrawl.CLI.BattleChoice.start
    fight(char_a_after_damage, char_b_after_damage, choice)
  end

  #char_a ataca a char_b
  def attack(%{hit_points: hit_points_a}, character_b)
    when hit_points_a == 0, do: character_b
  def attack(char_a, char_b) do
    damage = Enum.random(char_a.damage_range)
    #Hace damage a char_b invocando la funcion take_damage() de Character
    char_b_after_damage = Character.take_damage(char_b, damage)
    #Printea resultados de la batalla
    char_a
    |> attack_message(damage)
    |> Shell.info

    char_b_after_damage
    |> recieve_message(damage)
    |> Shell.info
    #Devuelvo al char_b atacado
    char_b_after_damage
  end

  defp attack_message(character = %{name: "You"}, damage) do
    "You attack with #{character.attack_description} " <>
    "and deal #{damage} damage."
  end
  defp attack_message(character, damage) do
    "#{character.name} attacks with " <>
    "#{character.attack_description} and " <>
    "deals #{damage} damage."
  end

  defp recieve_message(character = %{name: "You"}, damage) do
    "You recieve #{damage}. Current HP: #{character.hit_points}."
  end
  defp recieve_message(character, damage) do
    "#{character.name} recieves #{damage}. " <>
    "Current HP: #{character.hit_points}."
  end
end
