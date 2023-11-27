defmodule VetspireTakeHomeWeb.Router do
  use VetspireTakeHomeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/api" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: VetspireTakeHomeWeb.Schema
    forward "/", Absinthe.Plug, schema: VetspireTakeHomeWeb.Schema
  end

  scope "/", VetspireTakeHomeWeb do
    pipe_through :browser

    get "/", PageController, :home
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
