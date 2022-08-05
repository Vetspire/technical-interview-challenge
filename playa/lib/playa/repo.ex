defmodule Playa.Repo do
  use Ecto.Repo,
    otp_app: :playa,
    adapter: Ecto.Adapters.Postgres
end
