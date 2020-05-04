defmodule Cell do
  @moduledoc """
  Documentation for `Cell`.

  """

  def loop() do
    Process.sleep(1000)
    loop()
  end

  def create(state) do
    Process.spawn(fn -> loop() end,[])
  end

  def state(pid) do
    :alive
  end

end
