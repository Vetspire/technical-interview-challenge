defmodule Linnaeus.Dog.Image do
  use Ecto.Schema
  import Ecto.Changeset

  alias Linnaeus.Dog

  @moduledoc """
  A model representing an image of a dog breed.

  Currently Dog.Breed and Dog.Image have a 1:1 relationship, so it would be
  reasonable to put the :asset_url in Dog.Breed and not have a separate
  model for images. However, I still decided to separate them because there
  seems to me to be a clear separation of concerns between them. This is
  another area where my goal was to maximize future flexibility, without
  saddling the codebase with too much complexity. Again, this idea
  would be discussed with the larger team before implementing.

  Another note: I initially considered having a "images" table and a
  "breeds" table, and potentially adding a :type column to the breed table
  (which would initially be just dog), but once I settled on the Protocol
  approach, it made sense to me to give each protocol implementation its own
  database table So, currently there are 2 tables "dog_images" and "dog_breeds",
  and each new animal type will add 2 new tables to the database. Or if we add
  a new protocol, that adds 1 more table for each animal type.
  """

  @derive Linnaeus.Image

  schema "dog_images" do
    field :asset_url, :string
    belongs_to :breed, Dog.Breed

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:asset_url])
    |> validate_required([:asset_url])
    |> unique_constraint(:asset_url)
  end
end
