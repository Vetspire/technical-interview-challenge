defmodule Server.Pets do
  @moduledoc """
  The Pets context
  """

  import Ecto.Query

  alias Server.Pets.Dog
  alias Server.Repo

  @doc """
  Returns the list of dogs.

  ## Examples

      iex> list_dogs()
      [%Dog{}, ...]

  """
  def list_dogs do
    Repo.all(from(d in Dog, order_by: [:breed]))
  end

  @doc """
  Gets a single dog by breed.

  Raises `Ecto.NoResultsError` if the Dog does not exist.

  ## Examples

      iex> get_dog!("golden retriever")
      %Dog{}

      iex> get_dog!("golden retriever")
      ** (Ecto.NoResultsError)

  """
  def get_dog!(breed), do: Repo.get_by!(Dog, breed: breed)
end
