defmodule Dogbook.LiveEntryPoints.Breeds.Api do
  alias Dogbook.Schema.Breed
  alias Dogbook.Repo

  def prepare_index() do
    %{breeds: list_breeds(), breed_form: new_changeset()}
  end

  defp list_breeds() do
    Breed
    |> Repo.all()
    |> Enum.map(&serialize_breed/1)
  end

  def new_changeset() do
    %Breed{} |> Ecto.Changeset.change()
  end

  def update_changeset(changeset, params) do
    changeset |> Ecto.Changeset.cast(params, [:name])
  end

  def create_breed(params) do
    with {:ok, breed} <- persist_breed(params) do
      serialize_breed(breed)
    end
  end

  defp persist_breed(params) do
    %Breed{}
    |> Ecto.Changeset.cast(params, [:name, :example_image])
    |> Repo.insert()
  end

  defp serialize_breed(breed) do
    Map.put(breed, :url, "#{upload_host()}#{breed.example_image}")
  end

  defp upload_host() do
    Application.get_env(:dogbook, :upload_host)
  end
end
