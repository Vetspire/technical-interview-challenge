defmodule VetspireChallengeWeb.Schema do
  use Absinthe.Schema

  alias VetspireChallenge.Browse

  import_types(VetspireChallengeWeb.Types.Breed)

  query do
    @desc "List of breeds"
    field(:breeds, non_null(list_of(non_null(:breed)))) do
      arg(:sort, :string)
      arg(:limit, non_null(:integer))
      arg(:offset, :integer)

      resolve(fn _root, args, _info -> {:ok, Browse.list_breeds(args)} end)
    end
  end
end
