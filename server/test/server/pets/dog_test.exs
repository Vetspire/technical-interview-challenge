defmodule Server.Pets.DogTest do
  use Server.DataCase, async: true

  @schema_fields ~w(breed description image_url)a

  @schema_create_required_fields ~w(breed description image_url)a

  @vaild_attrs %{
    "breed" => "cavapoo",
    "description" =>
      "The Cavapoo is a mixed breed dog — a cross between the Cavalier King Charles Spaniel and Poodle dog breeds. Outgoing, playful, and curious, these pups inherit some of the best traits from both of their parents. Cavapoos go by several names, including Cavadoodle and Cavoodle.",
    "image_url" => "https://placedog.net/500"
  }

  describe "create_changeset/2" do
    test "success: return a valid changeset when given a valid arguments" do
      attrs = @vaild_attrs

      changeset = Dog.create_changeset(%Dog{}, attrs)

      assert %Changeset{valid?: true, changes: changes} = changeset

      for field <- @schema_fields do
        actual = changes[field]
        expected = attrs[Atom.to_string(field)]

        assert actual == expected,
               "Values did not match for field: #{field}\nexpected: #{inspect(expected)}\nactual: #{inspect(actual)}"
      end
    end

    test "success: return a valid changeset when given a valid arguments and downcase breed" do
      attrs = Map.merge(@vaild_attrs, %{"breed" => "Golden Retriever"})

      changeset = Dog.create_changeset(%Dog{}, attrs)

      assert %Changeset{valid?: true, changes: changes} = changeset

      actual = changes[:breed]
      expected = String.downcase(attrs["breed"])

      assert actual == expected,
             "Values did not match for field: breed\nexpected: #{inspect(expected)}\nactual: #{inspect(actual)}"
    end

    test "error: return an error changeset when given un-castable values" do
      not_a_string = DateTime.utc_now()

      attrs = %{
        "breed" => not_a_string,
        "description" => not_a_string,
        "image_url" => not_a_string
      }

      changeset = Dog.create_changeset(%Dog{}, attrs)

      assert %Changeset{valid?: false, errors: errors} = changeset

      for field <- @schema_fields do
        assert errors[field], "Expected an error for #{field}"
        {_, meta} = errors[field]

        assert meta[:validation] == :cast,
               "The validation type, #{meta[:validation]}, is incorrect"
      end
    end

    test "error: return error changeset when required fields are missing" do
      attrs = %{}

      changeset = Dog.create_changeset(%Dog{}, attrs)

      assert %Changeset{valid?: false, errors: errors} = changeset

      for field <- @schema_create_required_fields do
        assert errors[field], "The field #{inspect(field)} is missing from errors"

        {_, meta} = errors[field]

        assert meta[:validation] == :required,
               "The validation type, #{meta[:validation]}, is incorrect"
      end
    end

    test "error: return error changeset when breed has already been taken" do
      breed = "golden retriever"
      Factory.insert(:dog, breed: breed)

      attrs = Map.merge(@vaild_attrs, %{"breed" => breed})

      changeset = Dog.create_changeset(%Dog{}, attrs)

      assert {:error, %Changeset{errors: errors}} = Repo.insert(changeset)

      assert {"Breed is already taken",
              [constraint: :unique, constraint_name: "dogs_breed_index"]} ==
               errors[:breed]
    end

    test "error: return error changeset when image_url is not a valid value" do
      attrs = Map.merge(@vaild_attrs, %{"image_url" => "placedog.net/500"})

      changeset = Dog.create_changeset(%Dog{}, attrs)

      assert %Changeset{valid?: false, errors: errors} = changeset

      assert errors[:image_url], "The field :image_url is missing from errors"

      {_, meta} = errors[:image_url]

      assert meta[:validation] == :value,
             "The validation type, #{meta[:validation]}, is incorrect"
    end
  end
end
