defprotocol Linnaeus.Image do
  @type unassoc() :: %{
          required(:id) => integer(),
          required(:asset_url) => String.t(),
          required(:breed_id) => integer()
        }

  @spec asset_url(t()) :: String.t()
  def asset_url(image)

  @spec unassoc(t()) :: unassoc()
  def unassoc(image)
end

defimpl Linnaeus.Image, for: Any do
  def asset_url(%{asset_url: url}), do: url

  def unassoc(image) do
    image
    |> Map.from_struct()
    |> Map.take([:asset_url, :id])
    |> Map.put(:breed_id, image.breed_id)
  end
end
