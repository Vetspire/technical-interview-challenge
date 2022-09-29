defmodule VetspireChallengeWeb.Router do
  use VetspireChallengeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", VetspireChallengeWeb do
    pipe_through :api
  end

  pipeline :graphql do
    plug(Plug.Parsers,
      parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
      pass: ["*/*"],
      json_decoder: Poison
    )
  end

  scope "/" do
    pipe_through(:graphql)

    post("/graphql", Absinthe.Plug,
      schema: VetspireChallengeWeb.Schema,
      json_codec: Poison
    )
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
