defmodule ServerWeb.Resolvers.Pets do
  @moduledoc """
  The Pets Resolver context
  """

  alias Server.Pets
  alias Server.S3

  require Logger

  def list_dogs(_args, _resolution) do
    {:ok, Pets.list_dogs()}
  end

  def get_dog(args, _resolution) do
    {:ok, Pets.get_dog!(args.breed)}
  rescue
    e in Ecto.NoResultsError ->
      Logger.error("[[#{__MODULE__}]] error log message: #{e.message}")

      {:error, "dog not found"}
  end

  def create_dog(args, _resolution) do
    s3_path = S3.get_s3_path("dog", args.filename)
    image_url = S3.s3_url(s3_path)

    attrs = %{
      breed: args.breed,
      description: args.description,
      image_url: image_url
    }

    content_type = MIME.from_path(s3_path)
    copy_opts = [content_type: content_type, metadata_directive: :REPLACE]
    acl_opts = [acl: :public_read]

    with {:ok, _} <- s3().put_object_copy(s3_path, copy_opts),
         {:ok, _} <- s3().put_object_acl(s3_path, acl_opts),
         {:ok, dog} <- Pets.create_dog(attrs) do
      {:ok, dog}
    end
  end

  defp s3, do: Application.get_env(:server, :s3, Server.S3)
end
