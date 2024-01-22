defmodule ScratchboardWeb.SampleTab do
  use Phoenix.LiveView
  use LiveViewNative.LiveView

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:backCounter, 3) |> assign(:selectedTab, "0") |> assign(:selectedTimeMap, %{"hour" => 13, "minute" => 21, "is24Hour" => true}) }
  end

  def handle_event("selectTab", tab, socket) do
    {:noreply, assign(socket, :selectedTab, tab)}
  end

  def handle_event("onTimeChange", timeMap, socket) do
    {:noreply, assign(socket, :selectedTimeMap, timeMap)}
  end

  def handle_event("onBackPressed", _, socket) do
    {:noreply, assign(socket, :backCounter, socket.assigns.backCounter - 1)}
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
        <BackHandler enabled={"#{ @backCounter > 0}"} phx-keyup="onBackPressed"} />
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
        <Text>Back counter <%= @backCounter %></Text>
        <HorizontalPager current-page={"#{@selectedTab}"} page-count="3" phx-change="selectTab">
          <Column content-alignment="center" background="system-red" size="fill">
          <FlowColumn scroll="horizontal">
          <%= for x <- 1..50 do %>
            <OutlinedButton phx-click=""><Text>Item <%= x %></Text></OutlinedButton>
          <% end %>
          </FlowColumn>
          </Column>
          <LazyColumn size="fill">
            <ListItem >
              <Text template="headlineContent">Headline</Text>
            </ListItem>
            <ListItem>
              <Text template="headlineContent">Headline</Text>
              <Icon template="leadingContent" image-vector="filled:Add" />
              <Icon template="trailingContent" image-vector="filled:ChevronRight" />
            </ListItem>
            <ListItem>
              <Text template="headlineContent">Headline</Text>
              <Text template="overlineContent">OverlineContent</Text>
            </ListItem>
            <ListItem>
              <Text template="headlineContent">Headline</Text>
              <Text template="overlineContent">OverlineContent</Text>
              <Icon template="leadingContent" image-vector="filled:Add" />
              <Icon template="trailingContent" image-vector="filled:ChevronRight" />
            </ListItem>
            <ListItem>
              <Text template="headlineContent">Headline</Text>
              <Text template="overlineContent">Overline Content</Text>
              <Text template="supportingContent">Supporting Content</Text>
            </ListItem>
            <ListItem>
              <Text template="headlineContent">Headline</Text>
              <Text template="overlineContent">Overline Content</Text>
              <Text template="supportingContent">Supporting Content</Text>
              <Icon template="leadingContent" image-vector="filled:Add" />
            </ListItem>
            <ListItem>
              <Text template="headlineContent">Headline</Text>
              <Text template="overlineContent">Overline Content</Text>
              <Text template="supportingContent">Supporting Content</Text>
              <Icon template="leadingContent" image-vector="filled:Add" />
              <Icon template="trailingContent" image-vector="filled:ChevronRight" />
            </ListItem>
          </LazyColumn>
          <Column background="system-blue" size="fill">
            <Text font-size="24">Time <%= Map.get(@selectedTimeMap, "hour") %>:<%= Map.get(@selectedTimeMap, "minute") |> Integer.to_string |> String.pad_leading(2, "0") %></Text>
            <TimeInput
              initial-hour={"#{Map.get(@selectedTimeMap, "hour")}"}
              initial-minute={"#{Map.get(@selectedTimeMap, "minute")}"}
              phx-change="onTimeChange" />
          </Column>
        </HorizontalPager>
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
