defmodule ScratchboardWeb.SampleNavBar do
  use Phoenix.LiveView
  use LiveViewNative.LiveView

  def mount(_params, _session, socket) do
    {:ok, socket  |> assign(:selectedChoice, "0") |> assign(:selectedChoices, %{"0" => "false", "1" => "false", "2" => "true"}) |> assign(:isChecked, true) |> assign(:counter, 0) |> assign(:queryText, "") |> assign(:showDismissable, true)}
  end

  def handle_event("selectTab", tab, socket) do
    {:noreply, push_patch(socket, to: "/sampleNavBar/#{tab}")}
  end

  def handle_event("selectChoice", choice, socket) do
    {:noreply, assign(socket, :selectedChoice, choice)}
  end

  def handle_event("selectMultiChoice", change, socket) do
    {:noreply, assign(socket, :selectedChoices, Map.put(socket.assigns.selectedChoices, Enum.at(change, 0), Enum.at(change, 1)))}
  end

  def handle_event("toggleCheck", value, socket) do
    {:noreply, assign(socket, :isChecked, value)}
  end

  def handle_event("onClick", _, socket) do
    {:noreply, assign(socket, :counter, socket.assigns.counter + 1)}
  end

  def handle_params(params, _uri, socket) do
    {:noreply, assign(socket, :selectedTab, Map.get(params, "tab", "0") )}
  end

  def handle_event("onQueryChange", q, socket) do
    {:noreply, assign(socket, :queryText, q)}
  end

  def handle_event("onSearch", q, socket) do
    {:noreply, assign(socket, :queryText, q)}
  end

  def handle_event("onSwipeChanged", _, socket) do
    {:noreply, assign(socket, :showDismissable, false)}
  end

  @impl true
  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(%{platform_id: :jetpack} = assigns) do
    ~JETPACK"""
    <Scaffold>
      <CenterAlignedTopAppBar template="topBar">
        <Text template="title">Navigation Bar</Text>
      </CenterAlignedTopAppBar>
      <NavigationBar template="bottomBar">
        <NavigationBarItem selected={"#{@selectedTab == "0"}"} phx-click="selectTab" phx-value="0">
          <Icon image-vector="filled:HorizontalDistribute" template="icon"/>
          <Text template="label">Tab 1</Text>
        </NavigationBarItem>
        <NavigationBarItem selected={"#{@selectedTab == "1"}"} phx-click="selectTab" phx-value="1">
          <Icon image-vector="filled:VerticalDistribute" template="icon" />
          <Text template="label">Tab 2</Text>
        </NavigationBarItem>
        <NavigationBarItem selected={"#{@selectedTab == "2"}"} phx-click="selectTab" phx-value="2">
          <Icon image-vector="filled:Add"  template="icon"/>
          <Text template="label">Tab 3</Text>
        </NavigationBarItem>
      </NavigationBar>
      <Column vertical-arrangement="center" template="body" size="fill">
        <%= if @showDismissable do %>
        <SwipeToDismissBox on-value-changed="onSwipeChanged">
          <ListItem template="content">
            <Text template="headlineContent">Headline</Text>
            <Icon template="leadingContent" image-vector="filled:Add" />
            <Icon template="trailingContent" image-vector="filled:ChevronRight" />
          </ListItem>
          <Box background="system-red" padding="12" template="backgroundContent" width="fill">
            <Icon image-vector="filled:Delete" />
          </Box>
        </SwipeToDismissBox>
        <% end %>
        <DockedSearchBar query={"#{@queryText}"} phx-change="onQueryChange" active="false" phx-value="Foo" phx-submit="onSearch">
          <Icon image-vector="filled:Search"  template="leadingIcon"/>
          <IconButton phx-click="" template="trailingIcon">
            <Icon image-vector="filled:Clear" />
          </IconButton>
          <Text template="placeholder">Placeholder</Text>
          <Text template="content">Searching by: <%= @queryText %></Text>
        </DockedSearchBar>
        <Text font-size="24">Selected <%= @selectedTab %></Text>
        <OutlinedIconToggleButton checked={"#{@isChecked}"} phx-change="toggleCheck">
          <Icon image-vector="filled:Check" />
        </OutlinedIconToggleButton>
        <SingleChoiceSegmentedButtonRow>
          <SegmentedButton selected={"#{@selectedChoice == "0"}"} phx-click="selectChoice" phx-value="0">
            <Text template="label">Option 1</Text>
          </SegmentedButton>
          <SegmentedButton selected={"#{@selectedChoice == "1"}"} phx-click="selectChoice" phx-value="1">
            <Text template="label">Option 2</Text>
          </SegmentedButton>
          <SegmentedButton selected={"#{@selectedChoice == "2"}"} phx-click="selectChoice" phx-value="2">
            <Text template="label">Option 3</Text>
          </SegmentedButton>
        </SingleChoiceSegmentedButtonRow>

        <MultiChoiceSegmentedButtonRow>
          <SegmentedButton checked={"#{Map.get(@selectedChoices, "0")}"} phx-change="selectMultiChoice" phx-value="0">
            <Text template="label">Option 1</Text>
          </SegmentedButton>
          <SegmentedButton checked={"#{Map.get(@selectedChoices, "1")}"} phx-change="selectMultiChoice" phx-value="1">
            <Text template="label">Option 2</Text>
          </SegmentedButton>
          <SegmentedButton checked={"#{Map.get(@selectedChoices, "2")}"} phx-change="selectMultiChoice" phx-value="2">
            <Text template="label">Option 3</Text>
          </SegmentedButton>
        </MultiChoiceSegmentedButtonRow>

        <Text>Counter: <%= @counter %></Text>
        <Surface shape="12" color="system-blue" content-color="system-white"
          border="{'width': '2', 'color': 'system-green'}"
          phx-click="onClick">
          <Text padding="32">Surface</Text>
        </Surface>

        <FlowRow>
          <AssistChip phx-click="">
            <Icon image-vector="filled:Check" template="leadingIcon"/>
            <Icon image-vector="filled:CheckCircleOutline" template="trailingIcon"/>
            <Text template="label">AssitChip</Text>
          </AssistChip>
          <ElevatedAssistChip phx-click="">
            <Icon image-vector="filled:Check" template="leadingIcon"/>
            <Icon image-vector="filled:CheckCircleOutline" template="trailingIcon"/>
            <Text template="label">AssitChip</Text>
          </ElevatedAssistChip>
          <FilterChip phx-click="" selected="true">
            <Icon image-vector="filled:Check" template="leadingIcon"/>
            <Icon image-vector="filled:CheckCircleOutline" template="trailingIcon"/>
            <Text template="label">Filter Chip 1</Text>
          </FilterChip>
          <FilterChip phx-click="" selected="false">
            <Icon image-vector="filled:Check" template="leadingIcon"/>
            <Icon image-vector="filled:CheckCircleOutline" template="trailingIcon"/>
            <Text template="label">Filter Chip 2</Text>
          </FilterChip>
        </FlowRow>
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
