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
    false
    iex> AdventOfCode.Day4.passWordPredicate(123323)
    false
    iex> AdventOfCode.Day4.passWordPredicate(223450)
    false
    iex> AdventOfCode.Day4.passWordPredicate(111111)
    false
    iex> AdventOfCode.Day4.passWordPredicate(112233)
    true

  """

  def passWordPredicate(password) do
    digits = password
             |> Integer.digits
    digits
    |> equalOrHigher? and digits
                          |> onlyTwins?
  end


  defp equalOrHigher?([d1 | [d2 | _]]) when d1 > d2, do: false
  defp equalOrHigher?([_ | tail]), do: equalOrHigher?(tail)
  defp equalOrHigher?([]), do: true

  defp anyEqualSibling?([d1 | [d2 | _]]) when d1 == d2, do: true
  defp anyEqualSibling?([_ | tail]), do: anyEqualSibling?(tail)
  defp anyEqualSibling?([]), do: false

  defp onlyTwins?(digits), do: onlyTwins?(digits, 0)
  defp onlyTwins?([d1 | [d2 | [d3 | _]] = tail], _) when d1 == d2 and d2 == d3, do: onlyTwins?(tail, d1)
  defp onlyTwins?([d2 | [d3 | _]], d1) when d2 == d3 and d2 != d1, do: true
  defp onlyTwins?([_ | tail], _), do: onlyTwins?(tail, 0)
  defp onlyTwins?([], _), do: false

end
