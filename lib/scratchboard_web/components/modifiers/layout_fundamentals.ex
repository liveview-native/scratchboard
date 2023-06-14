defmodule ScratchboardWeb.Components.Modifiers.LayoutFundamentals do
  @moduledoc false
  use Phoenix.Component
  use LiveViewNative.Component

  def background_modifier(%{platform_id: :swiftui} = assigns) do
  ~SWIFTUI"""
  <VStack id="background">
    <Spacer />
    <HStack id="example_heart">
      <Image id="heart_image" system-name="heart.fill" modifiers={@native |> background(alignment: :center, content: :heart_bg) |> foreground_style(primary: {:color, :white})}>
        <Circle template={:heart_bg} modifiers={@native |> frame(width: 32, height: 32) |> foreground_style(primary: {:color, :red})} />
      </Image>
    </HStack>

    <Spacer />

    <HStack id="example_liveviewnative">
      <Text modifiers={@native |> background(alignment: :center, content: :text_bg) |> foreground_style(primary: {:linear_gradient, %{gradient: {:colors, [:orange, :indigo, :purple]}, start_point: {0, 0}, end_point: {1, 1}}})}>
        liveviewnative
        <RoundedRectangle template={:text_bg} corner-radius="8" modifiers={@native |> frame(width: 192, height: 64)} />
      </Text>
    </HStack>
    <Spacer />
  </VStack>
  """
  end

  def z_index_modifier(%{platform_id: :swiftui} = assigns) do
    ~SWIFTUI"""
    <ZStack id="z_index">
      <ZStack>
        <% # Without setting z_index, elements are layered according to order in the template %>
        <Circle modifiers={@native |> frame(width: 64, height: 64) |> foreground_style(primary: {:color, :red})} />
        <Circle modifiers={@native |> frame(width: 64, height: 64) |> offset(x: 8, y: 8) |> foreground_style(primary: {:color, :green})} />
        <Circle modifiers={@native |> frame(width: 64, height: 64) |> offset(x: 16, y: 16) |> foreground_style(primary: {:color, :blue}) } />
      </ZStack>

      <ZStack modifiers={@native |> offset(x: 0, y: 128)}>
        <% # Using z_index, we can override the default layering %>
        <Circle modifiers={@native |> z_index(value: 3) |> frame(width: 64, height: 64) |> foreground_style(primary: {:color, :red})} />
        <Circle modifiers={@native |> z_index(value: 2) |> frame(width: 64, height: 64) |> offset(x: 8, y: 8) |> foreground_style(primary: {:color, :green})} />
        <Circle modifiers={@native |> z_index(value: 1) |> frame(width: 64, height: 64) |> offset(x: 16, y: 16) |> foreground_style(primary: {:color, :blue}) } />
      </ZStack>
    </ZStack>
    """
  end
end
