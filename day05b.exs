defmodule Day05b do
  def run do
    File.stream!("./day05.in.txt")
    |> Enum.map(&String.strip(&1))
    |> Enum.map(&Task.async(fn -> nice?(&1) end))
    |> Enum.map(&Task.await/1)
    |> Enum.filter(&(&1))
    |> Enum.count
  end

  defp nice?(word) do
    two_pairs?(word) && xyx?(word)
  end

  defp two_pairs?([x | [y | z]]) do
    # x and y overlap, so ignore y for match
    (x in z) || two_pairs?([y | z])
  end
  defp two_pairs?([_]), do: false
  defp two_pairs?([]),  do: false
  defp two_pairs?(word) do
    pairs = pairs_from_word(word)
    two_pairs?(pairs)
  end

  defp xyx?([]),   do: false
  defp xyx?([_ | rest]) when length(rest) <= 1, do: false
  defp xyx?([first | rest]) do
    [_ | [third | _]] = rest
    (first == third) || xyx?(rest)
  end
  defp xyx?(word), do: xyx?(String.codepoints(word))

  defp pairs_from_word(word) when byte_size(word) <= 1, do: []
  defp pairs_from_word(word) do
    pair = String.slice(word, 0..1)
    rest = String.slice(word, 1..-1)
    [pair | pairs_from_word(rest)]
  end
end

IO.inspect Day05b.run
