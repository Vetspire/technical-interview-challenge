defmodule Backend.DogsTest do
  use Backend.DataCase

  alias Backend.Dogs

  describe "breeds" do
    alias Backend.Dogs.Breed

    import Backend.DogsFixtures

    @invalid_attrs %{description: nil, image: nil, name: nil}

    test "list_breeds/0 returns all breeds" do
      breed = breed_fixture()
      assert Dogs.list_breeds() == [breed]
    end

    test "get_breed!/1 returns the breed with given id" do
      breed = breed_fixture()
      assert Dogs.get_breed!(breed.id) == breed
    end

    test "create_breed/1 with valid data creates a breed" do
      valid_attrs = %{
        description: "some description",
        image: %Backend.FileUpload{},
        name: "some name"
      }

      assert {:ok, %Breed{} = breed} = Dogs.create_breed(valid_attrs)
      assert breed.description == "some description"
      assert %Backend.FileUpload{} = breed.image
      assert breed.name == "some name"
    end

    test "create_breed/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dogs.create_breed(@invalid_attrs)
    end

    test "delete_breed/1 deletes the breed" do
      breed = breed_fixture()
      assert {:ok, %Breed{}} = Dogs.delete_breed(breed)
      assert_raise Ecto.NoResultsError, fn -> Dogs.get_breed!(breed.id) end
    end
  end
end
