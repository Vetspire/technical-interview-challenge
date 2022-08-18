defmodule VetspireInterview.Dogs do
  @moduledoc """
  The `VetspireInterview.Dogs` context for retrieving and manipulating `VetspireInterview.Dogs.Dog`s.
  """

  import Ecto.Query, warn: false

  alias VetspireInterview.Dogs.Dog
  alias VetspireInterview.Repo

  @doc """
  Returns the list of `VetspireInterview.Dogs.Dog`s.

  ## Examples

      iex> list_dogs()
      [%Dog{}, ...]

  """
  @spec list_dogs() :: [Dog.t()]
  def list_dogs, do: Repo.all(Dog)

  @doc """
  Gets a single `VetspireInterview.Dogs.Dog`.

  Raises `Ecto.NoResultsError` if the `Dog` does not exist.

  ## Examples

      iex> get_dog!(123)
      %Dog{}

      iex> get_dog!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get_dog!(String.t()) :: Dog.t()
  def get_dog!(id), do: Repo.get!(Dog, id)

  @doc """
  Gets a single `VetspireInterview.Dogs.Dog` by their `breed`.

  Raises `Ecto.NoResultsError` if the `Dog` does not exist.

  ## Examples

      iex> get_dog_by_breed!("pomeranian")
      %Dog{}

      iex> get_dog_by_breed!("chihuahua")
      ** (Ecto.NoResultsError)

  """
  @spec get_dog_by_breed!(String.t()) :: Dog.t()
  def get_dog_by_breed!(breed), do: Repo.get_by!(Dog, breed: breed)

  @doc """
  Creates a `VetspireInterview.Dogs.Dog`.

  ## Examples

      iex> create_dog(%{field: value})
      {:ok, %Dog{}}

      iex> create_dog(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_dog(map) :: Repo.result()
  def create_dog(attrs \\ %{}) do
    %Dog{}
    |> Dog.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking `VetspireInterview.Dogs.Dog` changes.

  ## Examples

      iex> change_dog(dog)
      %Ecto.Changeset{source: %Dog{}}

  """
  @spec change_dog(Dog.t()) :: Ecto.Changeset.t()
  def change_dog(%Dog{} = dog, attrs \\ %{}), do: Dog.changeset(dog, attrs)
end
