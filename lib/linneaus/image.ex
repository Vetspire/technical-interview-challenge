defprotocol Linneaus.Image do
  def asset_url(image)
end

defimpl Linneaus.Image, for: Any do
  def asset_url(%{asset_url: url}), do: url
end
