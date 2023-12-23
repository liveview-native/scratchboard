defmodule ScratchboardWeb.SampleTab do
  use Phoenix.LiveView
  use LiveViewNative.LiveView

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:selectedTab, "0") }
  end

  def handle_event("selectTab", tab, socket) do
    {:noreply, assign(socket, :selectedTab, tab)}
  end

  @impl true
  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(%{platform_id: :jetpack} = assigns) do
    ~JETPACK"""
    <Scaffold>
      <CenterAlignedTopAppBar template="topBar">
        <Text template="title">Navigation Bar</Text>
      </CenterAlignedTopAppBar>
      <Column size="fill" template="body">
        <TabRow selected-tab-index={"#{@selectedTab}"}>
          <Tab selected={"#{@selectedTab == "0"}"} phx-click="selectTab" phx-value="0">
            <Text template="text">Tab 0</Text>
          </Tab>
          <Tab selected={"#{@selectedTab == "1"}"} phx-click="selectTab" phx-value="1">
            <Text template="text">Tab 1</Text>
          </Tab>
          <Tab selected={"#{@selectedTab == "2"}"} phx-click="selectTab" phx-value="2">
            <Text template="text">Tab 2</Text>
          </Tab>
        </TabRow>
        <Box content-alignment="center"  size="fill">
          <Text font-size="24">Selected <%= @selectedTab %></Text>
        </Box>
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
      </div>
    </div>
    """
  end
end
