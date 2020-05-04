defmodule Cell do
  @moduledoc """
  Documentation for `Cell`.

  """

  def loop(state) do
    receive do
      {:state, pid} ->
        Process.send(pid, {:state, state}, [])
    after
      1_000 -> loop(state)
    end
  end

  def create(state) do
    Process.spawn(fn -> loop(state) end,[])
  end

  def state(pid) do
    :ok = Process.send(pid, {:state, self()}, [])
    receive do
      {:state, state} -> state
    after
      3_000 -> :error
    end
  end

end
