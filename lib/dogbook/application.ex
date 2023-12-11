defmodule Dogbook.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DogbookWeb.Telemetry,
      Dogbook.Repo,
      {DNSCluster, query: Application.get_env(:dogbook, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Dogbook.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Dogbook.Finch},
      # Start a worker by calling: Dogbook.Worker.start_link(arg)
      # {Dogbook.Worker, arg},
      # Start to serve requests, typically the last entry
      DogbookWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Dogbook.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DogbookWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
