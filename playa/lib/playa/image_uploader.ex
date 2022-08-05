defmodule Playa.ImageUploader do
  @moduledoc """
  Providers wrapped functions to interact with S3 for image upload.
  """
  @spec upload_image(Map.t()) :: {:ok, String.t()} | {:error, term()}
  def upload_image(%{"photo" => photo}) do
    image = File.read!(photo.path)

    path = "/uploads/#{photo.filename}"

    response = ExAws.S3.put_object(bucket_name(), path, image) |> ExAws.request()

    case response do
      {:ok, %{status_code: 200}} -> {:ok, photo.filename}
      _ -> {:error, :could_not_upload_image_to_s3}
    end
  end

  def add_image_path_to_params(params, image_path) do
    params = Map.put(params, "image_path", image_path)
    {:ok, params}
  end

  defp bucket_name() do
    Application.fetch_env!(:ex_aws, :bucket_name)
  end
end
