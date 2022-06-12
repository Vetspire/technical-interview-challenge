defmodule Backend.Dogs.Breed do
  use Ecto.Schema
  import Ecto.Changeset

  alias Backend.Dogs.Image

  schema "breeds" do
    field :description, :string
    field :name, :string
    embeds_one :image, Image

    timestamps()
  end

  @doc false
  def changeset(breed, attrs) do
    breed
    |> cast(attrs, [:name, :description])
    |> put_embed(:image, attrs.image)
    |> validate_required([:name, :image, :description])
  end
end
