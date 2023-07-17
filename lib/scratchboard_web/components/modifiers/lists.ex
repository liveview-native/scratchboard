defmodule ScratchboardWeb.Components.Modifiers.Lists do
  @moduledoc false
  use Phoenix.Component
  use LiveViewNative.Component

  def swipe_actions_modifier(%{platform_id: :swiftui} = assigns) do
    ~SWIFTUI"""
    <VStack id="swipe_actions">
      <Spacer />
      <List>
        <%= for {item, is_unread?} <- [{"Foo", true}, {"Bar", false}, {"Baz", false}] do %>
          <HStack
            id={item}
            modifiers={
              @native
              |> swipe_actions(edge: :leading, allows_full_swipe: false, content: :hello)
              |> swipe_actions(edge: :trailing, allows_full_swipe: false, content: :delete)
              |> swipe_actions(edge: :trailing, allows_full_swipe: false, content: :flag)
            }>
            <Text><%= item %></Text>
            <%= if is_unread? do %>
              <Button template={:hello}>
                <Image system-name="envelope.badge" />
              </Button>
            <% else %>
              <Button template={:hello} modifiers={tint(@native, color: :accent)}>
                <Image system-name="envelope.open" />
              </Button>
            <% end %>
            <Button template={:flag} phx-click="flag_item" phx-value-item={item}>
              <Image system-name="flag" />
            </Button>
            <Button template={:delete} modifiers={tint(@native, color: :red)}>
              <Image system-name="trash" />
            </Button>
          </HStack>
        <% end %>
      </List>
    </VStack>
    """
  end
end
