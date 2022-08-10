defmodule Playa.S3 do
  @moduledoc """
  Providers wrapped functions to interact with S3.
  """
  defmodule Config do
    def bucket_name() do
      Application.fetch_env!(:ex_aws, :bucket_name)
    end

    def base_url() do
      Application.fetch_env!(:ex_aws, :base_url)
    end
  end

  @spec upload_image(map) :: {:ok, String.t()} | {:error, term()}
  def upload_image(%{"photo" => photo}) do
    image = File.read!(photo.path)

    path = "/uploads/#{photo.filename}"

    response = ExAws.S3.put_object(Config.bucket_name(), path, image) |> ExAws.request()

    case response do
      {:ok, %{status_code: 200}} -> {:ok, photo.filename}
      _ -> {:error, :could_not_upload_image_to_s3}
    end
  end

  @spec delete_image(String.t()) :: :ok | {:error, term()}
  def delete_image(filename) do
    response =
      ExAws.S3.delete_object(Config.bucket_name(), "uploads/#{filename}") |> ExAws.request()

    case response do
      {:ok, %{status_code: 204}} -> :ok
      _ -> {:error, :could_not_delete_image_from_s3}
    end
  end

  def list_objects() do
    response = ExAws.S3.list_objects(Config.bucket_name(), prefix: "uploads") |> ExAws.request()

    case response do
      {:ok, %{body: %{contents: contents}, status_code: 200}} -> {:ok, contents}
      _ -> {:error, :could_not_list_from_s3, response}
    end
  end
end
