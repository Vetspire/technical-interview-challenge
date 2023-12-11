defmodule Dogbook.Repo.Migrations.CreateBreeds do
  use Ecto.Migration

  def change do
    create table(:breeds) do
      add :name, :string
      add :example_image, :string
    end
  end
end
