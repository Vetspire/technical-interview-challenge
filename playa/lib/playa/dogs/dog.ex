defmodule Playa.Dogs.Dog do
  use Ecto.Schema
  import Ecto.Changeset

  schema "dogs" do
    field :breed, :string
    field :image_path, :string

    timestamps()
  end

  @doc false
  def changeset(dog, attrs) do
    dog
    |> cast(attrs, [:breed, :image_path])
    |> validate_required([:breed])
  end
end
