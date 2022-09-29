defmodule VetspireChallengeWeb.Types.Breed do
  use Absinthe.Schema.Notation

  object(:breed) do
    @desc "The id of the breed"
    field(:id, :id)

    @desc "The name of the breed"
    field(:name, :string)

    @desc "The url of the image of the breed"
    field(:image_url, :string,
      resolve: fn breed, _args, _info -> {:ok, "/images/#{breed.image}"} end
    )
  end
end
