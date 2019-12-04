defmodule AdventOfCode.Exercises do
  @moduledoc false
  import AdventOfCode.IntCodeProgram

  @doc """
  Day 2 exercise 1
  ## Examples
  iex> AdventOfCode.Exercises.day2_exercise1
  3654868
  """

  def day2_exercise1 do
    retriveMemory()
    |> restore1202
    |> runIntCodeProgram
    |> getMemoryAddress(0)
  end


end
