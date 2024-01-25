defmodule ScratchboardWeb.SampleGrid do
  use Phoenix.LiveView
  use LiveViewNative.LiveView

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:gridType, "vertical") |> assign(:showPopup, false) |> assign(:menuOption, "") }
  end

  def handle_event("horizontalGrid", _, socket) do
    {:noreply, assign(socket, :gridType, "horizontal")}
  end

  def handle_event("verticalGrid", _, socket) do
    {:noreply, assign(socket, :gridType, "vertical")}
  end

  def handle_event("showPopup", _params, socket) do
    {:noreply, assign(socket, :showPopup, true)}
  end

  def handle_event("hidePopup", _params, socket) do
    {:noreply, assign(socket, :showPopup, false)}
  end

  def handle_event("onMenuOptionClick", _params, socket) do
    {:noreply, socket |> assign(:menuOption, _params) |> assign(:showPopup, false) }
  end

  @impl true
  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(%{platform_id: :jetpack} = assigns) do
    ~JETPACK"""
    <Scaffold top-bar-scroll-behavior="exitUntilCollapsed">
      <MediumTopAppBar template="topBar">
        <Text template="title">Grid <%= @menuOption %></Text>
        <IconButton template="action" phx-click="showPopup">
          <Icon image-vector="filled:MoreVert" />
          <DropdownMenu phx-click="hidePopup" expanded={"#{ @showPopup }"}>
            <DropdownMenuItem phx-click="onMenuOptionClick" phx-value="A">
              <Text>Option A</Text>
            </DropdownMenuItem>
            <DropdownMenuItem phx-click="onMenuOptionClick" phx-value="B">
              <Text>Option B</Text>
            </DropdownMenuItem>
          </DropdownMenu>
        </IconButton>
      </MediumTopAppBar>
      <BottomAppBar template="bottomBar">
        <IconButton phx-click="horizontalGrid" template="action">
          <Icon image-vector="filled:HorizontalDistribute" />
        </IconButton>
        <IconButton phx-click="verticalGrid" template="action">
          <Icon image-vector="filled:VerticalDistribute" />
        </IconButton>
        <FloatingActionButton phx-click="verticalGrid" template="fab" shape="12">
          <Icon image-vector="filled:Add"/>
        </FloatingActionButton>
      </BottomAppBar>
      <%= if @gridType == "vertical" do %>
        <LazyVerticalGrid columns="{'type': 'fixed', 'count': '3'}" template="body" content-padding="4" horizontal-arrangement="2" vertical-arrangement="2">
          <%= for x <- 1..50 do %>
            <Box background={"#{case rem(x, 4) do 0 -> "#FFFF0000"; 1-> "#FF00FF00"; 2 -> "#FF0000FF"; 3 -> "#FFFFFF00" end}"} content-alignment="center" aspect-ratio={"#{4/3}"}><Text>Item <%= x %></Text></Box>
          <% end %>
        </LazyVerticalGrid>
      <% end %>
      <%= if @gridType == "horizontal" do %>
        <LazyHorizontalGrid height="400" rows="{'type': 'fixed', 'count': '3'}" template="body" content-padding="4" horizontal-arrangement="2" vertical-arrangement="2">
        <%= for x <- 1..50 do %>
          <Box background={"#{case rem(x, 4) do 0 -> "#FFFF0000"; 1-> "#FF00FF00"; 2 -> "#FF0000FF"; 3 -> "#FFFFFF00" end}"} content-alignment="center" aspect-ratio={"#{4/3}"}><Text>Item <%= x %></Text></Box>
        <% end %>
        </LazyHorizontalGrid>
      <% end %>
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
