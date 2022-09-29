defmodule VetspireChallenge.Repo do
  use Ecto.Repo,
    otp_app: :vetspire_challenge,
    adapter: Ecto.Adapters.Postgres
end
