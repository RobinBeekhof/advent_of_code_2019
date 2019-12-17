defmodule AdventOfCode.Exercises do
  @moduledoc false
  import AdventOfCode.IntCodeProgram
  import AdventOfCode.Day3
  import AdventOfCode.Day4

  @doc """
  Day 2 exercise 1
    ## Examples
    iex> AdventOfCode.Exercises.day2_exercise1
    3654868
  """
  @day2_exercise1_intcode_file "lib/resources/input_dec2.txt"
  def day2_exercise1 do
    loadIntCodeProgram(@day2_exercise1_intcode_file)
    |> restore1202
    |> runIntCodeProgram
    |> getMemoryAddress(0)
  end

#  @doc """
#  Day 3 exercise 1
#  ## Examples
#  iex> AdventOfCode.Exercises.day3_exercise1
#  [870, {870, 0}]
#  """
#
#  def day3_exercise1 do
#    retrivePaths()
#    |> Enum.map(&getCoords(&1))
#    |> Enum.map(&Enum.concat(&1))
#    |> Enum.map(&sortCoordsByDistance(&1))
#    |> Enum.map(&Enum.drop(&1,1))
#    |> findDistToClosestIntersection
#
#  end

  @doc """
  Day 4 exercise 2
  ## Examples
  iex> AdventOfCode.Exercises.day4_exercise2
  1991
  """

  def day4_exercise2 do
    109165..576723
    |> findPossiblePassWordsInRange
    |> Enum.count
  end

  @doc """
  Day 5 exercise 1
  ## Examples
#  iex> AdventOfCode.Exercises.day5_exercise1
#  1991
  """

  @day5_exercise1_intcode_file "lib/resources/input_dec5.txt"
  def day5_exercise1 do
    loadIntCodeProgram(@day5_exercise1_intcode_file)
    |> Enum.count
#    |> runIntCodeProgram(1)
  end



end
