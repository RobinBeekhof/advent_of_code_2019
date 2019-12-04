defmodule AdventOfCode.Day4 do

  def findPossiblePassWordsInRange(range) do
    range
    |> Stream.filter(&passWordPredicate(&1))
    |> Enum.to_list
  end

  @doc """

  ## Examples
    iex> AdventOfCode.Day4.passWordPredicate(12345)
    false
    iex> AdventOfCode.Day4.passWordPredicate(111123)
    true
    iex> AdventOfCode.Day4.passWordPredicate(123323)
    false
    iex> AdventOfCode.Day4.passWordPredicate(223450)
    false
    iex> AdventOfCode.Day4.passWordPredicate(111111)
    true

  """

  def passWordPredicate(password) do
    digits = password |> Integer.digits
    digits |> equalOrHigher? and digits |> anyEqualNeighbor?
  end

  defp equalOrHigher?([d1| [d2|_] ]) when d1 > d2, do: false
  defp equalOrHigher?([_|tail]), do: equalOrHigher?(tail)
  defp equalOrHigher?([]), do: true

  defp anyEqualNeighbor?([d1| [d2|_] ]) when d1 == d2, do: true
  defp anyEqualNeighbor?([_|tail]), do: anyEqualNeighbor?(tail)
  defp anyEqualNeighbor?([]), do: false

end
