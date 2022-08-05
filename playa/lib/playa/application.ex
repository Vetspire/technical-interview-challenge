defmodule Playa.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Playa.Repo,
      # Start the Telemetry supervisor
      PlayaWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Playa.PubSub},
      # Start the Endpoint (http/https)
      PlayaWeb.Endpoint
      # Start a worker by calling: Playa.Worker.start_link(arg)
      # {Playa.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Playa.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PlayaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
