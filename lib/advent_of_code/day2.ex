defmodule AdventOfCode.Day2 do


  def retriveIntCode do
    {_,intCodeString} = File.read("lib/resources/input_dec2.txt")
    intCodeString
    |> String.split(",")
    |> Enum.map(&String.replace(&1,"\n","")|> String.to_integer)
  end

  def proccesIntCode(intCode, [head|tail]) do

  end

  def proccesIntCode(intCode, {status,code}) when status == :stop, do:  intCode

  def proccesIntCode(intCode, {status,code}) do
    calculateOpCode

  end











  @doc """
  calculate opcode

  ## Examples
  iex> intCode = [1,9,10,3,2,3,11,0,99,30,40,50]
  iex> opCode = [1,9,10,3]
  iex> {_,[_,_,_,result]} = AdventOfCode.Day2.calculateOpCode(intCode,opCode)
  iex> result
  70

  iex> intCode = [1,9,10,70,2,3,11,0,99,30,40,50]
  iex> opCode = [2,3,11,0]
  iex> {_,[_,_,_,result]} = AdventOfCode.Day2.calculateOpCode(intCode,opCode)
  iex> result
  3500

  iex> intCode = [1,9,10,70,2,3,11,3500,99,30,40,50]
  iex> opCode = [99,30,40,50]
  iex> {status,[_,_,_,_]} = AdventOfCode.Day2.calculateOpCode(intCode,opCode)
  iex> status
  :stop


  """
  def calculateOpCode(intCode, [pos0,pos1,pos2,pos3]) do
    case pos0 do
      1 -> {:ok, [pos0,pos1,pos2,Enum.at(intCode,pos1) + Enum.at(intCode,pos2)]}
      2 -> {:ok, [pos0,pos1,pos2,Enum.at(intCode,pos1) * Enum.at(intCode,pos2)]}
      99 -> {:stop, [pos0,pos1,pos2,pos3]}
      _ -> {:error, [pos0,pos1,pos2,pos3]}
    end
  end


end
