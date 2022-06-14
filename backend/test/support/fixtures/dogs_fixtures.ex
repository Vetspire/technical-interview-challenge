defmodule Backend.DogsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Backend.Dogs` context.
  """

  @doc """
  Generate a breed.
  """
  def breed_fixture(attrs \\ %{}) do
    {:ok, breed} =
      attrs
      |> Enum.into(%{
        description: "some description",
        image: %Backend.FileUpload{},
        name: "some name"
      })
      |> Backend.Dogs.create_breed()

    breed
  end
end
