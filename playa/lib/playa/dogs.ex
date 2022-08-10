defmodule Playa.Dogs do
  @moduledoc """
  The Dogs context.
  """
  alias Playa.Dogs.Dog
  alias Playa.Repo
  alias Playa.S3

  import Ecto.Query, warn: false

  @doc """
  Returns the list of dogs.

  ## Examples

      iex> list_dogs()
      [%Dog{}, ...]

  """
  def list_dogs do
    Repo.all(Dog)
  end

  @doc """
  Gets a single dog.

  Raises `Ecto.NoResultsError` if the Dog does not exist.

  ## Examples

      iex> get_dog!(123)
      %Dog{}

      iex> get_dog!(456)
      ** (Ecto.NoResultsError)

  """
  def get_dog!(id), do: Repo.get!(Dog, id)

  @doc """
  Creates a dog.

  ## Examples

      iex> create_dog(%{field: value})
      {:ok, %Dog{}}

      iex> create_dog(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_dog(attrs \\ %{}) do
    with {:ok, image_path} <- S3.upload_image(attrs),
         {:ok, attrs} <- add_image_path_to_params(attrs, image_path) do
      %Dog{}
      |> Dog.changeset(attrs)
      |> Repo.insert()
    end
  end

  @doc """
  Updates a dog.

  ## Examples

      iex> update_dog(dog, %{field: new_value})
      {:ok, %Dog{}}

      iex> update_dog(dog, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_dog(%Dog{} = dog, attrs) do
    dog
    |> Dog.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a dog.

  ## Examples

      iex> delete_dog(dog)
      {:ok, %Dog{}}

      iex> delete_dog(dog)
      {:error, %Ecto.Changeset{}}

  """
  def delete_dog(%Dog{} = dog) do
    with :ok <- S3.delete_image(dog.image_path) do
      Repo.delete(dog)
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking dog changes.

  ## Examples

      iex> change_dog(dog)
      %Ecto.Changeset{data: %Dog{}}

  """
  def change_dog(%Dog{} = dog, attrs \\ %{}) do
    Dog.changeset(dog, attrs)
  end

  defp add_image_path_to_params(params, image_path) do
    params = Map.put(params, "image_path", image_path)
    {:ok, params}
  end
end
