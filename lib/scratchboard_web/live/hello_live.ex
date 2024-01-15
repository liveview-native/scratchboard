defmodule ScratchboardWeb.HelloLive do
  use Phoenix.LiveView
  use LiveViewNative.LiveView

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:val, 0) |> assign(:userText, "") |> assign(:sliderValue, 30) |> assign(:sliderRange, [10, 90]) |> assign(:isChecked, true) |> assign(:radioOption, "A") |> assign(:ddOption, "A") |> assign(:showDialog, false) |> assign(:showSnack, false) |> assign(:drawerIsOpen, false) |> assign(:bottomSheetState, "hidden")}
  end

  def handle_event("inc", _, socket) do
    {:noreply, update(socket, :val, &(&1 + 1))}
  end

  def handle_event("dec", _, socket) do
    {:noreply, update(socket, :val, &(&1 - 1))}
  end

  def handle_event("setName", name, socket) do
    {:noreply, assign(socket, :userText, name)}
  end

  def handle_event("setSliderValue", value, socket) do
    {:noreply, assign(socket, :sliderValue, value)}
  end

  def handle_event("setSliderRange", value, socket) do
    {:noreply, assign(socket, :sliderRange, value)}
  end

  def handle_event("toggleCheck", value, socket) do
    {:noreply, assign(socket, :isChecked, value)}
  end

  def handle_event("setRadioOption", value, socket) do
    {:noreply, assign(socket, :radioOption, value)}
  end

  def handle_event("setDDOption", value, socket) do
    {:noreply, assign(socket, :ddOption, value)}
  end

  def handle_event("showDialog", _params, socket) do
    {:noreply, assign(socket, :showDialog, true)}
  end

  def handle_event("hideDialog", _params, socket) do
    {:noreply, assign(socket, :showDialog, false)}
  end

  def handle_event("showSnackbar", _params, socket) do
    {:noreply, assign(socket, :showSnack, true)}
  end

  def handle_event("hideSnackbar", _params, socket) do
    {:noreply, assign(socket, :showSnack, false)}
  end

  def handle_event("updateBottomSheet", value, socket) do
    {:noreply, assign(socket, :bottomSheetState, value)}
  end

  def handle_event("navigate", _params, socket) do
    {:noreply, push_navigate(socket, to: "/counter?val=#{socket.assigns.val}")}
  end

  def handle_event("navigateToGrid", _params, socket) do
    {:noreply, push_navigate(socket, to: "/sampleGrid")}
  end

  def handle_event("navigateToNavBar", _params, socket) do
    {:noreply, push_navigate(socket, to: "/sampleNavBar/1")}
  end

  def handle_event("navigateToTab", _params, socket) do
    {:noreply, push_navigate(socket, to: "/sampleTab")}
  end

  def handle_event("navigateToBottomSheetScaffold", _params, socket) do
    {:noreply, push_navigate(socket, to: "/sampleBottomSheetScaffold")}
  end

  def handle_event("redirect", _params, socket) do
    {:noreply, redirect(socket, to: "/counter")}
  end

  def handle_event("closeDrawer", _, socket) do
    {:noreply, assign(socket, :drawerIsOpen, false)}
  end

  def handle_event("openDrawer", _, socket) do
    {:noreply, assign(socket, :drawerIsOpen, true)}
  end

  @impl true
  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(%{platform_id: :jetpack} = assigns) do
    ~JETPACK"""
    <ModalNavigationDrawer is-open={"#{@drawerIsOpen}"} on-close="closeDrawer" on-open="openDrawer" gestures-enabled="true" scrim-color="#FF000000">
      <ModalDrawerSheet template="drawerContent" drawer-container-color="#FFFFFF00" drawer-content-color="#FFCCCCCC" drawer-shape="24" >
        <NavigationDrawerItem selected="true" phx-click="navigateToGrid" colors="{'selectedContainerColor': '#FF00FF00'}">
          <Icon image-vector="filled:Favorite" template="icon" />
          <Text template="label">Grid</Text>
          <Text template="badge">99+</Text>
        </NavigationDrawerItem>
        <NavigationDrawerItem selected="false" phx-click="navigate">
          <Icon image-vector="filled:AccountBox" template="icon" />
          <Text template="label">Counter</Text>
          <Box template="badge" clip="circle" background="#FFFF0000" content-alignment="center" size="28">
            <Text font-size="10" color="#FFFFFFFF">99+</Text>
          </Box>
        </NavigationDrawerItem>
        <NavigationDrawerItem selected="true" phx-click="navigateToNavBar" colors="{'selectedContainerColor': '#FF00FF00'}">
          <Icon image-vector="filled:Favorite" template="icon" />
          <Text template="label">NavBar</Text>
          <Text template="badge">99+</Text>
        </NavigationDrawerItem>
        <NavigationDrawerItem phx-click="navigateToTab">
          <Text template="label">Tab</Text>
        </NavigationDrawerItem>
        <NavigationDrawerItem phx-click="navigateToBottomSheetScaffold">
          <Text template="label">BottomSheetScaffold</Text>
        </NavigationDrawerItem>
      </ModalDrawerSheet>
    <Scaffold top-bar-scroll-behavior="enterAlways">
      <LargeTopAppBar template="topBar" colors="{'containerColor': '#FF0000FF', 'scrolledContainerColor': '#FFCCCCCC'}">
        <Text template="title">Hello</Text>
        <IconButton template="navigationIcon" phx-click="openDrawer">
          <Icon image-vector="filled:Menu" />
        </IconButton>
      </LargeTopAppBar>
      <ExtendedFloatingActionButton phx-click="inc" template="fab">
        <Icon image-vector="filled:Add" template="icon"/>
        <Text template="text">Increment</Text>
      </ExtendedFloatingActionButton>
      <Column template="body" width="fill" vertical-arrangement="center" horizontal-alignment="center" scroll="vertical">
        <Row>
          <Icon image-vector="filled:Add" />
          <Icon image-vector="rounded:Check" />
          <Icon image-vector="outlined:Home" />
          <Icon image-vector="sharp:Image" />
          <Icon image-vector="twoTone:Share" />
        </Row>
        <Row padding="16">
          <ElevatedCard weight="1" padding="4"><Text padding="16">Elevated Card</Text></ElevatedCard>
          <OutlinedCard weight="1" padding="4"><Text padding="16">Outlined Card</Text></OutlinedCard>
        </Row>
        <OutlinedButton phx-click="showDialog"><Text>Show Dialog</Text></OutlinedButton>
        <Box size="100" content-alignment="center">
          <BadgedBox container-color="#FF0000FF" content-color="#FFFF0000">
            <Text template="badge">+99</Text>
            <Icon image-vector="filled:Add" />
          </BadgedBox>
        </Box>
        <ElevatedButton phx-click="showSnackbar"><Text>Show Snackbar</Text></ElevatedButton>
        <FilledTonalButton phx-click="updateBottomSheet" phx-value="expanded"><Text>BottomSheet</Text></FilledTonalButton>
        <TextButton phx-click="showDialog"><Text>TextButton</Text></TextButton>
        <Text>Combobox option <%= @ddOption %></Text>
        <ExposedDropdownMenuBox horizontal-padding="16">
          <TextField phx-value={"#{@ddOption}"} width="fill" read-only="true" menu-anchor/>
          <DropdownMenuItem phx-click="setDDOption" phx-value="A" colors="{'textColor': '#FFFF0000', 'leadingIconColor': '#FF00FF00', 'trailingIconColor': '#FFFFFF00'}" enabled="false">
            <Text>Option A</Text>
            <Icon image-vector="filled:Add" template="trailingIcon" />
            <Icon image-vector="filled:ChevronLeft" template="leadingIcon"/>
          </DropdownMenuItem>
          <DropdownMenuItem phx-click="setDDOption" phx-value="B">
            <Text>Option B</Text>
          </DropdownMenuItem>
          <DropdownMenuItem phx-click="setDDOption" phx-value="C">
            <Text>Option C</Text>
          </DropdownMenuItem>
        </ExposedDropdownMenuBox>
        <CircularProgressIndicator color="#FFFF0000" track-color="#FF00FF00" stroke-cap="butt" />
        <LinearProgressIndicator color="#FFFF0000" track-color="#FF00FF00" stroke-cap="butt" padding="16" width="fill" />
        <Divider thickness="2" vertical-padding="8" color="#FFCCCCCC" />
        <Row vertical-alignment="center">
          <RadioButton phx-value="A" phx-change="setRadioOption" selected={"#{@radioOption == "A"}"} colors="{'selectedColor': '#FFFF0000', 'unselectedColor': '#FF00FF00'}" />
          <Text>A</Text>
          <RadioButton phx-value="B" phx-change="setRadioOption" selected={"#{@radioOption == "B"}"} colors="{'selectedColor': '#FFFF0000', 'unselectedColor': '#FF00FF00'}" />
          <Text>B</Text>
          <RadioButton phx-value="C" phx-change="setRadioOption" selected={"#{@radioOption == "C"}"} colors="{'selectedColor': '#FFFF0000', 'unselectedColor': '#FF00FF00'}"/>
          <Text>C</Text>
        </Row>
        <Divider thickness="1" vertical-padding="8" />
        <Row vertical-alignment="center">
          <CheckBox checked={"#{@isChecked}"} phx-change="toggleCheck" colors="{'checkedColor': '#FFFF0000', 'uncheckedColor': '#FF00FF00', 'checkmarkColor': '#FFFFFF00'}" />
          <Switch checked={"#{@isChecked}"} phx-change="toggleCheck" colors="{'checkedThumbColor': '#FFFF0000', 'checkedTrackColor': '#FF00FF00', 'checkedBorderColor': '#FF0000FF', 'uncheckedThumbColor': '#FFCCCCCC'}" />
          <Text>Checkbox value: <%= @isChecked %></Text>
        </Row>
        <Text><%= @userText %></Text>
        <TextField phx-value={"#{@userText}"} phx-change="setName" width="fill" padding="16" ime-action="search" capitalization="words" phx-click="inc" colors="{'focusedContainerColor': '#FFFF0000', 'focusedTextColor': '#FF00FF00'}">
          <Text template="label">Label</Text>
          <Text template="placeholder">Placeholder</Text>
          <Icon template="leadingIcon" image-vector="filled:Add" tint="#FFFF0000"/>
          <Icon template="trailingIcon" image-vector="filled:ChevronLeft"/>
          <Text template="prefix">Pre</Text>
          <Text template="suffix">Suf</Text>
          <Text template="supportingText">Supporting text</Text>
        </TextField>
        <OutlinedTextField phx-value={"#{@userText}"} phx-change="setName" width="fill" padding="16" ime-action="search" capitalization="words" phx-click="inc" colors="{'focusedBorderColor': '#FFFF0000', 'unfocusedBorderColor': '#FF0000FF'}">
          <Text template="label">Label</Text>
          <Text template="placeholder">Placeholder</Text>
          <Icon template="leadingIcon" image-vector="filled:Add" tint="#FFFF0000"/>
          <Icon template="trailingIcon" image-vector="filled:ChevronLeft"/>
          <Text template="prefix">Pre</Text>
          <Text template="suffix">Suf</Text>
          <Text template="supportingText">Supporting text</Text>
        </OutlinedTextField>
        <Column>
          <Text>Value: <%= @sliderValue %></Text>
          <Slider phx-value={@sliderValue} phx-change="setSliderValue" min-value="0" max-value="100" steps="5" phx-debounce="2000">
            <Box size="40" clip="4" background="#FFFF00FF" template="thumb"/>
            <Box width="fill" height="10" background="#FF0000FF" template="track"/>
          </Slider>
          <Slider phx-value={@sliderValue} phx-change="setSliderValue" min-value="0" max-value="100" steps="5" phx-debounce="2000" colors="{'thumbColor': '#FFFF0000', 'activeTrackColor': '#FF00FF00', 'activeTickColor': '#FF0000FF', 'inactiveTrackColor': '#FFFFFF00'}" />
          <Text>Range: Start = <%= Enum.at(@sliderRange,0) %> | End <%= Enum.at(@sliderRange,1) %></Text>
          <RangeSlider phx-value={Enum.join(@sliderRange, ",")} phx-change="setSliderRange" min-value="0" max-value="100" phx-debounce="300" />
        </Column>
        <Row width="fill" height="wrap" background="#FFCCCCCC">
          <Box weight="0.25" background="#FFFF0000" height="50" content-alignment="bottomEnd">
            <Text>25%</Text>
          </Box>
          <Box weight="0.35" background="#FF00FF00" height="50">
            <Text align="center">35%</Text>
          </Box>
          <Box weight="0.40" background="#FF0000FF" height="50">
            <Text align="center">40%</Text>
          </Box>
        </Row>
        <Row height="100" width="fill" background="#FFCCCCCC" horizontal-arrangement="spaceAround">
          <Box background="#FFFF0000" size="70" align="top">
            <Text align="center">Top</Text>
          </Box>
          <Box background="#FF00FF00" size="70" align="center">
            <Text align="center">Center</Text>
          </Box>
          <Box background="#FF0000FF" size="70" align="bottom">
            <Text align="center">Bottom</Text>
          </Box>
        </Row>
        <%= if @bottomSheetState != "hidden" do %>
        <ModalBottomSheet on-changed="updateBottomSheet" sheet-value={"#{@bottomSheetState}"}>
          <Column height="200" width="200" background="#FFCCCCCC">
            <Box background="#FFFF0000" size="70" align="top">
              <Text align="start">Start</Text>
            </Box>
            <Box background="#FF00FF00" size="70" align="center">
              <Text align="center">Center</Text>
            </Box>
            <Box background="#FF0000FF" size="70" align="end">
              <Text align="center">End</Text>
            </Box>
          </Column>
        </ModalBottomSheet>
        <% end %>
        <Column height="200" width="200" background="#FFCCCCCC">
          <Box background="#FFFF0000" width="fill" weight="25">
            <Text align="start">25%</Text>
          </Box>
          <Box background="#FF00FF00" width="fill" weight="35">
            <Text align="center">35%</Text>
          </Box>
          <Box background="#FF0000FF" width="fill" weight="40">
            <Text align="end">40%</Text>
          </Box>
        </Column>
        <Text style="headlineLarge" text="Title"/>
        <Card
          shape="8"
          padding="16"
          width="140"
          height="120"
          elevation="{'defaultElevation': '10', 'pressedElevation': '2'}"
          colors="{'containerColor': '#FFFF0000', 'contentColor': '#FF00FF00'}"
          phx-click="dec"
        >
          <Text padding="16">Hello Jetpack!</Text>
        </Card>
        <Spacer height="8" />
        <Card padding="16" colors="{'containerColor': '#CCCCCCCC', 'contentColor': '#FFFF0000'}">
          <Text padding="16">Simple card</Text>
        </Card>
        <Button
          padding="16"
          phx-click="navigate"
          content-padding="50"
          elevation="{'defaultElevation': '20', 'pressedElevation': '10'}"
        >
          <Text>Navigate to counter</Text>
        </Button>
        <Button phx-click="redirect"><Text>Redirect to counter</Text></Button>
        <IconButton phx-click="inc" colors="{'containerColor': '#FFFF0000', 'contentColor': '#FFF0000FF', 'disabledContainerColor': '#25ff0000'}" >
          <Icon image-vector="filled:Add" />
        </IconButton>
        <Row vertical-alignment="center">
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
        <Box size="100" background="#FFFF0000">
          <Icon image-vector="filled:Add" align="topStart"/>
          <Text align="center">Text</Text>
          <Icon image-vector="filled:Share" align="bottomEnd"/>
        </Box>
        <%= if @showDialog do %>
        <AlertDialog phx-click="hideDialog">
          <TextButton phx-click="hideDialog" template="confirm">
            <Text>Confirm</Text>
          </TextButton>
          <OutlinedButton phx-click="hideDialog" template="dismiss">
            <Text>Dismiss</Text>
          </OutlinedButton>
          <Icon image-vector="filled:Add" template="icon"/>
          <Text template="title">Alert Title</Text>
          <Text>Alert message</Text>
        </AlertDialog>
        <% end %>
      </Column>
      <%= if @showSnack do %>
      <Snackbar message="Hi there!" dismiss-event="hideSnackbar" />
      <% end %>
    </Scaffold>
    </ModalNavigationDrawer>
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
