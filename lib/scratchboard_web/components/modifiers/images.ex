defmodule ScratchboardWeb.Components.Modifiers.Images do
  @moduledoc false
  use Phoenix.Component
  use LiveViewNative.Component

  def image_scale_modifier(%{platform_id: :swiftui} = assigns) do
    ~SWIFTUI"""
    <VStack>
      <HStack modifiers={image_scale(@native, scale: :small)}>
        <Image system-name="heart.fill"></Image>
        <Text>Small</Text>
      </HStack>
      <HStack modifiers={image_scale(@native, scale: :medium)}>
        <Image system-name="heart.fill"></Image>
        <Text>Medium</Text>
      </HStack>
      <HStack modifiers={image_scale(@native, scale: :large)}>
        <Image system-name="heart.fill"></Image>
        <Text>Large</Text>
      </HStack>
    </VStack>
    """
  end
end
