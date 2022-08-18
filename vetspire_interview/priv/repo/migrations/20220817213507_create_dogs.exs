defmodule VetspireInterview.Repo.Migrations.CreateDogs do
  use Ecto.Migration

  alias VetspireInterview.Dogs

  @image_folder "priv/static/images/dogs"

  def up do
    create table(:dogs, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:breed, :string, null: false)
      add(:image_path, :string)

      timestamps()
    end

    create(unique_index(:dogs, [:breed]))

    flush()

    preload_database()
  end

  def down do
    drop(table(:dogs))
  end

  defp preload_database() do
    @image_folder
    |> File.ls!()
    |> Enum.map(fn image ->
      [breed_name | tail] = String.split(image, ".")

      Dogs.create_dog(%{
        image_path: image,
        breed: breed_name
      })
    end)
  end
end
