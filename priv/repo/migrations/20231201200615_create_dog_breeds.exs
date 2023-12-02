defmodule Linnaeus.Repo.Migrations.CreateDogBreeds do
  use Ecto.Migration

  def change do
    create table(:dog_breeds) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:dog_breeds, [:name])
  end
end
