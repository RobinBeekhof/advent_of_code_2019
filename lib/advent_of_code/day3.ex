defmodule AdventOfCode.Day3 do
  @doc """

  ## Examples
      iex> AdventOfCode.Day3.calcCoords(["R8","U5","L5","D3"])
      [{8,0},{8,5},{3,5},{3,2}]

  """
  def calcCoords(directions), do: calcCoords(directions, {0, 0})

  def calcCoords([], _coord), do: []

  def calcCoords([head | tail], {x, y}) do

    {direction, value} = String.split_at(head, 1)
    value = String.to_integer(value)

    case direction do
      "R" -> [{x + value, y} | calcCoords(tail, {x + value, y})]
      "L" -> [{x - value, y} | calcCoords(tail, {x - value, y})]
      "U" -> [{x, y + value} | calcCoords(tail, {x, y + value})]
      "D" -> [{x, y - value} | calcCoords(tail, {x, y - value})]
    end
  end

  def sortCoordsByDistance(coords) do
    Enum.sort(coords, fn ({x1, y1}, {x2, y2}) -> (x1 + y1) < (x2 + y2) end)
  end

  def calculateManhattanDistance({x, y}), do: x + y


  @doc """

  ## Examples
      iex> path1Coords = [{3, 2}, {3, 5}, {8, 0}, {8, 5}]
      iex> path2Coords = [{1, 2}, {3, 5}, {8, 0}, {8, 5}]
      iex> AdventOfCode.Day3.findDistToClosestIntersection(path1Coords,path2Coords)
      8

  """

  def findDistToClosestIntersection(path1Coords, path2Coords) do
    path2Coords_set = path2Coords
                      |> Enum.into(MapSet.new)

    {x, y} = Enum.find(
      path1Coords,
      fn coord ->
        MapSet.member? path2Coords_set, coord
      end
    )

    x + y
  end

end
