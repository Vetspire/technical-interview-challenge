# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :vetspire_take_home,
  ecto_repos: [VetspireTakeHome.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :vetspire_take_home, VetspireTakeHomeWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [json: VetspireTakeHomeWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: VetspireTakeHome.PubSub,
  live_view: [signing_salt: "4YPMyIVH"]

# Configure esbuild, which bundles the React app
config :esbuild,
  version: "0.19.7",
  default: [
    args: ~w(js/app.jsx --bundle --target=es2016 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
