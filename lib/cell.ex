defmodule Cell do
  @moduledoc """
  Documentation for `Cell`.

  """

  def loop(state = {dead_or_alive, nb_alive}, neighbours \\ []) do
    receive do
      {:current_state, pid} ->
        Process.send(pid, {:state, dead_or_alive}, [])

      {:add_neighbour, pid} ->
        loop(state, [pid | neighbours])

      {:state, :alive} ->
        loop({dead_or_alive, nb_alive + 1}, neighbours)
    after
      500 ->
        next_state = next_state(state)
        Enum.each(neighbours, fn neighbour -> Cell.notify(neighbour, next_state) end)
        loop({next_state, 0})
    end
  end

  def next_state({:alive, nb_alive}) when nb_alive == 2 or nb_alive == 3 do
    :alive
  end

  def next_state({:dead, 3}) do
    :alive
  end

  def next_state(_) do
    :dead
  end

  # interface

  def create(state) do
    spawn(fn -> loop({state, 0}) end)
  end

  def add_neighbour(cell, neighbour) do
    send(cell, {:add_neighbour, neighbour})
    cell
  end

  def notify(cell, :alive) do
    send(cell, {:state, :alive})
    cell
  end
  def notify(cell, :dead) do
    cell
  end

  def state(pid) do
    send(pid, {:current_state, self()})

    receive do
      {:state, state} -> state
    after
      3_000 -> :error
    end
  end
end
