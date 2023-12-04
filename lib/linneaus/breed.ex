defprotocol Linnaeus.Breed do
  @spec image(t()) :: integer()
  def image(breed)

  @spec name(t()) :: String.t()
  def name(breed)

  @spec encode(t()) :: %{
          required(:id) => integer(),
          required(:name) => String.t(),
          required(:image_id) => integer()
        }
  def encode(breed)
end

defimpl Linnaeus.Breed, for: Any do
  def encode(breed) do
    breed
    |> Map.take([:id, :name])
    |> Map.put(:image_id, breed.image.id)
  end

  def image(breed), do: breed.image

  def name(breed), do: breed.name
end
