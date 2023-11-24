defmodule VetspireTakeHome.Breeds do
  alias VetspireTakeHome.Breeds.Breed
  alias VetspireTakeHome.Repo

  def list_breeds() do
    Repo.all(Breed)
  end

  def get_breed(id) do
    Repo.get(Breed, id)
  end
end
