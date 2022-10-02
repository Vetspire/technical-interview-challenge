defmodule Server.Repo.Migrations.CreateDogs do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS pgcrypto"

    create table(:dogs) do
      add :uid, :uuid, null: false, default: fragment("gen_random_uuid()")
      add :breed, :string, null: false
      add :description, :text, null: false
      add :image_url, :string, null: false

      timestamps()
    end

    create unique_index(:dogs, [:breed])
  end
end
