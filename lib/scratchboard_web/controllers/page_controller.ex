defmodule ScratchboardWeb.PageController do
  use ScratchboardWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
