defmodule Backend.Dogs.Breed do
  use Ecto.Schema
  import Ecto.Changeset

  alias Backend.FileUpload

  @moduledoc """
  Represents and stores a breed of dogs.

  Embeds a `#{FileUpload}` which contains info about where the image is stored.
  """

  schema "breeds" do
    field :description, :string
    field :name, :string
    embeds_one :image, FileUpload

    timestamps()
  end

  def changeset(breed, attrs) do
    breed
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end

  @doc """
  Create a changeset with an attached image.

  Most calling code will probably want to hande the upload and pass the FileUpload here.
  """
  def upload_changeset(breed, %{image: file_upload} = attrs) do
    breed
    |> cast(attrs, [:name, :description])
    |> put_embed(:image, file_upload)
    |> validate_required([:name, :image, :description])
  end
end
