defmodule Day02a do
  def run do
    File.stream!("./day02.in.txt")
    |> Enum.reduce(0, &(calculate(&1) + &2))
  end

  defp calculate(dims) do
    [l, w, h] = parse_dims(dims)
    area(l, w, h) + extra(l, w, h)
  end

  defp parse_dims(dims) do
    dims |> String.strip |> String.split("x") |> Enum.map(&String.to_integer/1)
  end

  defp area(l, w, h) do
    2*l*w + 2*w*h + 2*h*l
  end

  defp extra(l, w, h) do
    Enum.min([l*w, l*h, w*h])
  end
end

IO.puts Day02a.run
# => 1606483
