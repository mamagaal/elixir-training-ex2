defmodule Countdown.Counter do
  def start_link do
    Agent.start_link(fn -> 0 end, name: __MODULE__)
  end

  @doc "Resets the counter"
  def reset() do
    Agent.update(__MODULE__, fn(_n) -> 0 end)
  end

  @doc "Returns the value of the counter"
  def value() do
    Agent.get(__MODULE__, fn(n) -> n end)
  end

  @doc "Increments the value of the counter"
  def count() do
    Agent.get_and_update(__MODULE__,
                    fn(n) -> if n < limit - 1 do {{:ok, n+1}, n + 1} else {{:overflow, 0}, 0} end end)
  end

  @doc "Sets the value of the counter"
  def set(new_value) do
    Agent.update(__MODULE__, fn(_n) -> new_value end)
  end

  @doc "Returns the value of the counter"
  def limit() do
    100
  end

end
