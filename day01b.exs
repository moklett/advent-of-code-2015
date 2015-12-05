defmodule Day01b do
  def run do
    list = File.read!("./day01a.in.txt") |> String.codepoints
    floor = 0
    position = 0
    find_basement(list, floor, position)
  end

  defp find_basement(_, -1, position), do: position
  defp find_basement(["(" | tail], floor, position), do: find_basement(tail, floor+1, position+1)
  defp find_basement([")" | tail], floor, position), do: find_basement(tail, floor-1, position+1)
end

IO.puts Day01b.run
# => 1795
