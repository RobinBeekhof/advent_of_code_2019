defmodule Adventocode.Day1 do

  def exercise1 do
    File.stream!("lib/resources/input_dec1_1.txt")
    |> Enum.to_list
    |> Enum.map(&String.replace(&1,"\n","") |> String.to_integer)
    |> Enum.map(&fuel_per_weight(&1))
    |> Enum.sum
  end

  def exercise2 do
    File.stream!("lib/resources/input_dec1_1.txt")
    |> Enum.to_list
    |> Enum.map(&String.replace(&1,"\n","") |> String.to_integer)
    |> Enum.map(&fuel_for_fuel(&1))
    |> Enum.sum
  end

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

  def fuel_per_weight(weight) do
    Integer.floor_div(weight,3) - 2
  end
end
