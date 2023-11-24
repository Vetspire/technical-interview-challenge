defmodule VetspireTakeHome.Breeds.Breed do
  use Ecto.Schema

  @type t() :: %__MODULE__{
          id: non_neg_integer(),
          name: String.t(),
          image_url: String.t(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  schema "breeds" do
    field(:name, :string)
    field(:image_url, :string)

    timestamps()
  end
end
