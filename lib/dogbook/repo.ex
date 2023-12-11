defmodule Dogbook.Repo do
  use Ecto.Repo,
    otp_app: :dogbook,
    adapter: Ecto.Adapters.Postgres
end
