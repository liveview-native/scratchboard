defmodule ScratchboardWeb.HelloLive do
  use Phoenix.LiveView
  use LiveViewNative.LiveView

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:val, 0) |> assign(:userText, "") |> assign(:sliderValue, 0) }
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
      <TopAppBar>
        <Title><Text>Hello</Text></Title>
      </TopAppBar>
      <FloatingActionButton phx-click="inc">
        <Icon imageVector="filled:Add" />
      </FloatingActionButton>
      <Column width="fill" verticalArrangement="center" horizontalAlignment="center" scroll="vertical">
        <Image resource="android_icon" height="96" background="#FFFF00FF" width="fill" alignment="centerEnd"/>
        <Text><%= @userText %></Text>
        <TextField text={"#{@userText}"} phx-change="setName" width="fill" padding="16" imeAction="search" capitalization="words" phx-click="inc">
          <Label><Text>Label</Text></Label>
          <Placeholder><Text>Placeholder</Text></Placeholder>
          <TrailingIcon imageVector="filled:Add"/>
          <LeadingIcon imageVector="filled:Send"/>
          <Prefix><Text>Pre</Text></Prefix>
          <Suffix><Text>Suf</Text></Suffix>
          <SupportingText>Supporting text</SupportingText>
        </TextField>
        <Column>
          <Text>Value: <%= @sliderValue %></Text>
          <Slider value={"#{@sliderValue}"} phx-change="setSliderValue" minValue="0" maxValue="100" steps="5" phx-debounce="2000"/>
        </Column>
        <Row width="fill" height="wrap" background="#FFCCCCCC">
          <Box weight="0.25" background="#FFFF0000" height="50">
            <Text align="center">25%</Text>
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
