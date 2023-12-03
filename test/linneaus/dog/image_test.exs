defmodule Linnaeus.Dog.ImageTest do
  use Linnaeus.DataCase
  alias Ecto.Changeset
  alias Linnaeus.Dog

  @attrs %{
    asset_url: "http://cdn.com/path/to/image.jpg",
    breed: %{
      name: "German Shepherd"
    }
  }

  describe "Dog.Image.new/1" do
    test "creates a new image and breed if attrs are valid" do
      assert {:ok, %Dog.Image{}} = Dog.Image.new(@attrs)
    end

    test "does not create image if breed name is not unique" do
      assert {:ok, %Dog.Image{}} = Dog.Image.new(@attrs)

      assert {:error, %Changeset{}} =
               Dog.Image.new(%{
                 @attrs
                 | asset_url: "new_asset_url.jpg"
               })
    end
  end
end
