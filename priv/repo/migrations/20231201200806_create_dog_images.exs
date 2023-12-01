defmodule Linneaus.Repo.Migrations.CreateDogImages do
  use Ecto.Migration

  def change do
    create table(:dog_images) do
      add :asset_url, :string
      add :breed_id, references(:dog_breeds, on_delete: :nothing), null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:dog_images, [:asset_url])
    create index(:dog_images, [:breed_id])
  end
end
