defmodule ScratchboardWeb.CounterLive do
  use Phoenix.LiveView
  use LiveViewNative.LiveView

  alias Scratchboard.Counter

  @impl true
  def render(%{platform_id: :swiftui} = assigns) do
    ~Z"""
    <VStack id="counter-ios">
      <HStack modifiers={@native |> padding(all: 5)}>
        <Text>This button has been pressed <%= @count %> times.</Text>
      </HStack>
      <HStack modifiers={@native |> padding(all: 5)}>
        <Button modifiers={@native |> padding(all: 5)} phx-click="increment-count">
          <Text>Press me</Text>
        </Button>
      </HStack>
    </VStack>
    """swiftui
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div id="hello-web">
      <div class="text-slate-800 bg-slate-50 h-screen w-screen grid grid-cols-1 gap-1 content-center items-center text-center">
        <div class="font-semibold mb-1">Hello web!</div>
        <div class="mb-2.5">This button has been clicked <%= @count %> times.</div>
        <div>
          <button phx-click="increment-count" class="text-stone-100 bg-indigo-600 font-semibold rounded py-2.5 px-3 border border-indigo-600 transition hover:bg-indigo-700">
            <span>Click me</span>
          </button>
        </div>
      </div>
    </div>
    """
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
