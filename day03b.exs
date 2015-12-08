defmodule World do
  # World is a Map where the keys are tuples representing {x,y} coordinates of
  # Santa's deliveries, and the values are the number of presents delivered
  # to that coordinate
  def new do
    %{{0,0} => 1}
  end

  def deliver(world, coord) do
    Map.put(world, coord, 1)
  end

  def count_deliveries(world) do
    Map.size(world)
  end
end

defmodule Location do
  def next_location({x,y}, direction) do
    case direction do
      "<" -> {x-1, y}
      ">" -> {x+1, y}
      "^" -> {x, y+1}
      "v" -> {x, y-1}
    end
  end
end

defmodule Day03b do
  def run do
    File.read!("./day03.in.txt")
    |> String.strip
    |> String.codepoints
    |> deliver(World.new, {{0,0}, {0,0}})
    |> World.count_deliveries
  end

  defp deliver([current_move | remaining_moves], world, {current_giver, next_giver}) do
    new_coord = Location.next_location(current_giver, current_move)
    world = World.deliver(world, new_coord)
    deliver(remaining_moves, world, {next_giver, new_coord})
  end

  defp deliver([], world, _) do
    world
  end
end

IO.puts Day03b.run
# => 2341
