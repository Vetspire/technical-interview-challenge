defmodule VetspireChallengeWeb.Schema do
  use Absinthe.Schema

  alias VetspireChallenge.Browse

  import_types(VetspireChallengeWeb.Types.Breed)

  query do
    @desc "Get a list of breeds"
    field(:breeds, non_null(list_of(non_null(:breed)))) do
      arg(:sort, :string)
      arg(:limit, non_null(:integer))
      arg(:offset, :integer)

      resolve(fn _root, args, _info -> {:ok, Browse.list_breeds(args)} end)
    end

    @desc "Get a specific breed by id"
    field(:breed, :breed) do
      arg(:id, non_null(:integer))

      resolve(fn _root, %{id: id}, _info -> {:ok, Browse.get_breed(id)} end)
    end
  end
end
