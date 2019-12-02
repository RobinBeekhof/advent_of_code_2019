defmodule AdventOfCode.Day1 do
  @moduledoc ~S"""
  Day 1 of Advent of Code. Determine the amount of fuel to launch our space sled.
  """

  @doc ~S"""
  Calculate the fuel for all module weights

  ## Examples
      iex> AdventOfCode.Day1.exercise1
      3367126

  """
  def exercise1 do
    File.stream!("lib/resources/input_dec1_1.txt")
    |> Enum.to_list
    |> Enum.map(&String.replace(&1,"\n","") |> String.to_integer)
    |> Enum.map(&fuel_per_weight(&1))
    |> Enum.sum
  end

  @doc ~S"""
  Calculate the fuel for all module weights and the fuel for the fuel.

  ## Examples
      iex> AdventOfCode.Day1.exercise2
      5047796

  """
  def exercise2 do
    File.stream!("lib/resources/input_dec1_1.txt")
    |> Enum.to_list
    |> Enum.map(&String.replace(&1,"\n","") |> String.to_integer)
    |> Enum.map(&fuel_for_fuel(&1))
    |> Enum.sum
  end

  @doc ~S"""
  Calculates the amount of fuel needed for the weight of the fuel

    ## Examples
      iex> AdventOfCode.Day1.fuel_for_fuel(14)
      2
      iex> AdventOfCode.Day1.fuel_for_fuel(1969)
      966
      iex> AdventOfCode.Day1.fuel_for_fuel(100756)
      50346
  """

  def fuel_for_fuel(fuel_weight) do
    start_weight = fuel_per_weight(fuel_weight)
    fuel_for_fuel(start_weight,start_weight)
  end

  def fuel_for_fuel(fuel_weight, total_fuel_weight) do
    fuel_weight = fuel_per_weight(fuel_weight)
    cond do
      fuel_weight < 0 -> total_fuel_weight
      true -> fuel_for_fuel(fuel_weight, total_fuel_weight + fuel_weight)
    end
  end

  @doc ~S"""
  Calculates the amount of fuel needed to launch per weight

    ## Examples
      iex> AdventOfCode.Day1.fuel_per_weight(12)
      2
      iex> AdventOfCode.Day1.fuel_per_weight(14)
      2
      iex> AdventOfCode.Day1.fuel_per_weight(1969)
      654
      iex> AdventOfCode.Day1.fuel_per_weight(100756)
      33583
  """

  def fuel_per_weight(weight) do
    Integer.floor_div(weight,3) - 2
  end
end
