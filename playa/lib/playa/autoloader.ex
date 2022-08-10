defmodule Playa.Autoloader do
  # Things that this will need to handle:
  # - Read images from the local directory
  # - Upload images to S3
  # - Create the entry in the local database
  alias Playa.Dogs
  alias Playa.Dogs.Dog
  alias Playa.Repo

  @base_path "priv/static/images"

  def autoload do
    filenames = list_files()

    Enum.map(filenames, fn filename ->
      dog_params = %{
        "breed" => titleize_filename(filename),
        "photo" => %{path: Path.join([@base_path, filename]), filename: filename}
      }

      {:ok, _dog} = Dogs.create_dog(dog_params)
    end)

    :ok
  end

  @doc """
  Will delete all dogs in the database and remove their associated images from S3 bucket
  """
  def unload! do
    dogs = Repo.all(Dog)

    Enum.map(dogs, fn dog -> Dogs.delete_dog(dog) end)

    :ok
  end

  @spec list_files() :: [String.t()]
  def list_files(dir \\ @base_path) do
    File.ls!(dir)
  end

  @spec titleize_filename(String.t()) :: String.t()
  def titleize_filename(filename) do
    filename
    |> String.downcase()
    |> String.split(".")
    |> (fn [dog, _ext] -> dog end).()
    |> String.replace("_", " ")
    |> String.split(" ")
    |> Enum.map(fn string -> String.capitalize(string) end)
    |> Enum.join(" ")
  end
end
