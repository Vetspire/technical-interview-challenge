defmodule Backend.BreedLoader do
  @moduledoc """
  A quick module to upload the default breeds.

  Not idempotent and no guards so be careful to only run it once.
  """
  alias Backend.Dogs
  alias BackendWeb.Uploader

  def load_defaults do
    breed_listings = "priv/breeds/listings.json" |> File.read!() |> Jason.decode!()

    breed_listings
    |> Enum.map(&upload_breed/1)
    |> Enum.split_with(fn
      {:error, _err} -> false
      _ -> true
    end)
  end

  def upload_breed(%{"name" => name, "description" => description, "image" => src_file}) do
    with {:ok, file_upload} <- Uploader.upload_file(src_file),
    {:ok, breed} = Dogs.create_breed(%{name: name, description: description, image: file_upload}) do
      breed
    end
  end
end
