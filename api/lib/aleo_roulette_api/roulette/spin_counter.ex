defmodule AleoRouletteApi.Roulette.SpinCounter do
  use Agent

  @name __MODULE__

  def start_link(_initial_value) do
    Agent.start_link(fn -> 0 end, name: @name)
  end

  def spin do
    @name |> Agent.update(fn x -> x + 1 end)
    @name |> Agent.get(fn x -> x end)
  end
end
