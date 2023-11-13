defmodule ScratchboardWeb.HelloLive do
  use Phoenix.LiveView
  use LiveViewNative.LiveView

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:val, 0) |> assign(:userText, "") |> assign(:sliderValue, 0) |> assign(:isChecked, true) |> assign(:radioOption, "A") |> assign(:ddOption, "A") |> assign(:showDialog, false) |> assign(:showSnack, false)}
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

  def handle_event("navigate", _params, socket) do
    {:noreply, push_navigate(socket, to: "/counter?val=#{socket.assigns.val}")}
  end

  def handle_event("redirect", _params, socket) do
    {:noreply, redirect(socket, to: "/counter")}
  end

  @impl true
  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(%{platform_id: :jetpack} = assigns) do
    ~JETPACK"""
    <Scaffold>
      <TopAppBar template="topBar">
        <Text template="title">Hello</Text>
      </TopAppBar>
      <FloatingActionButton phx-click="inc" template="fab">
        <Icon imageVector="filled:Add" />
      </FloatingActionButton>
      <Column template="body" width="fill" verticalArrangement="center" horizontalAlignment="center" scroll="vertical">
        <Row padding="16">
          <ElevatedCard weight="1" padding="4"><Text padding="16">Elevated Card</Text></ElevatedCard>
          <OutlinedCard weight="1" padding="4"><Text padding="16">Outlined Card</Text></OutlinedCard>
        </Row>
        <OutlinedButton phx-click="showDialog"><Text>Show Dialog</Text></OutlinedButton>
        <Box size="100" contentAlignment="center">
          <BadgeBox containerColor="#FF0000FF" contentColor="#FFFF0000">
            <Badge><Text>+99</Text></Badge>
            <Icon imageVector="filled:Add" />
          </BadgeBox>
        </Box>
        <ElevatedButton phx-click="showSnackbar"><Text>Show Snackbar</Text></ElevatedButton>
        <FilledTonalButton phx-click="showDialog"><Text>FilledTonalButton</Text></FilledTonalButton>
        <TextButton phx-click="showDialog"><Text>TextButton</Text></TextButton>
        <Text>Combobox option <%= @ddOption %></Text>
        <ExposedDropDownMenuBox horizontalPadding="16">
          <TextField text={"#{@ddOption}"} width="fill" readOnly="true" menuAnchor/>
          <DropDownMenuItem phx-click="setDDOption" value="A">
            <Text>Option A</Text>
            <Icon imageVector="filled:Add" template="trailingIcon" />
            <Icon imageVector="filled:ChevronLeft" template="leadingIcon"/>
          </DropDownMenuItem>
          <DropDownMenuItem phx-click="setDDOption" value="B" enabled="false">
            <Text>Option B</Text>
          </DropDownMenuItem>
          <DropDownMenuItem phx-click="setDDOption" value="C">
            <Text>Option C</Text>
          </DropDownMenuItem>
        </ExposedDropDownMenuBox>
        <CircularProgressIndicator color="#FFFF0000" trackColor="#FF00FF00" strokeCap="butt" />
        <LinearProgressIndicator color="#FFFF0000" trackColor="#FF00FF00" strokeCap="butt" padding="16" width="fill" />
        <Divider thickness="2" verticalPadding="8" color="#FFCCCCCC" />
        <Row verticalAlignment="center">
          <RadioButton value="A" phx-change="setRadioOption" selected={"#{@radioOption == "A"}"} colors="{'selectedColor': '#FFFF0000', 'unselectedColor': '#FF00FF00'}" />
          <Text>A</Text>
          <RadioButton value="B" phx-change="setRadioOption" selected={"#{@radioOption == "B"}"} colors="{'selectedColor': '#FFFF0000', 'unselectedColor': '#FF00FF00'}" />
          <Text>B</Text>
          <RadioButton value="C" phx-change="setRadioOption" selected={"#{@radioOption == "C"}"} colors="{'selectedColor': '#FFFF0000', 'unselectedColor': '#FF00FF00'}"/>
          <Text>C</Text>
        </Row>
        <Divider thickness="1" verticalPadding="8" />
        <Row verticalAlignment="center">
          <CheckBox checked={"#{@isChecked}"} phx-change="toggleCheck" />
          <Switch checked={"#{@isChecked}"} phx-change="toggleCheck" />
          <Text>Checkbox value: <%= @isChecked %></Text>
        </Row>
        <Image resource="android_icon" height="96" background="#FFFF00FF" width="fill" alignment="centerEnd"/>
        <Text><%= @userText %></Text>
        <TextField text={"#{@userText}"} phx-change="setName" width="fill" padding="16" imeAction="search" capitalization="words" phx-click="inc">
          <Text template="label">Label</Text>
          <Text template="placeholder">Placeholder</Text>
          <Icon template="leadingIcon" imageVector="filled:Add" tint="#FFFF0000"/>
          <Icon template="trailingIcon" imageVector="filled:ChevronLeft"/>
          <Text template="prefix">Pre</Text>
          <Text template="suffix">Suf</Text>
          <Text template="supportingText">Supporting text</Text>
        </TextField>
        <Column>
          <Text>Value: <%= @sliderValue %></Text>
          <Slider value={"#{@sliderValue}"} phx-change="setSliderValue" minValue="0" maxValue="100" steps="5" phx-debounce="2000"/>
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
          phx-click="dec"
        >
          <Text padding="16">Hello Jetpack!</Text>
        </Card>
        <Spacer height="8" />
        <Card padding="16">
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
        <Box size="100" background="#FFFF0000">
          <Icon imageVector="filled:Add" align="topStart"/>
          <Text align="center">Text</Text>
          <Icon imageVector="filled:Share" align="bottomEnd"/>
        </Box>
        <%= if @showDialog do %>
        <AlertDialog phx-click="hideDialog">
          <TextButton phx-click="hideDialog" template="confirm">
            <Text>Confirm</Text>
          </TextButton>
          <OutlinedButton phx-click="hideDialog" template="dismiss">
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
