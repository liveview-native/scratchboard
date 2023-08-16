defmodule ScratchboardWeb.HelloLive do
  use Phoenix.LiveView
  use LiveViewNative.LiveView

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :val, 10)}
  end

  def handle_event("inc", _, socket) do
    {:noreply, update(socket, :val, &(&1 + 1))}
  end

  def handle_event("dec", _, socket) do
    {:noreply, update(socket, :val, &(&1 - 1))}
  end

  @impl true
  def render(%{platform_id: :jetpack} = assigns) do
    ~JETPACK"""
    <Scaffold>
      <TopAppBar>
        <Title>
          <Text>App title</Text>
        </Title>
        <Action phx-click="increment-count">
          <Icon imageVector="filled:Add" />
        </Action>
        <NavIcon phx-click="increment-count">
          <Icon imageVector="filled:Menu" />
        </NavIcon>
      </TopAppBar>
      <Column>
        <AsyncImage url="https://assets.dockyard.com/images/narwin-home-flare.jpg"/>
        <Row verticalAlignment="center">
          <RadioButton padding="8"/><Text>Radio</Text>
        </Row>
        <Text>Counter: <%= @val %> </Text>
        <Card shape="8" padding="8">
          <Row padding="32">
            <Text>Card Content 1</Text>
            <Text>Card Content 2</Text>
          </Row>
        </Card>
        <Spacer height="30" />
        <Row width="fill" horizontalArrangement="spaceEvenly">
          <Text>Row 0 / Column 0</Text>
          <Text>Row 0 / Column 1</Text>
        </Row>
        <Row width="fill" horizontalArrangement="spaceBetween">
          <Text>Row 1 / Column 0</Text>
          <Text>Row 1 / Column 1</Text>
        </Row>
        <Button phx-click="inc">
          <Text>Button</Text>
        </Button>
      </Column>
    </Scaffold>
    """
  end

  @impl true
  def render(%{platform_id: :swiftui} = assigns) do
    ~SWIFTUI"""
    <VStack id="hello-ios">
      <Spacer />
      <HStack modifiers={padding(all: 5)}>
        <Text>Hello iOS!</Text>
      </HStack>
      <Spacer />
      <HStack modifiers={padding(all: 5)}>
        <NavigationLink destination={"/counter"}>
          <Text>Counter Demo</Text>
        </NavigationLink>
      </HStack>
      <HStack modifiers={padding(all: 5)}>
        <NavigationLink destination={"/swiftui-modifiers"}>
          <Text>SwiftUI Modifiers</Text>
        </NavigationLink>
      </HStack>
      <HStack modifiers={padding(all: 5)}>
        <NavigationLink destination={"/webview-test"}>
          <Text>WebView Example</Text>
        </NavigationLink>
      </HStack>
      <HStack modifiers={padding(all: 5)}>
        <NavigationLink destination={"/video-player-test"}>
          <Text>Video Player Example</Text>
        </NavigationLink>
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
        <ul>
          <li>
            <a href="/counter">Counter Demo</a>
          </li>
        </ul>
      </div>
    </div>
    """
  end
end
