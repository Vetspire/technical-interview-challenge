defmodule BackendWeb.Uploaders.LocalUploader do
  @behaviour BackendWeb.Uploader

  alias Backend.FileUpload

  @app :backend
  @upload_dir "priv/static/uploads"

  @doc """
  Return the hosted URL for this file.

  Right now this has a hard dependency on the Plug.Static configured in the Endpoint
  """
  def file_url(%FileUpload{filename: filename}) do
    Path.join([BackendWeb.Endpoint.static_url(), "uploads", filename])
  end

  def upload(src_file, destination_file, _content_type) do
    ensure_upload_dir()
    upload_path = get_upload_path(destination_file)

    with :ok <- File.cp(src_file, upload_path) do
      {:ok, :local}
    end
  end

  defp get_upload_dir do
    @app
    |> Application.app_dir()
    |> Path.join(@upload_dir)
  end

  defp ensure_upload_dir() do
    upload_dir = get_upload_dir()

    unless File.exists?(upload_dir) do
      File.mkdir!(upload_dir)
    end
  end

  defp get_upload_path(filename) do
    get_upload_dir()
    |> Path.join(filename)
  end
end
