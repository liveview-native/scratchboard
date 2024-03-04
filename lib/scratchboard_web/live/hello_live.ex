defmodule ScratchboardWeb.HelloLive do
  use Phoenix.LiveView
  use LiveViewNative.LiveView

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:val, 0) |> assign(:userText, "abc") |> assign(:sliderValue, 30) |> assign(:sliderRange, [10, 90]) |> assign(:isChecked, true) |> assign(:radioOption, "A") |> assign(:ddOption, "A") |> assign(:showDialog, false) |> assign(:showSnack, false) |> assign(:drawerIsOpen, false) |> assign(:bottomSheetState, "hidden")}
  end

  def handle_event("inc", _, socket) do
    {:noreply, update(socket, :val, &(&1 + 1))}
  end

  def handle_event("dec", _, socket) do
    {:noreply, update(socket, :val, &(&1 - 1))}
  end

  def handle_event("setName", %{"value" => name, "foo" => _}, socket) do
    {:noreply, assign(socket, :userText, name)}
  end

  def handle_event("setSliderValue", %{"value" => value, "foo" => _}, socket) do
    {:noreply, assign(socket, :sliderValue, value)}
  end

  def handle_event("setSliderRange", %{"value" => value, "foo" => _}, socket) do
    {:noreply, assign(socket, :sliderRange, value)}
  end

  def handle_event("toggleCheck",  %{"checked" => newValue}, socket) do
    {:noreply, assign(socket, :isChecked, newValue)}
  end

  def handle_event("setRadioOption", %{"value" => value, "foo" => _}, socket) do
    {:noreply, assign(socket, :radioOption, value)}
  end

  def handle_event("setDDOption", %{"value" => newValue, "foo" => _}, socket) do
    {:noreply, assign(socket, :ddOption, newValue)}
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

  def handle_event("updateBottomSheet", %{"sheetValue" => sheetValue, "value" => _}, socket) do
    {:noreply, assign(socket, :bottomSheetState, sheetValue)}
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

  def handle_event("onDrawerChange", %{"isOpen" => isOpen, "value" => _}, socket) do
    {:noreply, assign(socket, :drawerIsOpen, isOpen)}
  end

  @impl true
  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(%{platform_id: :jetpack} = assigns) do
    style = """
    %{"my-class" => [
      {:height, [file: "home_styles.ex", line: 49, module: "HomeStyles", source: "height(100)"], [100]},
      {:fillMaxWidth, [file: "home_styles.ex", line: 50, module: HomeStyles, source: "fillMaxWidth()" ], []},
      {:background, [file: "home_styles.ex", line: 51, module: HomeStyles, source: "background(Color.red, RoundedCornerShape(4, 0, 8, 0))"], [{:., [], [:Color, :red]}, {:RoundedCornerShape, [file: "home_styles.ex", line: 51, module: HomeStyles, source: "background(Color.red, RoundedCornerShape(32, 4, 24, 8))"], [4, 0, 8, 0]} ]}
      ]}
    """

    ~JETPACK"""
    <DismissibleNavigationDrawer isOpen={"#{@drawerIsOpen}"} phx-change="onDrawerChange" phx-value="drawer" gesturesEnabled="true" scrimColor="#FF000000">
      <DismissibleDrawerSheet template="drawerContent" drawerContainerColor="#FFFFFF00" drawerContentColor="#FFCCCCCC" drawerShape="24" >
        <NavigationDrawerItem selected="true" phx-click="navigateToGrid" phx-value-nelson="true" colors="{'selectedContainerColor': '#FF00FF00'}">
          <Icon imageVector="filled:Favorite" template="icon" />
          <Text template="label">Grid</Text>
          <Text template="badge">99+</Text>
        </NavigationDrawerItem>
        <NavigationDrawerItem selected="false" phx-click="navigate">
          <Icon imageVector="filled:AccountBox" template="icon" />
          <Text template="label">Counter</Text>
          <Box template="badge" clip="circle" background="#FFFF0000" contentAlignment="center" size="28">
            <Text fontSize="10" color="#FFFFFFFF">99+</Text>
          </Box>
        </NavigationDrawerItem>
        <NavigationDrawerItem selected="true" phx-click="navigateToNavBar" colors="{'selectedContainerColor': '#FF00FF00'}">
          <Icon imageVector="filled:Favorite" template="icon" />
          <Text template="label">NavBar</Text>
          <Text template="badge">99+</Text>
        </NavigationDrawerItem>
        <NavigationDrawerItem phx-click="navigateToTab">
          <Text template="label">Tab</Text>
        </NavigationDrawerItem>
        <NavigationDrawerItem phx-click="navigateToBottomSheetScaffold">
          <Text template="label">BottomSheetScaffold</Text>
        </NavigationDrawerItem>
      </DismissibleDrawerSheet>
    <Scaffold topBarScrollBehavior="enterAlways">
      <LargeTopAppBar template="topBar" colors="{'containerColor': '#FF0000FF', 'scrolledContainerColor': '#FFCCCCCC'}">
        <Text template="title">Hello</Text>
        <IconButton template="navigationIcon" phx-click="onDrawerChange" phx-value-isOpen="true" phx-value={"#{@val}"}>
          <Icon imageVector="filled:Menu" />
        </IconButton>
      </LargeTopAppBar>
      <ExtendedFloatingActionButton phx-click="inc" template="fab" phx-value-foo="bar">
        <Icon imageVector="filled:Add" template="icon"/>
        <Text template="text">Increment</Text>
      </ExtendedFloatingActionButton>
      <Column template="body" width="fill" verticalArrangement="center" horizontalAlignment="centerHorizontally" scroll="vertical">
        <Row phx-click="showSnackbar" phx-value="xpto" phx-value-foo="foo">
          <Icon imageVector="filled:Add" />
          <Icon imageVector="rounded:Check" />
          <Icon imageVector="outlined:Home" />
          <Icon imageVector="sharp:Image" />
          <Icon imageVector="twoTone:Share" />
        </Row>
        <Box class={"#{style}"} />
        <Text fontFamily="Lobster Two">Teste</Text>
        <Row padding="16">
          <TooltipBox weight="1" padding="4" initialIsVisible="true" isPersistent="true">
            <RichTooltip template="tooltip">
              <Text template="title">Title</Text>
              <Text template="text">Text</Text>
              <Button template="action" phx-click="showSnackbar" phx-value="xpto" phx-value-foo="foo"><Text>Action</Text></Button>
            </RichTooltip>
            <ElevatedCard template="content" phx-click="showSnackbar" phx-value="foo"><Text padding="16">Elevated Card</Text></ElevatedCard>
          </TooltipBox>
          <OutlinedCard weight="1" padding="4"><Text padding="16">Outlined Card</Text></OutlinedCard>
        </Row>
        <OutlinedButton phx-click="showDialog"><Text>Show Dialog</Text></OutlinedButton>
        <Box size="100" contentAlignment="center">
          <BadgedBox containerColor="#FF0000FF" contentColor="#FFFF0000" phx-click="inc" phx-value={"#{@val}"} phx-value-foo="bar">
            <Text template="badge"><%= @val %></Text>
            <Icon imageVector="filled:Add" />
          </BadgedBox>
        </Box>
        <ElevatedButton phx-click="showSnackbar"><Text>Show Snackbar</Text></ElevatedButton>
        <FilledTonalButton phx-click="updateBottomSheet" phx-value-sheetValue="expanded" phx-value="foo"><Text>BottomSheet</Text></FilledTonalButton>
        <TextButton phx-click="showDialog"><Text>TextButton</Text></TextButton>
        <Text>Combobox option <%= @ddOption %></Text>
        <ExposedDropdownMenuBox horizontalPadding="16">
          <TextField phx-value={"#{@ddOption}"} width="fill" readOnly="true" menuAnchor/>
          <ExposedDropdownMenu onDismissRequest="hideDialog" phx-value="foo">
            <DropdownMenuItem phx-click="setDDOption" phx-value="A" phx-value-foo="AA" colors="{'textColor': '#FFFF0000', 'leadingIconColor': '#FF00FF00', 'trailingIconColor': '#FFFFFF00'}">
              <Text>Option A</Text>
              <Icon imageVector="filled:Add" template="trailingIcon" />
              <Icon imageVector="filled:ChevronLeft" template="leadingIcon"/>
            </DropdownMenuItem>
            <DropdownMenuItem phx-click="setDDOption" phx-value="B" phx-value-foo="BB">
              <Text>Option B</Text>
            </DropdownMenuItem>
            <DropdownMenuItem phx-click="setDDOption" phx-value="C" phx-value-foo="CC">
              <Text>Option C</Text>
            </DropdownMenuItem>
          </ExposedDropdownMenu>
        </ExposedDropdownMenuBox>
        <CircularProgressIndicator color="#FFFF0000" trackColor="#FF00FF00" strokeCap="butt" />
        <LinearProgressIndicator color="#FFFF0000" trackColor="#FF00FF00" strokeCap="butt" padding="16" width="fill" />
        <HorizontalDivider thickness="2" verticalPadding="8" color="#FFCCCCCC" />
        <Row verticalAlignment="center">
          <RadioButton phx-value="A" phx-value-foo="fooA" phx-change="setRadioOption" selected={"#{@radioOption == "A"}"} colors="{'selectedColor': '#FFFF0000', 'unselectedColor': '#FF00FF00'}" />
          <Text>A</Text>
          <RadioButton phx-value="B" phx-value-foo="fooB" phx-change="setRadioOption" selected={"#{@radioOption == "B"}"} colors="{'selectedColor': '#FFFF0000', 'unselectedColor': '#FF00FF00'}" />
          <Text>B</Text>
          <RadioButton phx-value="C" phx-value-foo="fooC" phx-change="setRadioOption" selected={"#{@radioOption == "C"}"} colors="{'selectedColor': '#FFFF0000', 'unselectedColor': '#FF00FF00'}"/>
          <Text>C</Text>
        </Row>
        <HorizontalDivider thickness="1" verticalPadding="8" />
        <Row verticalAlignment="center">
          <CheckBox checked={"#{@isChecked}"} enabled={"#{@val < 5}"} phx-change="toggleCheck" colors="{'checkedColor': '#FFFF0000', 'uncheckedColor': '#FF00FF00', 'checkmarkColor': '#FFFFFF00'}" />
          <Switch checked={"#{@isChecked}"} phx-change="toggleCheck" colors="{'checkedThumbColor': '#FFFF0000', 'checkedTrackColor': '#FF00FF00', 'checkedBorderColor': '#FF0000FF', 'uncheckedThumbColor': '#FFCCCCCC'}" />
          <Text>Checkbox value: <%= @isChecked %></Text>
        </Row>
        <Text><%= @userText %></Text>
        <TextField phx-value={"#{@userText}"} phx-value-foo="bar" phx-change="setName" width="fill" padding="16" imeAction="search" capitalization="words" phx-click="inc" colors="{'focusedContainerColor': '#FFFF0000', 'focusedTextColor': '#FF00FF00'}">
          <Text template="label">Label</Text>
          <Text template="placeholder">Placeholder</Text>
          <Icon template="leadingIcon" imageVector="filled:Add" tint="#FFFF0000"/>
          <Icon template="trailingIcon" imageVector="filled:ChevronLeft"/>
          <Text template="prefix">Pre</Text>
          <Text template="suffix">Suf</Text>
          <Text template="supportingText">Supporting text</Text>
        </TextField>
        <OutlinedTextField phx-value={"#{@userText}"} phx-value-foo="bar" phx-change="setName" width="fill" padding="16" imeAction="search" capitalization="words" phx-click="inc" colors="{'focusedBorderColor': '#FFFF0000', 'unfocusedBorderColor': '#FF0000FF'}">
          <Text template="label">Label</Text>
          <Text template="placeholder">Placeholder</Text>
          <Icon template="leadingIcon" imageVector="filled:Add" tint="#FFFF0000"/>
          <Icon template="trailingIcon" imageVector="filled:ChevronLeft"/>
          <Text template="prefix">Pre</Text>
          <Text template="suffix">Suf</Text>
          <Text template="supportingText">Supporting text</Text>
        </OutlinedTextField>
        <Column>
          <Text>Value: <%= @sliderValue %></Text>
          <Slider phx-value={@sliderValue} phx-value-foo="bar1" phx-change="setSliderValue" minValue="0" maxValue="100" steps="5" phx-debounce="2000">
            <Box size="40" clip="4" background="#FFFF00FF" template="thumb"/>
            <Box width="fill" height="10" background="#FF0000FF" template="track"/>
          </Slider>
          <Slider phx-value={@sliderValue} phx-value-foo="bar2" phx-change="setSliderValue" minValue="0" maxValue="100" steps="5" phx-debounce="2000" colors="{'thumbColor': '#FFFF0000', 'activeTrackColor': '#FF00FF00', 'activeTickColor': '#FF0000FF', 'inactiveTrackColor': '#FFFFFF00'}" />
          <Text>Range: Start = <%= Enum.at(@sliderRange,0) %> | End <%= Enum.at(@sliderRange,1) %></Text>
          <RangeSlider phx-value={Enum.join(@sliderRange, ",")} phx-value-foo="range" phx-change="setSliderRange" minValue="0" maxValue="100" phx-debounce="300" />
        </Column>
        <Row width="fill" height="wrap" background="#FFCCCCCC">
          <Box weight="0.25" background="#FFFF0000" height="50" contentAlignment="bottomEnd">
            <Text>25%</Text>
          </Box>
          <Box weight="0.35" background="#FF00FF00" height="50">
            <Text align="center">35%</Text>
          </Box>
          <Box weight="0.40" background="#FF0000FF" height="50">
            <Text align="center">40%</Text>
          </Box>
        </Row>
        <Row height="100" width="fill" background="#FFCCCCCC" horizontalArrangement="spaceAround">
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
        <ModalBottomSheet onChanged="updateBottomSheet" phx-value="foo">
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
          contentPadding="50"
          elevation="{'defaultElevation': '20', 'pressedElevation': '10'}"
        >
          <Text>Navigate to counter</Text>
        </Button>
        <Button phx-click="redirect"><Text>Redirect to counter</Text></Button>
        <IconButton phx-click="inc" phx-value-foo="bar" colors="{'containerColor': '#FFFF0000', 'contentColor': '#FFF0000FF', 'disabledContainerColor': '#25ff0000'}" >
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
        <Box size="100" background="#FFFF0000">
          <Icon imageVector="filled:Add" align="topStart"/>
          <Text align="center">Text</Text>
          <Icon imageVector="filled:Share" align="bottomEnd"/>
        </Box>
        <%= if @showDialog do %>
        <AlertDialog onDismissRequest="hideDialog" phx-value="foo" phx-value-mydialog="dialog">
          <TextButton phx-click="hideDialog" template="confirm">
            <Text>Confirm</Text>
          </TextButton>
          <OutlinedButton phx-click="hideDialog" template="dismiss" border="{'width': 2, 'color': 'system-red'}">
            <Text>Dismiss</Text>
          </OutlinedButton>
          <Icon imageVector="filled:Add" template="icon"/>
          <Text template="title">Alert Title</Text>
          <Text>Alert message</Text>
        </AlertDialog>
        <% end %>
      </Column>
      <%= if @showSnack do %>
      <Snackbar message="Hi there!" dismissEvent="hideSnackbar" />
      <% end %>
    </Scaffold>
    </DismissibleNavigationDrawer>
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
