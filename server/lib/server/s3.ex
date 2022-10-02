defmodule Server.S3 do
  @moduledoc """
  The S3 context.
  """

  @callback presigned_post(String.t(), keyword()) :: map()
  @callback upload(binary(), String.t()) :: {:ok, term} | {:error, term}

  @pet_types ~w(dog)
  @pet_types_to_directory %{
    "dog" => "dogs"
  }

  @spec presigned_post(String.t(), keyword()) :: map()
  def presigned_post(s3_path, opts \\ []) do
    ExAws.Config.new(:s3) |> ExAws.S3.presigned_post(bucket(), s3_path, opts) |> IO.inspect()
  end

  @spec upload(binary(), String.t()) :: {:ok, term} | {:error, term}
  def upload(content, s3_path) when is_binary(content) and is_binary(s3_path) do
    content_type = MIME.from_path(s3_path)
    opts = [content_type: content_type, acl: :public_read]

    bucket()
    |> ExAws.S3.put_object(s3_path, content, opts)
    |> ExAws.request()
  end

  @spec s3_url(String.t()) :: String.t()
  def s3_url(s3_path) when is_binary(s3_path) do
    "https://#{bucket()}.s3.#{region()}.amazonaws.com/#{s3_path}"
  end

  @spec get_s3_path(String.t(), String.t()) :: String.t()
  def get_s3_path(pet_type, filename) when pet_type in @pet_types and is_binary(filename) do
    pet_directory = pet_types_to_pet_directory(pet_type)
    "#{pet_directory}/#{filename}"
  end

  defp pet_types_to_pet_directory(pet_type) do
    Map.fetch!(@pet_types_to_directory, pet_type)
  end

  defp bucket, do: Application.fetch_env!(:server, :aws_bucket)
  defp region, do: Application.get_env(:ex_aws, :region)
end
