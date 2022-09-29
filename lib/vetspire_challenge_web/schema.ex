defmodule VetspireChallengeWeb.Schema do
  use Absinthe.Schema

  alias VetspireChallenge.{Browse, Upload}

  import_types(Absinthe.Plug.Types)
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

  mutation do
    @desc "Add a new breed"
    field :add_breed, :breed do
      arg(:name, non_null(:string))
      arg(:image, non_null(:upload))

      resolve(fn %{name: name, image: %{path: path, content_type: "image/" <> extension} = image},
                 _ctx ->
        IO.inspect(image)
        Upload.new_breed(name, path, extension)
      end)
    end
  end
end
