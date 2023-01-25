defmodule Scratchboard.Counter do
  use GenServer

  alias __MODULE__, as: Counter

  @initial_state %{count: 0, subscribers: []}

  # Client

  def start_link(_initial_state) do
    GenServer.start_link(Counter, @initial_state, name: Counter)
  end

  def increment_count do
    GenServer.call(Counter, :increment_count)
  end

  def get_count do
    GenServer.call(Counter, :get_count)
  end

  def join(pid) do
    GenServer.call(Counter, {:join, pid})
  end

  def leave(pid) do
    GenServer.call(Counter, {:leave, pid})
  end

  # Server (callbacks)

  def init(initial_state) do
    {:ok, initial_state}
  end

  def handle_call(:increment_count, _from, %{subscribers: subscribers} = state) do
    new_count = state.count + 1
    new_state = %{state | count: new_count}

    notify_subscribers(subscribers, new_count)

    {:reply, :ok, new_state}
  end

  def handle_call(:get_count, _from, state) do
    {:reply, state.count, state}
  end

  def handle_call({:join, pid}, _from, state) do
    Process.monitor(pid)

    {:reply, :ok, %{state | subscribers: [pid | state.subscribers]}}
  end

  def handle_info({:DOWN, _ref, :process, pid, _reason}, state) do
    {:noreply, %{state | subscribers: Enum.reject(state.subscribers, &(&1 == pid))}}
  end

  # Private functions

  defp notify_subscribers(subscribers, count) do
    Enum.each(subscribers, fn pid -> send(pid, {:count_changed, count}) end)
  end
end
