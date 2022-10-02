defmodule ServerWeb.Schema.PetTypes do
  use Absinthe.Schema.Notation

  alias ServerWeb.Resolvers

  object :pet_queries do
    @desc "Get all dogs"
    field :dogs, list_of(:dog) do
      resolve(&Resolvers.Pets.list_dogs/2)
    end

    @desc "Get dog by breed"
    field :dog, :dog do
      arg(:breed, non_null(:string))

      resolve(&Resolvers.Pets.get_dog/2)
    end
  end

  object :dog do
    field :uid, :id
    field :breed, :string
    field :description, :string
    field :image_url, :string
  end
end
