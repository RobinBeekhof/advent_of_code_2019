defmodule AdventocodeTest do
  use ExUnit.Case
  doctest Adventocode

  test "greets the world" do
    assert Adventocode.hello() == :world
  end
end
