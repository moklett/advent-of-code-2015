defmodule Day04a do
  @secret_key "bgvyzdsv"

  def find(pattern) do
    IO.puts _find(pattern, 1)
  end

  defp _find(pattern, number) do
    data = @secret_key <> Integer.to_string(number)
    hash = Base.encode16(:crypto.hash(:md5, data), case: :lower)
    cond do
      String.match?(hash, pattern) -> number
      true -> _find(pattern, number+1)
    end
  end
end

Day04a.find(~r/^00000/)
# => 254575

Day04a.find(~r/^000000/)
# => 254575
