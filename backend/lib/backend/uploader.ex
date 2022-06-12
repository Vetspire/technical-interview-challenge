defmodule Backend.Uploader do
  alias Backend.Dogs.Image

  @app :backend
  @upload_dir "priv/static/uploads"

  @accepted_content_types ~w(image/jpg image/jpeg image/png image/gif)

  @doc """
  Return the hosted URL for this image.

  Right now this has a hard dependency on the Plug.Static configured in the Endpoint
  """
  def get_static_url(filename) do
    [BackendWeb.Endpoint.static_url(), "uploads", filename]
    |> Path.join()
  end

  @doc """
  Returns the filesystem path/dir for where files should be stored locally
  """
  defp get_upload_dir do
    @app
    |> Application.app_dir()
    |> Path.join(@upload_dir)
  end

  @doc """
  Returns the full filesystem path of where a file should be locally
  """
  defp get_upload_path(filename) do
    get_upload_dir()
    |> Path.join(filename)
  end

  def upload(%Plug.Upload{content_type: content_type} = image)
      when content_type in @accepted_content_types do
    new_uuid = UUID.uuid4()

    upload_dir = get_upload_dir()

    unless File.exists?(upload_dir) do
      File.mkdir(upload_dir)
    end

    with ["image", file_ext] <- String.split(content_type, "/"),
         true <- File.exists?(image.path),
         new_filename <- "#{new_uuid}.#{file_ext}",
         :ok <- File.cp(image.path, get_upload_path(new_filename)) do
      {:ok,
       Image.changeset(%Image{}, %{
         filename: new_filename,
         original_filename: image.filename,
         upload_type: :local
       })}
    end
  end

  def upload(_), do: {:error, "Invalid image"}
end
