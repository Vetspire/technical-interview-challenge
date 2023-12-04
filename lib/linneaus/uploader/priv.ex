defmodule Linnaeus.Uploader.Priv do
  @moduledoc """
  Saves a file to a folder inside the application's priv folder. I've spent
  more time on this project than I meant to so I don't think I'm going to
  implement a CDN uploader, but the way this is set up it would be relatively
  simple to write a separate module to upload to a CDN like S3 or CloudFront,
  and set the config to use that in production, and keep this for dev and test.
  """
  @behaviour Linnaeus.Uploader

  @images_path ["images", "dogs", "uploaded"]
  @static_path Path.join([:code.priv_dir(:linnaeus), "static" | @images_path])

  def upload(%Plug.Upload{path: path, filename: filename}) do
    local_path = local_path()

    # create folder if it doesn't already exist
    :ok = File.mkdir_p!(local_path)

    filename = Ecto.UUID.generate() <> "-" <> filename
    local_file = Path.join([local_path, filename])

    case File.cp(path, local_file) do
      :ok ->
        {:ok,
         ["/", @images_path, filename]
         |> List.flatten()
         |> Path.join()}

      {:error, error} ->
        {:error, {error, path}}
    end
  end

  def delete(nil), do: :ok

  def delete(path) do
    ["/", "images", "dogs", "uploaded", filename] = Path.split(path)

    local_path()
    |> Path.join(filename)
    |> File.rm()
  end

  def local_path do
    config()
    |> Keyword.get(:parent_folder)
    |> case do
      nil -> @static_path
      "" <> parent_folder -> Path.join(parent_folder, @static_path)
    end
  end

  def set_parent_folder(path) do
    Application.put_env(
      :linnaeus,
      __MODULE__,
      Keyword.put(config(), :parent_folder, path)
    )
  end

  defp config do
    Application.get_env(:linnaeus, __MODULE__, [])
  end
end
