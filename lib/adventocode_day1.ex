defmodule Adventocode.Day1 do

  def exercise1 do
    File.stream!("lib/resources/input_dec1_1.txt")
    |> Enum.to_list
    |> Enum.map(&String.replace(&1,"\n","") |> String.to_integer)
    |> Enum.map(&(Integer.floor_div(&1,3)-2))
    |> Enum.sum
  end

#  def fuel_for_fuel(fuel, total_fuel) do
#    con
#
#  end

end
