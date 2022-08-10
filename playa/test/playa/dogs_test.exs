defmodule Playa.DogsTest do
  use Playa.DataCase

  alias Playa.Dogs

  describe "dogs" do
    alias Playa.Dogs.Dog

    import Playa.DogsFixtures

    @invalid_attrs %{breed: nil}

    @tag :skip
    test "list_dogs/0 returns all dogs" do
      dog = dog_fixture()
      assert Dogs.list_dogs() == [dog]
    end

    @tag :skip
    test "get_dog!/1 returns the dog with given id" do
      dog = dog_fixture()
      assert Dogs.get_dog!(dog.id) == dog
    end

    @tag :skip
    test "create_dog/1 with valid data creates a dog" do
      valid_attrs = %{breed: "some breed", photo: %{path: "path", filename: "filename"}}

      assert {:ok, %Dog{} = dog} = Dogs.create_dog(valid_attrs)
      assert dog.breed == "some breed"
    end

    @tag :skip
    test "create_dog/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dogs.create_dog(@invalid_attrs)
    end

    @tag :skip
    test "update_dog/2 with valid data updates the dog" do
      dog = dog_fixture()
      update_attrs = %{breed: "some updated breed"}

      assert {:ok, %Dog{} = dog} = Dogs.update_dog(dog, update_attrs)
      assert dog.breed == "some updated breed"
    end

    @tag :skip
    test "update_dog/2 with invalid data returns error changeset" do
      dog = dog_fixture()
      assert {:error, %Ecto.Changeset{}} = Dogs.update_dog(dog, @invalid_attrs)
      assert dog == Dogs.get_dog!(dog.id)
    end

    @tag :skip
    test "delete_dog/1 deletes the dog" do
      dog = dog_fixture()
      assert {:ok, %Dog{}} = Dogs.delete_dog(dog)
      assert_raise Ecto.NoResultsError, fn -> Dogs.get_dog!(dog.id) end
    end

    @tag :skip
    test "change_dog/1 returns a dog changeset" do
      dog = dog_fixture()
      assert %Ecto.Changeset{} = Dogs.change_dog(dog)
    end
  end
end
