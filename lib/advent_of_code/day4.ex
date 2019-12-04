defmodule AdventOfCode.Day4 do

  @doc """

  ## Examples
      iex> AdventOfCode.Day4.passWordPredicate(111123)
      true

  """

  def passWordPredicate(password) do
    digits = password |> Integer.digits
    
    digits |> equalOrHigher?
  end


  def equalOrHigher?([d1| [d2|_] ]) when d1 >= d2, do: false
  def equalOrHigher?([_|tail]), do: equalOrHigher?(tail)
  def equalOrHigher?([]), do: true

  def anyEqualNeighbor?([d1| [d2|_] ]) when d1 == d2, do: true
  def anyEqualNeighbor?([_|tail]), do: anyEqualNeighbor?(tail)
  def anyEqualNeighbor?([]), do: false


end
