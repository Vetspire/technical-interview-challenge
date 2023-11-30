defmodule DogBreeds.Repo do
  use Ecto.Repo,
    otp_app: :dog_breeds,
    adapter: Ecto.Adapters.Postgres
end
