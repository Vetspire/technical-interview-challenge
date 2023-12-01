defmodule Linnaeus.Repo do
  use Ecto.Repo,
    otp_app: :linnaeus,
    adapter: Ecto.Adapters.Postgres
end
