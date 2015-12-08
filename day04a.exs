defmodule Day04a do
  @secret_key "bgvyzdsv"

  def run do
    IO.puts find_the_one(1)
  end

  defp find_the_one(number) do
    data = @secret_key <> Integer.to_string(number)
    hash = Base.encode16(:crypto.hash(:md5, data), case: :lower)
    case hash do
      "00000" <> _ -> number
      _ -> find_the_one(number+1)
    end
  end
end

Day04a.run
# => 254575
