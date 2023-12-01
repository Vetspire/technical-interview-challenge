defmodule Linneaus.Dog.BreedTest do
  alias Ecto.Changeset
  alias Linneaus.Dog
  use Linneaus.DataCase

  @valid_attrs %{
    name: "German Shepherd",
    image: %{asset_url: "path/to/asset.jpg"}
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

    test "returns {:error, %Changeset{}} if image is missing", %{} do
      assert {:error, changeset} =
               @valid_attrs
               |> Map.delete(:image)
               |> Dog.Breed.new()

      assert %Changeset{valid?: false, errors: errors} = changeset
      assert [image: {_, validation: :required}] = errors
    end

    test "returns {:error, %Changeset{}} if image attrs are invalid", %{} do
      assert {:error, changeset} =
               @valid_attrs
               |> Map.replace!(:image, %{})
               |> Dog.Breed.new()

      assert %Changeset{
               valid?: false,
               errors: [],
               changes: %{image: image}
             } = changeset

      assert %Changeset{valid?: false} = image
    end

    test "does not create image record if breed is invalid" do
      assert Linneaus.Repo.all(Dog.Image) |> length() == 0
      assert {:ok, %Dog.Breed{}} = Dog.Breed.new(@valid_attrs)
      assert Linneaus.Repo.all(Dog.Image) |> length() == 1
      assert {:error, %Changeset{}} = Dog.Breed.new(@valid_attrs)
      assert Linneaus.Repo.all(Dog.Image) |> length() == 1
    end
  end
end
