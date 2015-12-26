require IEx
require Bitwise

defmodule Day07b do
  def run do
    circuit_board = %{}

    File.read!("./day07.in.txt")
    |> String.strip
    |> String.split("\n")
    |> process_lines(circuit_board)
    |> Map.get("a")
    |> IO.puts
  end

  defp process_lines([head | tail], circuit_board) do
    {inputs, operation, output} = parse_line(head)

    input_values = Enum.map(inputs, fn(x) ->
      cond do
        is_integer(x) -> x
        true -> Map.get(circuit_board, x)
      end
    end)

    # IO.puts "  Parsed to:"
    # Enum.each(input_values, fn(x) ->
    #   IO.puts("    In:  #{x}")
    # end)
    # IO.puts "    Op:  #{operation}"
    # IO.puts "    Out: #{output}"

    if Enum.all?(input_values) do
      value = perform(operation, input_values)
      # IO.puts "  Output value: #{value}"
      circuit_board = Map.put(circuit_board, output, value)
      process_lines(tail, circuit_board)
    else
      # IO.puts "  Inputs not available, delaying"
      process_lines(tail ++ [head], circuit_board)
    end
  end

  defp process_lines([], circuit_board) do
    circuit_board
  end

  defp parse_line([x, "->", z]), do: {[x], "ASSIGN", z}
  defp parse_line(["NOT", x, "->", z]), do: {[x], "NOT", z}
  defp parse_line([x, op, y, "->", z]), do: {[x, y], op, z}
  defp parse_line(string) do
    # IO.puts "Considering #{string}"
    String.split(string)
    |> Enum.map(&format_operand/1)
    |> parse_line
  end

  defp format_operand(operand) do
    cond do
      Regex.match?(~r(\d+), operand) -> String.to_integer(operand)
      operand == "b" -> 3176
      true -> operand
    end
  end

  defp perform("ASSIGN", x), do: hd(x)
  defp perform("NOT", x), do: Bitwise.bnot(hd(x))
  defp perform("OR", [x, y]), do: Bitwise.bor(x, y)
  defp perform("AND", [x, y]), do: Bitwise.band(x, y)
  defp perform("RSHIFT", [x, y]), do: Bitwise.bsr(x, y)
  defp perform("LSHIFT", [x, y]), do: Bitwise.bsl(x, y)
end

Day07b.run
# =>
