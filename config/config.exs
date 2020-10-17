# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :unbias_backend,
  ecto_repos: [UnbiasBackend.Repo]

# Configures the endpoint
config :unbias_backend, UnbiasBackendWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/RTTn2z7OirPAkQGxCBWJ2D8ukDh6otm3KcUgQtGhOQhQ7zIGnBKc8AUT/udjrEU",
  render_errors: [view: UnbiasBackendWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: UnbiasBackend.PubSub,
  live_view: [signing_salt: "Vru4I/e+"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
