defmodule Server.MixProject do
  use Mix.Project

  def project do
    [
      app: :server,
      version: "0.1.0",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Server.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support", "test/factories"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:absinthe_plug, "~> 1.5"},
      {:absinthe, "~> 1.5"},
      {:cors_plug, "~> 3.0"},
      {:ecto_sql, "~> 3.6"},
      {:ex_aws_s3, "~> 2.3"},
      {:ex_aws, "~> 2.4"},
      {:ex_machina, "~> 2.7.0", only: :test},
      {:hackney, "~> 1.9"},
      {:jason, "~> 1.2"},
      {:mox, "~> 1.0"},
      {:phoenix_ecto, "~> 4.4"},
      {:phoenix, "~> 1.6.5"},
      {:plug_cowboy, "~> 2.5"},
      {:poison, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:sweet_xml, "~> 0.7.3"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
