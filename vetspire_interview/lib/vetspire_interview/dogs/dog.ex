defmodule VetspireInterview.Dogs.Dog do
  @moduledoc """
  The `VetspireInterview.Dogs.Dog` schema.

  A `Dog` contains a `breed` and `image_path` field, of which the `breed` is both required
  and unique.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "dogs" do
    field(:breed, :string)
    field(:image_path, :string)

    timestamps()
  end

  @doc false
  def changeset(dog, attrs) do
    dog
    |> cast(attrs, [:breed, :image_path])
    |> validate_required([:breed])
    |> unique_constraint(:breed)
  end
end
