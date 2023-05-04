defmodule ScratchboardWeb.Components.Modifiers.DrawingAndGraphics do
  @moduledoc false
  use Phoenix.Component
  use LiveViewNative.Component

  def aspect_ratio(%{platform_id: :swiftui} = assigns) do
    ~Z"""
    <VStack id="aspect_ratio">
      <Spacer />
      <Image id="aspect_test_fit" name="Hamilton" resizable modifiers={@native |> aspect_ratio(content_mode: "fit") |> frame(width: 300, height: 225)} />
      <Spacer />
      <Image id="aspect_test_fill" name="Hamilton" resizable modifiers={@native |> aspect_ratio(content_mode: "fill") |> frame(width: 300, height: 225)} />
      <Spacer />
    </VStack>
    """swiftui
  end

  def border(%{platform_id: :swiftui} = assigns) do
    ~Z"""
    <VStack id="border">
      <Text modifiers={border(@native, content: {:color, :purple}, width: 4)}>
        Purple border inside the view bounds.
      </Text>
      <Text modifiers={@native |> padding(all: 4) |> border(content: {:color, :purple}, width: 4)}>
        Purple border outside the view bounds.
      </Text>
    </VStack>
    """swiftui
  end

  def foreground_color(%{platform_id: :swiftui} = assigns) do
    ~Z"""
    <VStack id="foreground_color">
      <Text modifiers={foreground_color(@native, color: "#7b1fa2")}>
        This text is colored with a hex code
      </Text>
      <Text modifiers={foreground_color(@native, color: :mint)}>
        This text is colored with a standard color
      </Text>
      <Text modifiers={foreground_color(@native, color: :primary)}>
        This text is colored with a system color
      </Text>
    </VStack>
    """swiftui
  end

  def foreground_style(%{platform_id: :swiftui} = assigns) do
    ~Z"""
    <VStack id="foreground_style">
      <HStack>
        <Label modifiers={foreground_style(@native, primary: {:color, :mint})}>Color Text</Label>
      </HStack>
      <HStack>
        <Label modifiers={foreground_style(@native, primary: {:linear_gradient, %{gradient: {:colors, [:red, :orange, :yellow, :green, :blue, :indigo, :purple]}, start_point: {0, 0}, end_point: {1, 1}}})}>
          Foreground Linear Gradient
        </Label>
      </HStack>
      <HStack>
        <Label modifiers={foreground_style(@native, primary: {:linear_gradient, %{gradient: {:stops, [{:pink, 0.8}, {:blue, 0.9}]}}})}>
          Foreground Linear Gradient with Stops
        </Label>
      </HStack>
    </VStack>
    """swiftui
  end

  def tint(%{platform_id: :swiftui} = assigns) do
    ~Z"""
    <VStack id="tint">
      <HStack>
        <Button id="tint_hex" modifiers={tint(@native, color: "#3EB489")}>Hex Code</Button>
      </HStack>
      <HStack>
        <Button modifiers={tint(@native, color: :black)}>Black</Button>
        <Button modifiers={tint(@native, color: :blue)}>Blue</Button>
        <Button modifiers={tint(@native, color: :brown)}>Brown</Button>
        <Button modifiers={tint(@native, color: :cyan)}>Cyan</Button>
      </HStack>
      <HStack>
        <Button modifiers={tint(@native, color: :gray)}>Gray</Button>
        <Button modifiers={tint(@native, color: :green)}>Green</Button>
        <Button modifiers={tint(@native, color: :indigo)}>Indigo</Button>
        <Button modifiers={tint(@native, color: :mint)}>Mint</Button>
        <Button modifiers={tint(@native, color: :orange)}>Orange</Button>
      </HStack>
      <HStack>
        <Button modifiers={tint(@native, color: :pink)}>Pink</Button>
        <Button modifiers={tint(@native, color: :purple)}>Purple</Button>
        <Button modifiers={tint(@native, color: :red)}>Red</Button>
        <Button modifiers={tint(@native, color: :teal)}>Teal</Button>
        <Button modifiers={tint(@native, color: :white)}>White</Button>
      </HStack>
      <HStack>
        <Button modifiers={tint(@native, color: :yellow)}>Yellow</Button>
        <Button modifiers={tint(@native, color: :accent)}>Accent</Button>
        <Button modifiers={tint(@native, color: :primary)}>Primary</Button>
        <Button modifiers={tint(@native, color: :secondary)}>Secondary</Button>
      </HStack>
      <HStack>
        <Button modifiers={tint(@native, color: :clear)}>Clear</Button>
      </HStack>
      <HStack>
        <VStack>
          <Button modifiers={tint(@native, color: {:srgb, %{white: 0.5, opacity: 0.5}})}>sRGB Grayscale</Button>
          <Button modifiers={tint(@native, color: {:srgb, %{red: 0.25, green: 0.25, blue: 0.75, opacity: 0.5}})}>sRGB Red Green Blue</Button>
          <Button modifiers={tint(@native, color: {:srgb_linear, %{white: 0.5, opacity: 0.5}})}>sRGB (Linear) Grayscale</Button>
          <Button modifiers={tint(@native, color: {:srgb_linear, %{red: 0.25, green: 0.25, blue: 0.75, opacity: 0.5}})}>sRGB (Linear) Red Green Blue</Button>
          <Button modifiers={tint(@native, color: {:display_p3, %{white: 0.5, opacity: 0.5}})}>DCI-P3 Grayscale</Button>
          <Button modifiers={tint(@native, color: {:display_p3, %{red: 0.25, green: 0.25, blue: 0.75, opacity: 0.5}})}>DCI-P3 Grayscale</Button>
        </VStack>
      </HStack>
    </VStack>
    """swiftui
  end
end
