defmodule Linnaeus.Multipart do
  def multipart_to_params(parts, conn) do
    {:ok, parts, conn} =
      Plug.Parsers.MULTIPART.multipart_to_params(parts, conn, [])

    with %{"image_file" => %Plug.Upload{} = file} <- parts do
      IO.inspect(file)
    end

    {:ok, parts, conn}
  end
end
