defmodule VetspireChallenge.Schemas.Breed do
  use Ecto.Schema

  import Ecto.Changeset

  schema "breeds" do
    field :name, :string
    field :image, :string
  end

  def changeset(breed, params \\ %{}) do
    breed
    |> cast(params, [:name, :image])
    |> validate_required([:name, :image])
    |> unique_constraint(:name)
  end
end
