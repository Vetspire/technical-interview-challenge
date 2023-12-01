defmodule Linnaeus.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LinnaeusWeb.Telemetry,
      Linnaeus.Repo,
      {DNSCluster, query: Application.get_env(:linnaeus, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Linnaeus.PubSub},
      # Start a worker by calling: Linnaeus.Worker.start_link(arg)
      # {Linnaeus.Worker, arg},
      # Start to serve requests, typically the last entry
      LinnaeusWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Linnaeus.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LinnaeusWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
