defmodule Grid do
  defstruct lights: %{}, on: 0

  def handle_instruction(grid, {func, {x1, y1}, {x2, y2}}) do
    IO.puts("Currently on: #{grid.on}")
    coordinates = for x <- x1..x2, y <- y1..y2, do: {x,y}
    Enum.reduce(coordinates, grid, &change_one(&2, &1, func))
  end

  def get_count(grid) do
    grid.on
  end

  defp change_one(grid, coord, func) do
    current_light = Map.get(grid.lights, coord, 0)
    current_count = grid.on
    {new_light, count_change} = Light.change(current_light, func)
    lights = Map.put(grid.lights, coord, new_light)
    new_count = current_count + count_change
    %Grid{lights: lights, on: new_count}
  end
end

defmodule Light do
  def change(0, "turn on"),  do: {1, 1}
  def change(1, "turn on"),  do: {1, 0}
  def change(0, "turn off"), do: {0, 0}
  def change(1, "turn off"), do: {0, -1}
  def change(0, "toggle"),   do: {1, 1}
  def change(1, "toggle"),   do: {0, -1}
end

defmodule Day06a do
  def run do
    File.stream!("./day06.in.txt")
    |> Enum.map(&parse_line(&1))
    |> Enum.reduce(%Grid{}, &Grid.handle_instruction(&2, &1))
    |> Grid.get_count
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

Day06a.run
# => 569999
