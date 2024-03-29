defmodule ScratchboardWeb.Router do
  use ScratchboardWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ScratchboardWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  if Mix.env() in [:dev, :test] do
    scope "/" do
      pipe_through :browser

      live "/", ScratchboardWeb.HelloLive
      live "/counter", ScratchboardWeb.CounterLive
      live "/posts", ScratchboardWeb.PostsLive
      live "/components-test", ScratchboardWeb.ComponentsTestLive
      live "/webview-test", ScratchboardWeb.WebviewLive
      live "/video-player-test", ScratchboardWeb.VideoPlayerLive
      live "/swiftui-modifiers", ScratchboardWeb.SwiftUiModifiersLive
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
