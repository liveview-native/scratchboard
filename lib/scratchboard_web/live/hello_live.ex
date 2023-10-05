defmodule ScratchboardWeb.HelloLive do
  use Phoenix.LiveView
  use LiveViewNative.LiveView

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :val, 0)}
  end

  def handle_event("inc", _, socket) do
    {:noreply, update(socket, :val, &(&1 + 1))}
  end

  def handle_event("dec", _, socket) do
    {:noreply, update(socket, :val, &(&1 - 1))}
  end

  def handle_event("navigate", _params, socket) do
    {:noreply, push_navigate(socket, to: "/counter?val=#{socket.assigns.val}")}
  end

  def handle_event("redirect", _params, socket) do
    {:noreply, redirect(socket, to: "/counter")}
  end

  @impl true
  def render(%{platform_id: :jetpack} = assigns) do
    ~JETPACK"""
    <Scaffold>
      <TopAppBar>
        <Title><Text>Hello</Text></Title>
      </TopAppBar>
      <Column width="fill" verticalArrangement="center" horizontalAlignment="center">
        <Text style="headlineLarge">Title</Text>
        <Card
          shape="8"
          padding="16"
          width="140"
          height="120"
          elevation="{'defaultElevation': '10', 'pressedElevation': '2'}"
          phx-click="dec"
        >
          <Text padding="16">Hello Jetpack!</Text>
        </Card>
        <Spacer height="8" />
        <Card padding="16">
          <Text padding="16">Simple card</Text>
        </Card>
        <Button
          phx-click="navigate"
          contentPadding="50"
          elevation="{'defaultElevation': '20', 'pressedElevation': '10'}"
        >
          <Text>Navigate to counter</Text>
        </Button>
        <Button phx-click="redirect"><Text>Redirect to counter</Text></Button>
        <IconButton phx-click="inc" colors="{'containerColor': '#FFFF0000', 'contentColor': '#FFFFFFFF'}">
          <Icon imageVector="filled:Add" />
        </IconButton>
        <Row verticalAlignment="center">
          <Button
            phx-click="dec"
            shape="circle"
            size="60"
          >
            <Text>-</Text>
          </Button>
          <Text>This counter: <%= @val %></Text>
          <Button phx-click="inc" shape="circle" size="60"><Text>+</Text></Button>
        </Row>
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

          <button phx-click="dec">-</button>
          This counter: <%= @val %>
          <button phx-click="inc">+</button>
        </ul>
      </div>
    </div>
    """
  end
end
