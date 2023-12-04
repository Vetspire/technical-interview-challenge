defprotocol Linnaeus.Image do
  @spec asset_url(t()) :: String.t()
  def asset_url(image)

  @spec encode(t()) :: %{
          required(:id) => integer(),
          required(:asset_url) => String.t(),
          required(:breed_id) => integer()
        }
  def encode(image)
end

defimpl Linnaeus.Image, for: Any do
  def asset_url(%{asset_url: url}), do: url

  def encode(image) do
    Map.take(image, [:asset_url, :breed_id, :id])
  end
end
