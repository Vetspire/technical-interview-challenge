defmodule VetspireTakeHome.Repo do
  use Ecto.Repo,
    otp_app: :vetspire_take_home,
    adapter: Ecto.Adapters.Postgres
end
