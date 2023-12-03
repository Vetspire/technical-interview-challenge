defmodule Linnaeus.Dog.Breed do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc """
  Model representing a dog breed.

  The scenario I imagined when writing this code was that we were creating
  a very bare-bones MVP to get some feedback on our product direction, but
  we felt reasonably confident that we were going to expand the product in
  the future to include different types of animals, and also likely allow
  multiple images per breed plus maybe some user account management for
  uploading.

  I decided to use a Protocol-based approach for my models, because I feel
  it gives us the option to change up the architecture in the future,
  without adding too much code complexity in the current implementation.

  This would definitely be something that I would discuss with the product
  team before implementing, because if there's no chance we would expand to
  different animal types then there's no point in adding an extra layer of
  abstraction.

  """

  @derive Linnaeus.Breed
  @derive {Jason.Encoder, only: [:id, :name]}

  schema "dog_breeds" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  def new(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Linnaeus.Repo.insert()
  end

  @doc false
  def changeset(breed, attrs) do
    breed
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
