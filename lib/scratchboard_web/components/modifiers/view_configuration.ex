defmodule ScratchboardWeb.Components.Modifiers.ViewConfiguration do
  @moduledoc false
  use Phoenix.Component
  use LiveViewNative.Component

  def disabled_modifier(%{platform_id: :swiftui} = assigns) do
    ~SWIFTUI"""
    <VStack id="disabled">
      <Button modifiers={disabled(@native, disabled: true)}>
        <Label>This button is disabled</Label>
      </Button>
      <Button modifiers={disabled(@native, disabled: false)}>
        <Label>This button is not</Label>
      </Button>
    </VStack>
    """
  end

  def hidden_modifier(%{platform_id: :swiftui} = assigns) do
    ~SWIFTUI"""
    <VStack id="hidden">
      <Text modifiers={hidden(@native, is_active: @tick == :tick)}>
        This text will hide and show every second
      </Text>
    </VStack>
    """
  end

  def opacity_modifier(%{platform_id: :swiftui} = assigns) do
    ~SWIFTUI"""
    <VStack id="opacity">
      <Text>This text has full opacity</Text>
      <Text modifiers={opacity(@native, opacity: 0.75)}>This text has 3/4 opacity</Text>
      <Text modifiers={opacity(@native, opacity: 0.5)}>This text has 1/2 opacity</Text>
      <Text modifiers={opacity(@native, opacity: 0.25)}>This text has 1/4 opacity</Text>
    </VStack>
    """
  end

  def preferred_color_scheme_modifier(%{platform_id: :swiftui} = assigns) do
    ~SWIFTUI"""
    <VStack id="preferred_color_scheme" modifiers={preferred_color_scheme(@native, color_scheme: :light)}>
      <Text>This view will present in light mode, regardless of the system setting.</Text>
    </VStack>
    """
  end
end
