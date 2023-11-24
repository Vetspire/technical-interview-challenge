defmodule VetspireTakeHome.Repo.Migrations.CreateBreeds do
  use Ecto.Migration

  def change do
    create table(:breeds) do
      add(:name, :string, null: false)
      add(:image_url, :string, null: false)

      timestamps()
    end
  end
end
