defmodule ScratchboardWeb.SwiftDemoLive do
  use Phoenix.LiveView
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
