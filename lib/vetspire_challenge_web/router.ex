defmodule VetspireChallengeWeb.Router do
  use VetspireChallengeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", VetspireChallengeWeb do
    pipe_through :api
  end

  scope "/" do
    forward("/graphiql", Absinthe.Plug.GraphiQL,
      schema: VetspireChallengeWeb.Schema,
      interface: :playground,
      context: %{pubsub: VetspireChallengeWeb.Endpoint},
      json_codec: Poison
    )
  end
end
