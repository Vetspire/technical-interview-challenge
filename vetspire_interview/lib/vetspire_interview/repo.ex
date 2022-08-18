defmodule VetspireInterview.Repo do
  use Ecto.Repo,
    otp_app: :vetspire_interview,
    adapter: Ecto.Adapters.Postgres
end
