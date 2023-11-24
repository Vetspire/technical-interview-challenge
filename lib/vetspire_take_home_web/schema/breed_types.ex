defmodule VetspireTakeHomeWeb.Schema.BreedTypes do
  use Absinthe.Schema.Notation

  object :breed do
    field :id, :id
    field :name, :string
    field :image_url, :string
  end
end
