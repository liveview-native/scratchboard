defmodule ScratchboardWeb.SampleBottomSheetScaffold do
  use Phoenix.LiveView
  use LiveViewNative.LiveView

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:sheetValue, "hidden") |> assign(:selectedDate, 1705028400000) |> assign(:showDialog, false) |> assign(:dateRange, [1704855600000, 1705719600000])}
  end

  def handle_event("toggleSheet", newSheetValue, socket) do
    {:noreply, assign(socket, :sheetValue, newSheetValue)}
  end

  def handle_event("selectDate", newDate, socket) do
    {:noreply, assign(socket, :selectedDate, newDate)}
  end

  def handle_event("selectDateRange", newDateRange, socket) do
    {:noreply, assign(socket, :dateRange, newDateRange)}
  end

  def handle_event("showDialog", _params, socket) do
    {:noreply, assign(socket, :showDialog, true)}
  end

  def handle_event("hideDialog", _params, socket) do
    {:noreply, assign(socket, :showDialog, false)}
  end

  @impl true
  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(%{platform_id: :jetpack} = assigns) do
    ~JETPACK"""
    <BottomSheetScaffold sheetValue={"#{@sheetValue}"} sheetSkipHiddenState="false" sheetOnChanged="toggleSheet">
      <TopAppBar template="topBar">
        <Text template="title">DatePicker</Text>
      </TopAppBar>
      <Box size="fill" contentAlignment="center" template="sheetContent">
        <Text>Sheet</Text>
      </Box>
      <Column width="fill" scroll="vertical" template="body">
        <Button phx-click="toggleSheet" phx-value={if @sheetValue == "hidden", do: "partiallyExpanded", else: "hidden"}>
          <Text>Toggle</Text>
        </Button>
        <DatePicker phx-change="selectDate" initialSelectedDateMillis="1705028400000"/>
        <Text>Date: <%= @selectedDate %></Text>
        <TextButton phx-click="showDialog"><Text>Show Dialog</Text></TextButton>
        <Box width="fill" height="400">
          <DateRangePicker phx-change="selectDateRange" initialSelectedStartDateMillis={"#{Enum.at(@dateRange,0)}"} initialSelectedEndDateMillis={"#{Enum.at(@dateRange,1)}"}/>
        </Box>
        <Text>Date Start = <%= Enum.at(@dateRange,0) %></Text>
        <Text>Date End <%= Enum.at(@dateRange,1) %></Text>
        <%= if @showDialog do %>
        <DatePickerDialog phx-click="hideDialog">
          <TextButton phx-click="hideDialog" template="confirm">
            <Text>Confirm</Text>
          </TextButton>
          <DatePicker phx-change="selectDate" initialSelectedDateMillis={"#{@selectedDate}"} showToggleMode="false" />
        </DatePickerDialog>
        <% end %>
      </Column>
    </BottomSheetScaffold>
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
