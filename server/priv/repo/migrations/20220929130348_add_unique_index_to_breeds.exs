defmodule VetspireChallenge.Repo.Migrations.AddUniqueIndexToBreeds do
  use Ecto.Migration

  def change do
    create index(:breeds, [:name], unique: true)
  end
end
