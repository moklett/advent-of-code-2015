defmodule Day05a do
  @vowels ["a", "e", "i", "o", "u"]
  @bad_strings_regex ~r/ab|cd|pq|xy/

  def run do
    File.stream!("./day05.in.txt")
    |> Enum.map(&Task.async(fn -> nice?(&1) end))
    |> Enum.map(&Task.await/1)
    |> Enum.filter(&(&1))
    |> Enum.count
  end

  defp nice?(word) do
    three_vowels?(word) && double_letters?(word) && !contains_bad_string?(word)
  end

  def three_vowels?(word) do
    word
    |> String.codepoints
    |> Enum.filter(&Enum.member?(@vowels, &1))
    |> Enum.count
    |> Kernel.>=(3)
  end

  defp double_letters?([x | [x | _]]), do: true
  defp double_letters?([_ | y]),       do: double_letters?(y)
  defp double_letters?([]),            do: false
  defp double_letters?(word),          do: double_letters?(String.codepoints(word))

  defp contains_bad_string?(word) do
    word =~ @bad_strings_regex
  end
end

IO.inspect Day05a.run
