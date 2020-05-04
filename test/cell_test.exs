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

  test "cell still alive" do
    Cell.create(:alive)
    |> Cell.add_neighbour(self())
    |> Cell.notify(:alive)
    |> Cell.notify(:alive)

    receive_alive()
  end

  test "cell become alive" do
    Cell.create(:dead)
    |> Cell.add_neighbour(self())
    |> Cell.notify(:alive)
    |> Cell.notify(:alive)
    |> Cell.notify(:alive)

    receive_alive()
  end

  test "cell still dead" do
    Cell.create(:dead)
    |> Cell.add_neighbour(self())

    receive_no_message()
  end

  test "cell become dead" do
    Cell.create(:alive)
    |> Cell.add_neighbour(self())

    receive_no_message()
  end

  def receive_alive do
    receive do
      {:state, :alive} -> assert true
      wrong_message -> assert :error == wrong_message
    after
      1_000 ->
        assert false
    end
  end

  def receive_no_message do
    receive do
      wrong_message -> assert :error == wrong_message
    after
      1_000 ->
        assert true
    end
  end

end
