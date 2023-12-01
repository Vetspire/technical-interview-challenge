defprotocol Linneaus.Breed do
  @spec image(t()) :: Linnaeus.Image.t()
  def image(animal)

  @spec name(t()) :: String.t()
  def name(animal)
end

defimpl Linneaus.Breed, for: Any do
  def name(animal), do: animal.name

  def image(%{image: %{__struct__: Linneaus.Image} = image}) do
    image
  end

  def image(unloaded) do
    unloaded
    |> Linneaus.Repo.preload(:image)
    |> Map.fetch!(:image)
  end
end
