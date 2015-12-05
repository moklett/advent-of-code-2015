defmodule Day01a do
  def run do
    File.read!("./day01a.in.txt")
    |> String.codepoints
    |> Enum.reduce(0, fn
         "(", floor -> floor + 1
         ")", floor -> floor - 1
         _, floor -> floor
       end)
  end
end

IO.puts Day01a.run
# => 74
