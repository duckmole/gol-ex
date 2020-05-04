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

  test "get state for a dead cell" do
    cell_pid = Cell.create(:dead)
    assert Cell.state(cell_pid) == :dead
  end

  test "update cell state for a alive cell" do
    assert Cell.next_state({:alive, 0}) == :dead
    assert Cell.next_state({:alive, 2}) == :alive
    assert Cell.next_state({:alive, 3}) == :alive
    assert Cell.next_state({:alive, 4}) == :dead
  end

  test "update cell state for a dead cell" do
    assert Cell.next_state({:dead, 0}) == :dead
    assert Cell.next_state({:dead, 2}) == :dead
    assert Cell.next_state({:dead, 3}) == :alive
    assert Cell.next_state({:dead, 4}) == :dead
  end
end
