defmodule Rectangle do
  def perimeter(l, w) do
    2*l + 2*w
  end
end

defmodule Present do
  def shortest_perimeter(l, w, h) do
    [{l, w}, {l, h}, {w, h}]
    |> Enum.map(fn({s1, s2}) -> Rectangle.perimeter(s1, s2) end)
    |> Enum.min
  end

  def volume(l, w, h) do
    l * w * h
  end
end

defmodule Day02b do
  def run do
    File.stream!("./day02.in.txt")
    |> Enum.reduce(0, &(calculate(&1) + &2))
  end

  defp calculate(dims) do
    [l, w, h] = parse_dims(dims)
    Present.shortest_perimeter(l, w, h) + Present.volume(l, w, h)
  end

  defp parse_dims(dims) do
    dims |> String.strip |> String.split("x") |> Enum.map(&String.to_integer/1)
  end
end

IO.puts Day02b.run
# => 3842356
