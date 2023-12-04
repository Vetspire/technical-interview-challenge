defmodule LinnaeusWeb.Router do
  use LinnaeusWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {LinnaeusWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LinnaeusWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/breeds/:type", PageController, :home
  end

  scope "/api/v1", LinnaeusWeb.Api.V1 do
    # LinnaeusWeb.Api.V1
    pipe_through :api
    resources "/breeds/:type", BreedsController, only: [:index, :show, :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", LinnaeusWeb do
  #   pipe_through :api
  # end
end
