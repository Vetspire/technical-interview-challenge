defmodule VetspireChallengeWeb.Router do
  use VetspireChallengeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", VetspireChallengeWeb do
    pipe_through :api
  end
end
