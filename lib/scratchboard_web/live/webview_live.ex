defmodule ScratchboardWeb.WebviewLive do
  use Phoenix.LiveView
  use LiveViewNative.LiveView

  @impl true
  def render(%{platform_id: :swiftui} = assigns) do
    ~SWIFTUI"""
    <VStack id="webview-example">
      <WebView url="http://localhost:4000/counter" />
    </VStack>
    """
  end
end
