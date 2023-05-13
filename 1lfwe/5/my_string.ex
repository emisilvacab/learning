defmodule MyString do

  def capitalize_words_1(title) do
    words = String.split(title)
    capitalized_words = Enum.map(words, &String.capitalize/1)
    Enum.join(capitalized_words, " ")
  end

  def capitalize_words_2(title) do
    Enum.join(
      Enum.map(
        String.split(title),
        &String.capitalize/1
      ), " "
    )
  end

  def capitalize_words_3(title) do
    title
    |> String.split
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(" ")
  end

  def capitalize_words(title) do
    title
    |> String.split
    |> capitalize_all
    |> join_with_whitespace
  end

  def capitalize_all(words) do
    Enum.map(words, &String.capitalize/1)
  end

  def join_with_whitespace(words) do
    Enum.join(words, " ")
  end

end
