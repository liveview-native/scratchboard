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
    "Aspect Ratio" => &DrawingAndGraphics.aspect_ratio_modifier/1,
    "Background" => &LayoutFundamentals.background_modifier/1,
    "Blend Mode" => &DrawingAndGraphics.blend_mode_modifier/1,
    "Bold" => &TextInputAndOutput.bold_and_italic_modifier/1,
    "Border" => &DrawingAndGraphics.border_modifier/1,
    "Disabled" => &ViewConfiguration.disabled_modifier/1,
    "Dynamic Type Size" => &TextInputAndOutput.dynamic_type_size_modifier/1,
    "Font Design" => &TextInputAndOutput.font_design_modifier/1,
    "Foreground Color" => &DrawingAndGraphics.foreground_color_modifier/1,
    "Foreground Style" => &DrawingAndGraphics.foreground_style_modifier/1,
    "Font Weight" => &TextInputAndOutput.font_weight_modifier/1,
    "Hidden" => &ViewConfiguration.hidden_modifier/1,
    "Image Scale" => &Images.image_scale_modifier/1,
    "Italic" => &TextInputAndOutput.bold_and_italic_modifier/1,
    "Mask" => &DrawingAndGraphics.mask_modifier/1,
    "Monospaced" => &TextInputAndOutput.monospaced_modifier/1,
    "Opacity" => &ViewConfiguration.opacity_modifier/1,
    "Preferred Color Scheme" => &ViewConfiguration.preferred_color_scheme_modifier/1,
    # "Swipe Actions" => &Lists.swipe_actions_modifier/1,
    "Text Case" => &TextInputAndOutput.text_case_modifier/1,
    "Text Field" => &TextInputAndOutput.text_field_modifier/1,
    "Tint" => &DrawingAndGraphics.tint_modifier/1,
    "Z Index" => &LayoutFundamentals.z_index_modifier/1
  }

  native_binding :selected_tab, String, "Bold"

  @impl true
  def render(%{platform_id: :swiftui} = assigns) do
  ~SWIFTUI"""
  <VStack modifiers={@native |> navigation_title(title: "SwiftUI Test Bed")}>
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
        <%= for {tab, _component} <- @tabs do %>
          <Label id={tab} modifiers={~s([{"type": "tag", "value": "#{tab}"}])}>
            <Text><%= tab %></Text>
          </Label>
        <% end %>
      </Group>
    </Picker>
  </VStack>
  """
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
      tick: :tick
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
