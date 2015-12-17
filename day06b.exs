defmodule Grid do
  defstruct lights: %{}, brightness: 0

  def handle_instruction(grid, {func, {x1, y1}, {x2, y2}}) do
    IO.puts("#{func} {#{x1},#{y1}} to {#{x2},#{y2}}")
    coordinates = for x <- x1..x2, y <- y1..y2, do: {x,y}
    Enum.reduce(coordinates, grid, &change_one(&2, &1, func))
  end

  def get_brightness(grid) do
    grid.brightness
  end

  defp change_one(grid, coord, func) do
    current_light = Map.get(grid.lights, coord, 0)
    current_brightness = grid.brightness
    {new_light, brightness_delta} = Light.change(current_light, func)
    lights = Map.put(grid.lights, coord, new_light)
    new_brightness = current_brightness + brightness_delta
    %Grid{lights: lights, brightness: new_brightness}
  end
end

defmodule Light do
  def change(n, "turn on"),  do: {n+1,  1}
  def change(0, "turn off"), do: {0,    0}
  def change(n, "turn off"), do: {n-1, -1}
  def change(n, "toggle"),   do: {n+2,  2}
end

defmodule Day06b do
  def run do
    File.stream!("./day06.in.txt")
    |> Enum.map(&parse_line(&1))
    |> Enum.reduce(%Grid{}, &Grid.handle_instruction(&2, &1))
    |> Grid.get_brightness
    |> IO.puts
  end

  defp parse_line(line) do
    c= ~r{(?<func>toggle|turn (?:on|off)) (?<x1>\d+),(?<y1>\d+) through (?<x2>\d+),(?<y2>\d+)}
      |> Regex.named_captures(line, capture: :all_but_first)

    func = c["func"]
    coord1 = {String.to_integer(c["x1"]), String.to_integer(c["y1"])}
    coord2 = {String.to_integer(c["x2"]), String.to_integer(c["y2"])}

    {func, coord1, coord2}
  end
end

Day06b.run
# => 17836115
