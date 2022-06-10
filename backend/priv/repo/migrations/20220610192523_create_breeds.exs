defmodule Backend.Repo.Migrations.CreateBreeds do
  use Ecto.Migration

  def change do
    create table(:breeds) do
      add :name, :string
      add :image, :map
      add :description, :string

      timestamps()
    end
  end
end
