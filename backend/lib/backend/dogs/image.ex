defmodule Backend.Dogs.Image do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :upload_type, Ecto.Enum, values: [:s3, :local], default: :local
    field :filename, :string
    field :original_filename, :string
  end

  def changeset(image, attrs) do
    image
    |> cast(attrs, [:filename, :original_filename, :upload_type])
    |> validate_required([:filename])
  end
end
