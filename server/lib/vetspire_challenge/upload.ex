defmodule VetspireChallenge.Upload do
  alias VetspireChallenge.Repo
  alias VetspireChallenge.Schemas.Breed

  def new_breed(name, path, extension) do
    encoded_name = Base.encode32(name)
    encoded_filename = "#{encoded_name}.#{extension}"

    changeset = Breed.changeset(%Breed{name: name, image: encoded_filename})

    with {:ok, breed} <- Repo.insert(changeset),
         :ok <- File.cp(path, "priv/static/images/#{encoded_filename}") do
      {:ok, breed}
    else
      _ -> {:error, "Something when wrong when creating the breed"}
    end
  end
end
