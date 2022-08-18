defmodule VetspireInterview.DogsTest do
  use VetspireInterview.DataCase

  alias VetspireInterview.Dogs
  alias VetspireInterview.Dogs.Dog

  describe "dogs" do
    test "list_dogs/0 returns all dogs" do
      dogs = Dogs.list_dogs()
      assert Enum.count(dogs) == 10
    end

    test "get_dog!/1 returns the dog with given id" do
      dog = insert(:dog)
      assert %Dog{id: dog_id} = Dogs.get_dog!(dog.id)
      assert dog_id == dog.id
    end

    test "get_dog_by_breed!/1 returns the dog with given breed" do
      insert(:dog)
      assert %Dog{breed: "chihuahua"} = Dogs.get_dog_by_breed!("chihuahua")
    end

    test "create_dog/1 with valid data creates a dog" do
      assert {:ok, %Dog{} = _dog} =
               Dogs.create_dog(%{
                 breed: "chihuahua",
                 image_path: "chihuahua.jpg"
               })
    end

    test "create_dog/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dogs.create_dog(%{})
    end

    test "change_dog/1 returns a dog changeset" do
      dog = insert(:dog)
      assert %Ecto.Changeset{} = Dogs.change_dog(dog)
    end
  end
end
