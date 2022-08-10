defmodule Playa.AutoloaderTest do
  use ExUnit.Case, async: true

  alias Playa.Autoloader

  @test_dir "test/support/images"

  describe "list_files/0" do
    test "returns a list containing filenames for given directory" do
      expected = [
        "great_dane.jpg",
        "affenpinscher.jpg",
        "boxer.jpg",
        "cocker_spaniel.jpg",
        "border_collie.jpg",
        "pomeranian.jpg",
        "irish_terrier.jpg",
        "norwich_terrier.jpg",
        "shetland_sheepdog.jpg",
        "english_bulldog.jpg",
        "phoenix.png"
      ]

      assert Autoloader.list_files(@test_dir) == expected
    end

    test "raises File.Error if directory doesn't exist" do
      assert_raise File.Error, fn ->
        Autoloader.list_files("nonexistent_directory")
      end
    end
  end

  describe "titleize_filename" do
    test "Removes extension and capitalizes word" do
      "Puppy" = Autoloader.titleize_filename("puppy.jpg")
    end

    test "Capitalizes the first letter of each word in a multi word filename" do
      "Blue Heeler" = Autoloader.titleize_filename("blue_heeler.jpg")
    end
  end
end
