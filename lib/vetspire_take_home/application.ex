defmodule VetspireTakeHome.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      VetspireTakeHomeWeb.Telemetry,
      VetspireTakeHome.Repo,
      {DNSCluster,
       query: Application.get_env(:vetspire_take_home, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: VetspireTakeHome.PubSub},
      # Start a worker by calling: VetspireTakeHome.Worker.start_link(arg)
      # {VetspireTakeHome.Worker, arg},
      # Start to serve requests, typically the last entry
      VetspireTakeHomeWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: VetspireTakeHome.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    VetspireTakeHomeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
