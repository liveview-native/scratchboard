defmodule ScratchboardWeb.HelloLive do
  use ScratchboardWeb, :live_view
  use LiveViewNative.LiveView

  @impl true
  def render(assigns) do
    render_native(assigns)
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
