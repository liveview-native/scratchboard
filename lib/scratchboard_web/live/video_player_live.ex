defmodule ScratchboardWeb.VideoPlayerLive do
  use Phoenix.LiveView
  use LiveViewNative.LiveView

  native_binding :is_muted, Atom, false
  native_binding :time_control_status, String, ""
  native_binding :playback_time, Float, 0.0

  @impl true
  def render(%{platform_id: :swiftui} = assigns) do
    ~SWIFTUI"""
    <VStack id="webview-example">
      <VStack>
        <%= @playback_time %>
      </VStack>
      <VideoPlayer
        autoplay="true"
        is-muted="is_muted"
        playback-time="playback_time"
        playback-time-update-interval="0.5"
        on-play="handle_play"
        on-pause="handle_pause"
        time-control-status="time_control_status"
        url="http://192.168.1.143:4000/videos/sample2.mp4"
        volume="volume" />
      <VStack>
        <%= time_control_status_display(assigns) %>
        <%= muted_display(assigns) %>
        <Button phx-click="randomize_playback_time">
          Randomize Playback Time
        </Button>
      </VStack>
    </VStack>
    """
  end

  def muted_display(assigns) do
    ~SWIFTUI"""
    <HStack>
      <%= if @is_muted do %>
        <Image system-name="speaker.slash"></Image>
        <Text>Muted</Text>
      <% else %>
        <Image system-name="speaker"></Image>
        <Text>Not Muted</Text>
      <% end %>
    </HStack>
    """
  end

  def time_control_status_display(assigns) do
    ~SWIFTUI"""
    <HStack>
      <%= case @time_control_status do %>
        <% "playing" -> %>
          <Button phx-click="pause">
            <Image system-name="pause.fill"></Image>
            <Label>Pause</Label>
          </Button>

        <% "paused" -> %>
          <Button phx-click="play">
            <Image system-name="play.fill"></Image>
            <Label>Play</Label>
          </Button>

        <% _ -> %>
          <Button>
            <Image system-name="hourglass"></Image>
            <Label>Loading</Label>
        </Button>
      <% end %>
    </HStack>
    """
  end

  def handle_event("handle_play", _params, socket) do
    IO.puts "Now playing..."

    {:noreply, socket}
  end

  def handle_event("handle_pause", _params, socket) do
    IO.puts "Now paused."

    {:noreply, socket}
  end

  def handle_event("randomize_playback_time", _params, socket) do
    {:noreply, push_event(socket, "seek", %{playback_time: :rand.uniform(30) + :rand.uniform()})}
  end

  def handle_event("play", _params, socket) do
    {:noreply, push_event(socket, "play", %{})}
  end

  def handle_event("pause", _params, socket) do
    {:noreply, push_event(socket, "pause", %{})}
  end
end
