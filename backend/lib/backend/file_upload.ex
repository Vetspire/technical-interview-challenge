defmodule Backend.FileUpload do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :upload_type, Ecto.Enum, values: [:r2, :local, :test], default: :local
    field :filename, :string
    field :original_filename, :string
  end

  def new(attrs) do
    changeset(%__MODULE__{}, attrs)
  end

  def changeset(file_upload, attrs) do
    file_upload
    |> cast(attrs, [:filename, :original_filename, :upload_type])
    |> validate_required([:filename, :upload_type])
  end
end
