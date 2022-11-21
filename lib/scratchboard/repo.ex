defmodule Scratchboard.Repo do
  use Ecto.Repo,
    otp_app: :scratchboard,
    adapter: Ecto.Adapters.Postgres
end
