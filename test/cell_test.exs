defmodule CellTest do
  use ExUnit.Case
  doctest Cell

  test "get state of a cell" do
    cell_pid = Cell.create(:alive)
    assert Cell.state(cell_pid) == :alive
  end

  test "cell is a process" do
    cell_pid = Cell.create(:alive)
    assert Process.alive?(cell_pid)
  end
end
