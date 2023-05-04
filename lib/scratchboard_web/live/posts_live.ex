defmodule ScratchboardWeb.PostsLive do
  use Phoenix.LiveView
  use LiveViewNative.LiveView

  alias Scratchboard.Post
  alias Scratchboard.Repo

  @impl true
  def render(%{platform_id: :swiftui} = assigns) do
    ~Z"""
    <ScrollView id="posts-demo">
      <VStack>
        <%= for post <- @posts do %>
          <HStack
            id={"post_#{post.id}"}
            modifiers={
              @native
              |> padding(all: 5)
              |> font_weight(weight: post.font_weight)
              |> foreground_style(primary: {:color, post.color})
            }>
            <%= post.body %>
          </HStack>
        <% end %>
      </VStack>
    </ScrollView>
    """swiftui
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div id="posts-demo">
      <ul>
        <%= for post <- @posts do %>
          <li
            id={"post_#{post.id}"}
            style={"font_weight: #{post.font_weight}; color: #{post.color}"}>
            <%= post.body %>
          </li>
        <% end %>
      </ul>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, posts: Repo.all(Post))}
  end
end
