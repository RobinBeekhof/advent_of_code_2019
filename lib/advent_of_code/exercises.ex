defmodule AdventOfCode.Exercises do
  @moduledoc false
  import AdventOfCode.IntCodeProgram
  import AdventOfCode.Day3

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

  @doc """
  Day 3 exercise 1
  ## Examples
  iex> AdventOfCode.Exercises.day3_exercise1
  0
  """

  def day3_exercise1 do
    retrivePaths()
    |> Enum.map(&calcCoords(&1))
    |> Enum.map(&Enum.concat(&1))
    |> Enum.map(&sortCoordsByDistance(&1))
    |> Enum.map(&Enum.drop(&1,1))
    |> findDistToClosestIntersection

  end


end
