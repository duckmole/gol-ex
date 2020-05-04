defmodule CellTest do
  use ExUnit.Case
  doctest Cell

  test "get state of a Cell" do
    cell_pid = Cell.create(:alive)
    assert Cell.state(cell_pid) == :alive
  end
end
