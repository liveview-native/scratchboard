defmodule ScratchboardWeb.Components.Modifiers.ViewConfiguration do
  @moduledoc false
  use Phoenix.Component
  use LiveViewNative.Component

  def disabled(%{platform_id: :swiftui} = assigns) do
    ~Z"""
    <VStack id="disabled">
      <Button modifiers={disabled(@native, disabled: true)}>
        <Label>This button is disabled</Label>
      </Button>
      <Button modifiers={disabled(@native, disabled: false)}>
        <Label>This button is not</Label>
      </Button>
    </VStack>
    """swiftui
  end

  def hidden(%{platform_id: :swiftui} = assigns) do
    ~Z"""
    <VStack id="hidden">
      <Text modifiers={hidden(@native, is_active: @tick == :tick)}>
        This text will hide and show every second
      </Text>
    </VStack>
    """swiftui
  end

  def opacity(%{platform_id: :swiftui} = assigns) do
    ~Z"""
    <VStack id="opacity">
      <Text>This text has full opacity</Text>
      <Text modifiers={opacity(@native, opacity: 0.75)}>This text has 3/4 opacity</Text>
      <Text modifiers={opacity(@native, opacity: 0.5)}>This text has 1/2 opacity</Text>
      <Text modifiers={opacity(@native, opacity: 0.25)}>This text has 1/4 opacity</Text>
    </VStack>
    """swiftui
  end

  def preferred_color_scheme(%{platform_id: :swiftui} = assigns) do
    ~Z"""
    <VStack id="preferred_color_scheme" modifiers={preferred_color_scheme(@native, color_scheme: :light)}>
      <Text>This view will present in light mode, regardless of the system setting.</Text>
    </VStack>
    """swiftui
  end
end
