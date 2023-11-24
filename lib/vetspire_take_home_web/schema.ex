defmodule VetspireTakeHomeWeb.Schema do
  use Absinthe.Schema
  import_types(VetspireTakeHomeWeb.Schema.BreedTypes)

  alias VetspireTakeHomeWeb.Resolvers

  query do
    @desc "List all breeds"
    field :breeds, list_of(:breed) do
      resolve(&Resolvers.Breeds.list_breeds/3)
    end

    @desc "Get details for a single breed"
    field :breed, :breed do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Breeds.get_breed/3)
    end
  end
end
