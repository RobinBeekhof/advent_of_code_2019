defmodule AdventOfCode.IntCodeProgram do

  @doc """
  running the IntCode program

  ## Examples
  iex> AdventOfCode.IntCodeProgram.runIntCodeProgram([00001,0,0,0,99])
  {:ok, 4, {},[2,0,0,0,99]}
  iex> AdventOfCode.IntCodeProgram.runIntCodeProgram([2,3,0,3,99])
  {:ok, 4, {},[2,3,0,6,99]}
  iex> AdventOfCode.IntCodeProgram.runIntCodeProgram([2,4,4,5,99,0])
  {:ok, 4, {},[2,4,4,5,99,9801]}
  iex> AdventOfCode.IntCodeProgram.runIntCodeProgram([1,1,1,4,99,5,6,0,99])
  {:ok, 8, {},[30,1,1,4,2,5,6,0,99]}
  iex> AdventOfCode.IntCodeProgram.runIntCodeProgram([1002,4,3,4,33])
  {:ok, 4, {}, [1002, 4, 3, 4, 99]}
  iex> AdventOfCode.IntCodeProgram.runIntCodeProgram([104,50,99,1,0,0])
  {:ok, 2, {50}, [104,50,99,1,0,0]}
  iex> AdventOfCode.IntCodeProgram.runIntCodeProgram([103,2,99,1,0,0],1)
  {:ok, 2, {}, [103,2,1,1,0,0]}

  """

  def runIntCodeProgram(memory, input \\ 0, pointer \\ 0, output \\ {}) do

    {status, value, pos, nextPointer} = runInstruction(memory, input, pointer)
    updatedMemory = updateMemoryAddress(memory, pos, value)
    updatedOutput = Tuple.append(output, value)

    case status do
      :continue -> runIntCodeProgram(updatedMemory, input, nextPointer, output)
      :output -> runIntCodeProgram(memory, input, nextPointer, updatedOutput)
      :stop -> {:ok, pointer, output, memory}
      :error -> {:error, pointer, output, memory}
    end
  end

  defp runInstruction(memory, input, pointer) do
    memoryValueAt = &Enum.at(memory, &1)
    pointerPlus = &(pointer + &1)
    instruction = memoryValueAt.(pointer)

    {opCode, pm1, pm2, _pm3} = instruction |> decodeInstruction

    param1 = memoryValueAt.(pointerPlus.(1))
    param2 = memoryValueAt.(pointerPlus.(2))
    param3 = memoryValueAt.(pointerPlus.(3))

    doAdditionOf = &(&1 + &2)
    doMultiplicationOf = &(&1 * &2)
    storeAt = &(&1)
    increasePointerBy = &pointerPlus.(&1)

    getValue = fn (param, mode) ->
      case mode do
        0 -> memoryValueAt.(param)
        1 -> param
      end
    end

    case opCode do
      1 ->
        {
          :continue,
          doAdditionOf.(getValue.(param1, pm1), getValue.(param2, pm2)),
          storeAt.(param3),
          increasePointerBy.(4)
        }
      2 ->
        {
          :continue,
          doMultiplicationOf.(getValue.(param1, pm1), getValue.(param2, pm2)),
          storeAt.(param3),
          increasePointerBy.(4)
        }
      3 ->
        {
          :continue,
          input,
          storeAt.(getValue.(param1, pm1)),
          increasePointerBy.(2)
        }
      4 ->
        {:output,getValue.(param1, pm1), 0, increasePointerBy.(2)}
      99 ->
        {:stop, 0, 0, 0}
      _ ->
        {:error, 0, 0, 0}
    end
  end

  defp decodeInstruction(instruction) do
    digits = Integer.digits(instruction)
    times = 5 - Enum.count(digits)
    remainder = List.duplicate(0, times)
    [a, b, c, d, e] = Enum.concat(remainder, digits)
    {Integer.undigits([d, e]), c, b, a}
  end

  def getMemoryAddress({_,_,_,memory}, pos),
      do: memory
          |> Enum.at(pos)

  def loadIntCodeProgram(file) do
    {_, memory_string} = File.read(file)
    memory_string
    |> String.split(",")
    |> Enum.map(
         &String.replace(&1, "\n", "")
          |> String.to_integer
       )
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
    |> updateMemoryAddress(1, 12)
    |> updateMemoryAddress(2, 2)
  end

  defp updateMemoryAddress(memory, pos, value) do
    memory
    |> Enum.with_index(0)
    |> Enum.map(fn {k, v} -> {v, k} end)
    |> Map.new
    |> Map.put(pos, value)
    |> Enum.to_list
    |> Enum.sort(fn ({key1, _value1}, {key2, _value2}) -> key1 < key2 end)
    |> Enum.map(fn ({_key, value}) -> value  end)
  end

end
