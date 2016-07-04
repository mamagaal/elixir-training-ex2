defmodule Countdown.ArenaChannel do
  use Phoenix.Channel

  alias Countdown.Counter

  def join("arenas:lobby", _message, socket) do
    {:ok, %{counter: Counter.value}, socket}
  end

  def join("arenas:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("count", _body, socket) do
    count = Counter.count
    value = case count do
      {:ok, clickCount} -> %{won: false, counter: clickCount}
      {:overflow, clickCount} -> %{won: true, counter: clickCount}
    end
    broadcast! socket, "update", %{counter: value.counter}
    {:reply, {:ok, value}, socket}
  end

end
