defprotocol Linnaeus.Breed do
  @spec image(t()) :: integer()
  def image(breed)

  @spec name(t()) :: String.t()
  def name(breed)
end

defimpl Linnaeus.Breed, for: Any do
  def name(breed), do: breed.name

  def image(%{__struct__: struct, id: breed_id}) do
    [_ | parent] =
      struct
      |> Module.split()
      |> Enum.reverse()

    [:Image | parent]
    |> Enum.reverse()
    |> Module.concat()
    |> Linnaeus.Repo.one(breed_id: breed_id)
  end
end
