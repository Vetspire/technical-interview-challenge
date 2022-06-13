defmodule BackendWeb.Uploaders.R2Uploader do
  @behaviour BackendWeb.Uploader

  alias Backend.FileUpload
  alias ExAws.S3

  @moduledoc """
  Uploads files to Cloudflare R2. Requires valid configuration.

  Recommended (and configured) for use in production.

  Required confg (see runtime.exs):
    R2_BUCKET
    R2_ACCOUNT_ID
    R2_ACCESS_KEY_ID
    R2_SECRET_ACCESS_KEY
    R2_QUERY_SECRET
  """

  @doc """
  Return the URL where the file can be accessed from Cloudflare
  """
  def file_url(%FileUpload{filename: filename}) do
    endpoint = fetch_config(:endpoint)
    query_secret = fetch_config(:query_secret)

    "#{endpoint}/#{filename}?verify=#{query_secret}"
  end

  @doc """
  Uploads the file to the configured Cloudflare Bucket
  """
  def upload(src_file, destination_file, content_type) do
    bucket_name = fetch_config(:bucket)

    with {:ok, _result} <-
           src_file
           |> S3.Upload.stream_file()
           |> S3.upload(bucket_name, destination_file, content_type: content_type)
           |> ExAws.request() do
      {:ok, :r2}
    end
  end

  def fetch_config(key \\ nil)

  def fetch_config(nil) do
    Application.fetch_env!(:backend, __MODULE__)
  end

  def fetch_config(key) do
    fetch_config() |> Keyword.get(key)
  end
end
