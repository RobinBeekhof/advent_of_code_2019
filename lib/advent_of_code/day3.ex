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
      iex> AdventOfCode.Day3.proccesDirections(["R1","U2"])
      [{1, 0}, {1, 0}, {1, 1}, {1, 2}]

  """

  def proccesDirections(directions) do
    directions
    |> getCoords
    |> Enum.concat
    |> Enum.drop(1)
  end

  defp getCoords(directions), do: getCoords(directions, {0, 0})
  defp getCoords([], _coord), do: []
  defp getCoords([head | tail], {x, y}) do

    {direction, value} = String.split_at(head, 1)
    value = String.to_integer(value)

    case direction do
      "R" -> [Enum.into(x..x + value, [], &({&1, y})) | getCoords(tail, {x + value, y})]
      "L" -> [Enum.into(x..x - value, [], &({&1, y})) | getCoords(tail, {x - value, y})]
      "U" -> [Enum.into(y..y + value, [], &({x, &1})) | getCoords(tail, {x, y + value})]
      "D" -> [Enum.into(y..y - value, [], &({x, &1})) | getCoords(tail, {x, y - value})]
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

#  @doc """
#  ## Examples
#      iex> paths = [["R8","U5","L5","D3"],["U7","R6","D4","L4"]]
#      iex> paths
#      ...> |> Enum.map(&AdventOfCode.Day3.proccesDirections(&1))
#      ...> |> AdventOfCode.Day3.findIntersections
#      [{3, 3}, {6, 5}]
#
#  """
#  def findIntersections([path1Coords, path2Coords]) do
#    path1CoordsMapSet = path1Coords
#                        |> MapSet.new
#    path2CoordsMapSet = path2Coords
#                        |> MapSet.new
#    intersections = MapSet.intersection(path1CoordsMapSet, path2CoordsMapSet)
#                    |> MapSet.to_list
#
#    path1Steps = path1Coords
#                 |> Enum.with_index(0)
#                 |> Map.new
#
#    path2Steps = path2Coords
#                 |> Enum.with_index(0)
#                 |> Map.new
#
#    intersections
#    |> Enum.map(&({&1,Map.get }))
#  end

end
