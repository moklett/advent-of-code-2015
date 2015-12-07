defmodule SantaGrid do
  defstruct history: %{{0,0} => 1}, location: {0,0}

  def deliver(grid, coord) do
    %{grid | history: Map.put(grid.history, coord, Map.get(grid.history, coord, 0) + 1), location: coord}
  end

  def move_and_deliver(grid, movement) do
    deliver(grid, Location.next(grid.location, movement))
  end

  def count_deliveries(grid) do
    Map.size(grid.history)
  end
end

defmodule Location do
  def next({x,y}, movement) do
    case movement do
      "<" -> {x-1, y}
      ">" -> {x+1, y}
      "^" -> {x, y+1}
      "v" -> {x, y-1}
    end
  end
end

defmodule Day03a do
  def run do
    File.read!("./day03.in.txt")
    |> String.strip
    |> String.codepoints
    |> Enum.reduce(%SantaGrid{}, &SantaGrid.move_and_deliver(&2, &1))
    |> SantaGrid.count_deliveries
  end
end

IO.puts Day03a.run
# => 2081
