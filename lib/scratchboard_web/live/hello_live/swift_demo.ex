defmodule ScratchboardWeb.SwiftDemoLive do
  use Phoenix.LiveView
  use LiveViewNative.LiveView

  @tabs %{
    "aspect_ratio" => "Aspect Ratio",
    "background" => "Background",
    "bold" => "Bold",
    "disabled" => "Disabled",
    "dynamic_type_size" => "Dynamic Type Size",
    "font_weight" => "Font Weight",
    "foreground_style" => "Foreground Style",
    "italic" => "Italic",
    "monospaced" => "Monospaced",
    "offset" => "Offset",
    "opacity" => "Opacity",
    "text_case" => "Text Case",
    "tint" => "Tint"
  }

  native_binding :selected_tab, String, "font_weight"

  @impl true
  def render(assigns) do
    render_native(assigns)
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, selected_tab: "font_weight", tabs: @tabs)}
  end
end
