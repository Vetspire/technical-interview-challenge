defmodule Linnaeus.Dog.BreedTest do
  use Linnaeus.DataCase

  alias Ecto.Changeset
  alias Linnaeus.Dog

  @valid_attrs %{
    name: "German Shepherd"
  }

  describe "Dog.Breed.new/1" do
    test "inserts a breed and image if attributes are valid", %{} do
      assert {:ok, %Dog.Breed{}} =
               Dog.Breed.new(@valid_attrs)
    end

    test "returns {:error, %Changeset{}} if name is missing", %{} do
      assert {:error, changeset} =
               @valid_attrs
               |> Map.delete(:name)
               |> Dog.Breed.new()

      assert %Changeset{valid?: false, errors: errors} = changeset
      assert [name: {_, validation: :required}] = errors
    end

    test "does not create record if breed already exists" do
      assert Linnaeus.Repo.all(Dog.Breed) |> length() == 0
      assert {:ok, %Dog.Breed{}} = Dog.Breed.new(@valid_attrs)
      assert Linnaeus.Repo.all(Dog.Breed) |> length() == 1
      assert {:error, %Changeset{}} = Dog.Breed.new(@valid_attrs)
      assert Linnaeus.Repo.all(Dog.Breed) |> length() == 1
    end
  end
end
