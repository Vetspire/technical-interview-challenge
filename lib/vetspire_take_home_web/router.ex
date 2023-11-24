defmodule VetspireTakeHomeWeb.Router do
  use VetspireTakeHomeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: VetspireTakeHomeWeb.Schema
    forward "/", Absinthe.Plug, schema: VetspireTakeHomeWeb.Schema
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:vetspire_take_home, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: VetspireTakeHomeWeb.Telemetry
    end
  end
end
