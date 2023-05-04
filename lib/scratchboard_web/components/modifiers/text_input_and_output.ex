defmodule ScratchboardWeb.Components.Modifiers.TextInputAndOutput do
  @moduledoc false
  use Phoenix.LiveView
  use LiveViewNative.LiveView

  def bold_and_italic(%{platform_id: :swiftui} = assigns) do
    ~Z"""
    <VStack id="bold_italic">
      <Text>This text is normal</Text>
      <Text modifiers={bold(@native, is_active: true)}>This text is bold</Text>
      <Text modifiers={italic(@native, is_active: true)}>This text is italic</Text>
      <Text modifiers={@native |> bold(is_active: true) |> italic(is_active: true)}>This text is bold and italic</Text>
    </VStack>
    """swiftui
  end

  def dynamic_type_size(%{platform_id: :swiftui} = assigns) do
    ~Z"""
    <VStack id="dynamic_type_size">
      <Text id="dynamic_type_x_small" modifiers={dynamic_type_size(@native, size: :x_small)}>x_small</Text>
      <Text id="dynamic_type_small" modifiers={dynamic_type_size(@native, size: :small)}>small</Text>
      <Text id="dynamic_type_medium" modifiers={dynamic_type_size(@native, size: :medium)}>medium</Text>
      <Text id="dynamic_type_large" modifiers={dynamic_type_size(@native, size: :large)}>large</Text>
      <Text id="dynamic_type_x_large" modifiers={dynamic_type_size(@native, size: :x_large)}>x_large</Text>
      <Text id="dynamic_type_xx_large" modifiers={dynamic_type_size(@native, size: :xx_large)}>xx_large</Text>
      <Text id="dynamic_type_xxx_large" modifiers={dynamic_type_size(@native, size: :xxx_large)}>xxx_large</Text>
      <Text id="dynamic_type_accessibility_1" modifiers={dynamic_type_size(@native, size: :accessibility_1)}>accessibility_1</Text>
      <Text id="dynamic_type_accessibility_2" modifiers={dynamic_type_size(@native, size: :accessibility_2)}>accessibility_2</Text>
      <Text id="dynamic_type_accessibility_3" modifiers={dynamic_type_size(@native, size: :accessibility_3)}>accessibility_3</Text>
      <Text id="dynamic_type_accessibility_4" modifiers={dynamic_type_size(@native, size: :accessibility_4)}>accessibility_4</Text>
      <Text id="dynamic_type_accessibility_5" modifiers={dynamic_type_size(@native, size: :accessibility_5)}>accessibility_5</Text>
    </VStack>
    """swiftui
  end


  def font_design(%{platform_id: :swiftui} = assigns) do
    ~Z"""
    <VStack id="font_design">
    <Text modifiers={font_design(@native, design: :default)}>This text is default</Text>
    <Text modifiers={font_design(@native, design: :monospaced)}>This text is monospaced</Text>
    <Text modifiers={font_design(@native, design: :rounded)}>This text is rounded</Text>
    <Text modifiers={font_design(@native, design: :serif)}>This text is serif</Text>
  </VStack>
  """swiftui
end

  def font_weight(%{platform_id: :swiftui} = assigns) do
    ~Z"""
    <VStack id="font_weight">
      <HStack>
        <Text modifiers={font_weight(@native, weight: :black)}>Black</Text>
        <Text modifiers={font_weight(@native, weight: :bold)}>Bold</Text>
        <Text modifiers={font_weight(@native, weight: :heavy)}>Heavy</Text>
        <Text modifiers={font_weight(@native, weight: :light)}>Light</Text>
        <Text modifiers={font_weight(@native, weight: :medium)}>Medium</Text>
      </HStack>
      <HStack>
        <Text modifiers={font_weight(@native, weight: :regular)}>Regular</Text>
        <Text modifiers={font_weight(@native, weight: :semibold)}>Semibold</Text>
        <Text modifiers={font_weight(@native, weight: :thin)}>Thin</Text>
        <Text modifiers={font_weight(@native, weight: :ultra_light)}>Ultra Light</Text>
      </HStack>
    </VStack>
    """swiftui
  end

  def monospaced(%{platform_id: :swiftui} = assigns) do
    ~Z"""
    <VStack id="monospaced">
      <Label modifiers={monospaced(@native, is_active: true)}>This text is monospaced</Label>
      <Label modifiers={monospaced(@native, is_active: false)}>This text is not</Label>
      <Label modifiers={monospaced_digit(@native, is_active: true)}>1234567890</Label>
      <Label>1234567890</Label>
    </VStack>
    """swiftui
  end

  def text_case(%{platform_id: :swiftui} = assigns) do
    ~Z"""
    <VStack id="text_case">
      <Text>This text is normal</Text>
      <Text modifiers={text_case(@native, text_case: :uppercase)}>This text is uppercase</Text>
      <Text modifiers={text_case(@native, text_case: :lowercase)}>This text is lowercase</Text>
    </VStack>
    """swiftui
  end
end