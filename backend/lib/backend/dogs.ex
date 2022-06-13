defmodule Backend.Dogs do
  @moduledoc """
  The Dogs context.
  """

  import Ecto.Query, warn: false
  alias Backend.Repo

  alias Backend.Dogs.Breed

  @doc """
  Returns the list of breeds.

  ## Examples

      iex> list_breeds()
      [%Breed{}, ...]

  """
  def list_breeds do
    Repo.all(Breed)
  end

  @doc """
  Gets a single breed.

  Raises `Ecto.NoResultsError` if the Breed does not exist.

  ## Examples

      iex> get_breed!(123)
      %Breed{}

      iex> get_breed!(456)
      ** (Ecto.NoResultsError)

  """
  def get_breed!(id), do: Repo.get!(Breed, id)

  @doc """
  Creates a breed.

  ## Examples

      iex> create_breed(%{field: value})
      {:ok, %Breed{}}

      iex> create_breed(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_breed(attrs \\ %{}) do
    %Breed{}
    |> Breed.upload_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Deletes a breed.

  ## Examples

      iex> delete_breed(breed)
      {:ok, %Breed{}}

      iex> delete_breed(breed)
      {:error, %Ecto.Changeset{}}

  """
  def delete_breed(%Breed{} = breed) do
    Repo.delete(breed)
  end
end
