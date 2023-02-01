defmodule ScratchboardWeb.SwiftUI.Modifiers.Background do
  use LiveViewNativePlatform.Modifier

  modifier_schema "background" do
    field :color, :string
  end
end
