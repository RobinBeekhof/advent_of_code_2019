defmodule AdventOfCode.Day3 do

  def retrivePaths do
    {_, paths} = File.read("lib/resources/input_dec3.txt")
    paths
    |> String.split("\n")
    |> Enum.drop(-1)
    |> Enum.map(&String.split(&1, ","))
  end


  @doc """

  ## Examples
      iex> AdventOfCode.Day3.calcCoords(["R1","U2"])
      [[{0, 0}, {1, 0}], [{1, 0}, {1, 1}, {1, 2}]]

  """
  def calcCoords(directions), do: calcCoords(directions, {0, 0})

  def calcCoords([], _coord), do: []

  def calcCoords([head | tail], {x, y}) do

    {direction, value} = String.split_at(head, 1)
    value = String.to_integer(value)

    case direction do
      "R" -> [Enum.into(x.. x + value, [], &({&1, y})) | calcCoords(tail, {x + value, y})]
      "L" -> [Enum.into(x.. x - value, [], &({&1, y})) | calcCoords(tail, {x - value, y})]
      "U" -> [Enum.into(y.. y + value, [], &({x, &1})) | calcCoords(tail, {x, y + value})]
      "D" -> [Enum.into(y.. y - value, [], &({x, &1})) | calcCoords(tail, {x, y - value})]
    end
  end

  def sortCoordsByDistance(coords) do
    Enum.sort(
      coords,
      fn (coord1, coord2) ->
        calculateManhattanDistance(coord1) < calculateManhattanDistance(coord2)
      end
    )
  end

  def calculateManhattanDistance({x, y}), do: abs(x) + abs(y)


  @doc """

  ## Examples
      iex> coords = [[{3, 2}, {3, 5}, {8, 0}, {8, 5}],[{1, 2}, {3, 5}, {8, 0}, {8, 5}]]
      iex> AdventOfCode.Day3.findDistToClosestIntersection(coords)
      [8, {3, 5}]

      iex> paths = [["R1","U2"],["U1","R2"]]
      iex> paths
      ...> |> Enum.map(&AdventOfCode.Day3.calcCoords(&1))
      ...> |> Enum.map(&Enum.concat(&1))
      ...> |> Enum.map(&AdventOfCode.Day3.sortCoordsByDistance(&1))
      ...> |> Enum.map(&Enum.drop(&1,1))
      ...> |> AdventOfCode.Day3.findDistToClosestIntersection
      [2,{1,1}]

      iex> paths = [["R8","U5","L5","D3"],["U7","R6","D4","L4"]]
      iex> paths
      ...> |> Enum.map(&AdventOfCode.Day3.calcCoords(&1))
      ...> |> Enum.map(&Enum.concat(&1))
      ...> |> Enum.map(&AdventOfCode.Day3.sortCoordsByDistance(&1))
      ...> |> Enum.map(&Enum.drop(&1,1))
      ...> |> AdventOfCode.Day3.findDistToClosestIntersection
      [6,{3,3}]


      iex> paths = [["R75","D30","R83","U83","L12","D49","R71","U7","L72"],["U62","R66","U55","R34","D71","R55","D58","R83"]]
      iex> paths
      ...> |> Enum.map(&AdventOfCode.Day3.calcCoords(&1))
      ...> |> Enum.map(&Enum.concat(&1))
      ...> |> Enum.map(&AdventOfCode.Day3.sortCoordsByDistance(&1))
      ...> |> Enum.map(&Enum.drop(&1,1))
      ...> |> AdventOfCode.Day3.findDistToClosestIntersection
      [159, {155, 4}]
  """

  def findDistToClosestIntersection([[head | tail], path2Coords]) do
    cond do
      path2Coords
      |> Enum.find_value(&(&1 == head)) -> [calculateManhattanDistance(head), head]
      true -> findDistToClosestIntersection([tail, path2Coords])
    end
  end

  @doc """
  ## Examples
      iex> paths = [["R8","U5","L5","D3"],["U7","R6","D4","L4"]]
      iex> paths
      ...> |> Enum.map(&AdventOfCode.Day3.calcCoords(&1))
      ...> |> Enum.map(&Enum.concat(&1))
      ...> |> Enum.map(&AdventOfCode.Day3.sortCoordsByDistance(&1))
      ...> |> Enum.map(&Enum.drop(&1,1))
      ...> |> AdventOfCode.Day3.findIntersections
      [6, {3, 3}, 11, {6, 5}]

  """




  def findIntersections(coords), do: findIntersections(coords,[])
  def findIntersections([[], _path2Coords], intersections), do: intersections
  def findIntersections([[head | tail], path2Coords], intersections) do
    cond do
      path2Coords
      |> Enum.find_value(&(&1 == head)) ->
        findIntersections(
          [
            tail,
            path2Coords
          ],
          Enum.concat(intersections, [calculateManhattanDistance(head), head])
        )
      true -> findIntersections([tail, path2Coords], intersections)
    end
  end

end
