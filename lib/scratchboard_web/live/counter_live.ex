defmodule ScratchboardWeb.CounterLive do
  use Phoenix.LiveView
  use LiveViewNative.LiveView

  alias Scratchboard.Counter

  @impl true
  def render(%{platform_id: :jetpack} = assigns) do
    ~JETPACK"""
    <Scaffold>
      <TopAppBar template="topBar">
        <Text template="title">App title</Text>
        <IconButton template="action" phx-click="decrement-count">
          <Icon imageVector="filled:Add" />
        </IconButton>
        <IconButton template="navIcon" phx-click="reset-count">
          <Icon imageVector="filled:Menu" />
        </IconButton>
      </TopAppBar>
      <Column template="body" scroll="vertical">
        <Text>Here</Text>
        <AsyncImage url="https://assets.dockyard.com/images/narwin-home-flare.jpg" alpha="0.5" shape="circle" contentScale="fillHeight"/>
        <Text>Counter: <%= @count %> </Text>
        <Row scroll="horizontal">
          <Card shape="8" padding="8">
            <Row padding="32">
              <Text>Card Content 1</Text>
              <Text>Card Content 2</Text>
            </Row>
          </Card>
          <Card shape="8" padding="8">
            <Row padding="32">
              <Text>Card Content 1</Text>
              <Text>Card Content 2</Text>
            </Row>
          </Card>
        </Row>
        <Spacer height="30" />
        <Row width="fill" horizontalArrangement="spaceEvenly">
          <Text>Row 0 / Column 0</Text>
          <Text>Row 0 / Column 1</Text>
        </Row>
        <Row width="fill" horizontalArrangement="spaceBetween">
          <Text>Row 1 / Column 0</Text>
          <Text>Row 1 / Column 1</Text>
        </Row>
        <Button phx-click="increment-count">
          <Text>Button</Text>
        </Button>
      </Column>
    </Scaffold>
    """
  end

  @impl true
  def render(%{platform_id: :swiftui} = assigns) do
    ~SWIFTUI"""
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
    """
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
  def mount(params, _session, socket) do
    initial_value = Map.get(params, "val", Counter.get_count())
    x = cond do
      is_integer(initial_value) ->
        initial_value

      is_binary(initial_value) ->
        {val, _} = Integer.parse(initial_value)
        val
    end
    Counter.join(self())
    Scratchboard.Counter.set_initial(x)
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

  def handle_event("decrement-count", _, socket) do
    Scratchboard.Counter.decrement_count()
    {:noreply, socket}
  end

  def handle_event("reset-count", _, socket) do
    Scratchboard.Counter.reset_count()
    {:noreply, socket}
  end
end
