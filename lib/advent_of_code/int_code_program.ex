defmodule AdventOfCode.IntCodeProgram do

#  def findNounAndVerb(targetOutput) do
#
#  end

  def getMemoryAddress(memory,pos) do
    memory
    |> Enum.at(pos)
  end

  def retriveMemory do
    {_,memoryString} = File.read("lib/resources/input_dec2.txt")
    memoryString
    |> String.split(",")
    |> Enum.map(&String.replace(&1,"\n","")|> String.to_integer)
  end

  @doc """
  restore the gravity assist program (your puzzle input) to the "1202 program alarm"
  state it had just before the last computer caught fire.

  ## Examples
  iex> AdventOfCode.IntCodeProgram.restore1202([1,0,0,0,99])
  [1,12,2,0,99]
  """
  def restore1202(memory) do
    memory
    |> updateMemoryAddress(1,12)
    |> updateMemoryAddress(2,2)
  end

  def updateMemoryAddress(memory, pos, value) do
    memory
    |> Enum.with_index(0)
    |> Enum.map(fn {k,v}->{v,k} end)
    |> Map.new
    |> Map.put(pos,value)
    |> Enum.to_list
    |> Enum.sort(fn({key1, _value1}, {key2, _value2}) -> key1 < key2 end)
    |> Enum.map(fn({_key, value}) -> value  end)
  end


  @doc """
  running the IntCode program

  ## Examples
  iex> AdventOfCode.IntCodeProgram.runIntCodeProgram([1,0,0,0,99])
  [2,0,0,0,99]
  iex> AdventOfCode.IntCodeProgram.runIntCodeProgram([2,3,0,3,99])
  [2,3,0,6,99]
  iex> AdventOfCode.IntCodeProgram.runIntCodeProgram([2,4,4,5,99,0])
  [2,4,4,5,99,9801]
  iex> AdventOfCode.IntCodeProgram.runIntCodeProgram([1,1,1,4,99,5,6,0,99])
  [30,1,1,4,2,5,6,0,99]
  """
  def runIntCodeProgram(memory), do: runIntCodeProgram(memory,0)

  def runIntCodeProgram(memory, pointer) do
    instructions = memory
              |>Enum.chunk_every(4,4,[0,0,0])
              |> Enum.with_index(0)
              |> Enum.map(fn {k,v}->{v,k} end)
              |> Map.new

    {status,value,pos} = runInstruction(memory,instructions[pointer])

    case status do
      :stop -> memory
      :error -> IO.puts("something went wrong!!")
      :ok -> runIntCodeProgram(updateMemoryAddress(memory,pos,value), pointer + 1)
    end
  end

  @doc """
  calculate opcode

  ## Examples
  iex> memory = [1,9,10,3,2,3,11,0,99,30,40,50]
  iex> opCode = [1,9,10,3]
  iex> {_,result,_} = AdventOfCode.IntCodeProgram.runInstruction(memory,opCode)
  iex> result
  70

  iex> memory = [1,9,10,70,2,3,11,0,99,30,40,50]
  iex> opCode = [2,3,11,0]
  iex> {_,result,_} = AdventOfCode.IntCodeProgram.runInstruction(memory,opCode)
  iex> result
  3500

  iex> memory = [1,9,10,70,2,3,11,3500,99,30,40,50]
  iex> opCode = [99,30,40,50]
  iex> {status,_,_} = AdventOfCode.IntCodeProgram.runInstruction(memory,opCode)
  iex> status
  :stop


  """
  def runInstruction(memory,[opCode,param1,param2,param3]) do
    case opCode do
      1 -> {:ok, Enum.at(memory,param1) + Enum.at(memory,param2), param3}
      2 -> {:ok, Enum.at(memory,param1) * Enum.at(memory,param2), param3}
      99 -> {:stop,0,0}
      _ -> {:error,0,0}
    end
  end


end
