defmodule ScratchboardWeb.SwiftUiModifiersLive do
  use Phoenix.LiveView
  use LiveViewNative.LiveView

  # alias ScratchboardWeb.Components.Modifiers.Animation
  # alias ScratchboardWeb.Components.Modifiers.ControlsAndIndicators
  # alias ScratchboardWeb.Components.Modifiers.Documents
  alias ScratchboardWeb.Components.Modifiers.DrawingAndGraphics
  # alias ScratchboardWeb.Components.Modifiers.Gestures
  alias ScratchboardWeb.Components.Modifiers.Images
  # alias ScratchboardWeb.Components.Modifiers.InputEvents
  # alias ScratchboardWeb.Components.Modifiers.LayoutAdjustments
  alias ScratchboardWeb.Components.Modifiers.LayoutFundamentals
  # alias ScratchboardWeb.Components.Modifiers.Lists
  # alias ScratchboardWeb.Components.Modifiers.ModalPresentations
  # alias ScratchboardWeb.Components.Modifiers.Navigation
  # alias ScratchboardWeb.Components.Modifiers.ScrollViews
  # alias ScratchboardWeb.Components.Modifiers.Search
  alias ScratchboardWeb.Components.Modifiers.TextInputAndOutput
  # alias ScratchboardWeb.Components.Modifiers.Toolbar
  alias ScratchboardWeb.Components.Modifiers.ViewConfiguration
  # alias ScratchboardWeb.Components.Modifiers.ViewFundamentals
  # alias ScratchboardWeb.Components.Modifiers.ViewStyles

  @tabs %{
    "Aspect Ratio" => &DrawingAndGraphics.aspect_ratio/1,
    "Background" => &LayoutFundamentals.background/1,
    "Blend Mode" => &DrawingAndGraphics.blend_mode/1,
    "Bold" => &TextInputAndOutput.bold_and_italic/1,
    "Border" => &DrawingAndGraphics.border/1,
    "Disabled" => &ViewConfiguration.disabled/1,
    "Dynamic Type Size" => &TextInputAndOutput.dynamic_type_size/1,
    "Font Design" => &TextInputAndOutput.font_design/1,
    "Foreground Color" => &DrawingAndGraphics.foreground_color/1,
    "Foreground Style" => &DrawingAndGraphics.foreground_style/1,
    "Font Weight" => &TextInputAndOutput.font_weight/1,
    "Hidden" => &ViewConfiguration.hidden/1,
    "Image Scale" => &Images.image_scale/1,
    "Italic" => &TextInputAndOutput.bold_and_italic/1,
    "Mask" => &DrawingAndGraphics.mask/1,
    "Monospaced" => &TextInputAndOutput.monospaced/1,
    "Opacity" => &ViewConfiguration.opacity/1,
    "Preferred Color Scheme" => &ViewConfiguration.preferred_color_scheme/1,
    "Text Case" => &TextInputAndOutput.text_case/1,
    "Text Field" => &TextInputAndOutput.text_field/1,
    "Tint" => &DrawingAndGraphics.tint/1,
    "Z Index" => &LayoutFundamentals.z_index/1,
  }

  native_binding :selected_tab, String, "Bold"

  @impl true
  def render(%{platform_id: :swiftui} = assigns) do
  ~Z"""
  <VStack modifiers={@native |> navigation_title(title: "SwiftUITestBed")}>
    <Spacer />
    <%= case Map.get(@tabs, @selected_tab) do %>
      <% nil -> %>
        <% nil %>

      <% component -> %>
        <VStack id={@selected_tab}>
          <%= apply(component, [%{native: @native, platform_id: :swiftui, tick: @tick}]) %>
        </VStack>
    <% end %>
    <Spacer />
    <Picker value-binding="selected_tab" picker-style="automatic" selection={@selected_tab}>
      <Text template={:label}>Section</Text>
      <Group template={:content}>
        <%= for {tab, component} <- @tabs do %>
          <Label id={tab} modifiers={~s([{"type": "tag", "value": "#{tab}"}])}>
            <Text><%= tab %></Text>
          </Label>
        <% end %>
      </Group>
    </Picker>
  </VStack>
  """swiftui
  end

  @impl true
  def render(assigns) do
  ~H"""
  <div>This page is only supported by SwiftUI.</div>
  """
  end

  @impl true
  def mount(_params, _session, socket) do
    Process.send_after(self(), :tick, 1_000)

    {:ok, assign(socket,
      selected_tab: "Bold",
      tabs: @tabs,
      tick: :tick,
    )}
  end

  @impl true
  def handle_info(:tick, socket) do
    Process.send_after(self(), :tick, 1_000)

    case socket.assigns.tick do
      :tick ->
        {:noreply, assign(socket, tick: :tock)}

      _ ->
        {:noreply, assign(socket, tick: :tick)}
    end
  end
end
