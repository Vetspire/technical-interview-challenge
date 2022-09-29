defmodule VetspireChallenge.Repo.Migrations.CreateBreeds do
  use Ecto.Migration

  def change do
    create table(:breeds) do
      add :name, :string, null: false
      add :image, :string, null: false
    end
  end
end
