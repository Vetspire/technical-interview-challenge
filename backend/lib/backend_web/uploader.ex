defmodule BackendWeb.Uploader do
  alias Backend.FileUpload
  alias BackendWeb.Uploaders.{LocalUploader, R2Uploader}

  # 15 MB limit
  @max_upload_size 15 * 1000 * 1000

  @callback upload(
              src_file :: String.t(),
              destination_file :: String.t(),
              content_type :: String.t()
            ) :: {:ok, :local | :r2} | {:error, reason :: term}

  @callback file_url(file_upload :: FileUpload.t()) :: String.t()

  @doc """
  Upload a file using the configured uploader.

  Takes either a `Plug.Upload` or a path to a source file. (source file should not be user supplied)

  Opts:
    - `:uploader`: Will override the uploader from config. A module that fulfils `#{__MODULE__}` behaviour.
  """
  def upload_file(upload, opts \\ [])

  def upload_file(%Plug.Upload{} = upload, opts) do
    file_ext = get_file_ext(upload)
    content_type = upload.content_type

    do_upload_file(upload.path, file_ext, upload.filename, content_type, opts)
  end

  def upload_file(src_file, opts) do
    file_ext = get_file_ext(src_file)
    original_filename = Path.basename(src_file)
    content_type = MIME.from_path(src_file)

    do_upload_file(src_file, file_ext, original_filename, content_type, opts)
  end

  defp do_upload_file(src_file, file_ext, original_filename, content_type, opts) do
    uploader = Keyword.get(opts, :uploader, config_uploader())
    new_uuid = UUID.uuid4()
    dest_file = "#{new_uuid}.#{file_ext}"

    with true <- File.exists?(src_file),
        {:dir, false} <- {:dir, File.dir?(src_file)},
         {:ok, %File.Stat{size: size}} when size < @max_upload_size <- File.stat(src_file),
         {:ok, upload_type} <- uploader.upload(src_file, dest_file, content_type) do
      {:ok,
       FileUpload.new(%{
         upload_type: upload_type,
         original_filename: original_filename,
         filename: dest_file
       })}
    else
      {:ok, %File.Stat{}} -> {:error, "Uploaded file is too big"}
      {:dir, true} -> {:error, "Cannot upload directory"}
      err -> err
    end
  end

  @doc """
  Get the hosted URL for a `Backend.FileUpload`.

  I got a bit lazy here and just hardcoded the two supported uploaders.
  """
  def get_file_url(%FileUpload{upload_type: :local} = file) do
    LocalUploader.file_url(file)
  end

  def get_file_url(%FileUpload{upload_type: :r2} = file) do
    R2Uploader.file_url(file)
  end

  defp get_file_ext(%Plug.Upload{content_type: content_type}) do
    content_type
    |> String.split("/")
    |> List.last()
  end

  defp get_file_ext(filename) do
    Path.extname(filename) |> String.replace_leading(".", "")
  end

  defp config_uploader, do: Application.get_env(:backend, __MODULE__, LocalUploader)
end
