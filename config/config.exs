# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :scratchboard,
  ecto_repos: [Scratchboard.Repo]

# Configures the endpoint
config :scratchboard, ScratchboardWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: ScratchboardWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Scratchboard.PubSub,
  live_view: [signing_salt: "Gll7MdJA"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :scratchboard, Scratchboard.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/* --external:/videos/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Add Tailwind for styling web clients
config :tailwind,
  version: "3.2.4",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Define platform support for LiveView Native
config :live_view_native,
  platforms: [
    LiveViewNativeSwiftUi.Platform,
    LiveViewNativeJetpack.Platform
  ]

config :live_view_native, LiveViewNativeSwiftUi.Platform, app_name: "Scratchboard"
config :live_view_native, LiveViewNativeJetpack.Platform, app_name: "Scratchboard"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
