defprotocol Linnaeus.Breed do
  @type assoc_map() :: %{
          images: %{integer() => Linnaeus.Image.unassoc()},
          breeds: %{integer() => Linnaeus.Breed.unassoc()}
        }

  @type unassoc() :: %{
          id: integer(),
          name: String.t(),
          image_id: integer()
        }

  @spec image(t()) :: Linnaeus.Image.t()
  def image(animal)

  @spec name(t()) :: String.t()
  def name(animal)

  @doc """
  Returns a map of breeds and images with associations stripped
  and replaced with ids.
  """
  @spec separate_assocs(t(), assoc_map()) :: assoc_map()
  def separate_assocs(animal, assocs)

  @spec unassoc(t()) :: unassoc()
  def unassoc(breed)
end

defimpl Linnaeus.Breed, for: Any do
  def name(animal), do: animal.name

  def image(%{image: %{__struct__: Linnaeus.Image} = image}) do
    image
  end

  def image(unloaded) do
    unloaded
    |> Linnaeus.Repo.preload(:image)
    |> Map.fetch!(:image)
  end

  def separate_assocs(breed, acc) do
    image = Linnaeus.Breed.image(breed)

    acc
    |> Map.update!(:images, &Map.put(&1, image.id, Linnaeus.Image.unassoc(image)))
    |> Map.update!(
      :breeds,
      &Map.put(&1, breed.id, Linnaeus.Breed.unassoc(breed))
    )
  end

  def unassoc(breed) do
    breed
    |> Map.from_struct()
    |> Map.take([:name, :id])
    |> Map.put(:image_id, breed.image.id)
  end
end
