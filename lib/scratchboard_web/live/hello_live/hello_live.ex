defmodule ScratchboardWeb.HelloLive do
  use Phoenix.LiveView
  use LiveViewNative.LiveView

  alias Scratchboard.Counter

  @impl true
  def render(assigns) do
    render_native(assigns)
  end

  @impl true
  def mount(_params, _session, socket) do
    Counter.join(self())

    {:ok, assign(socket, :count, Counter.get_count())}
  end

  @impl true
  def handle_info({:count_changed, count}, socket) do
    {:noreply, assign(socket, :count, count)}
  end

  @impl true
  def handle_event("increment-count", _params, socket) do
    Scratchboard.Counter.increment_count()

    {:noreply, socket}
  end
end
