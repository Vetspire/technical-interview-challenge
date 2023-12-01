defmodule DogBreedsWeb.Router do
  use DogBreedsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {DogBreedsWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DogBreedsWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/api/v1", DogBreedsWeb.Api.V1 do
    # DogBreedsWeb.Api.V1
    pipe_through :api
    resources "/breeds", BreedsController, only: [:index, :show, :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", DogBreedsWeb do
  #   pipe_through :api
  # end
end
