defmodule Playa.Repo.Migrations.CreateDogs do
  use Ecto.Migration

  def change do
    create table(:dogs) do
      add :breed, :string
      add :image_path, :string

      timestamps()
    end
  end
end
