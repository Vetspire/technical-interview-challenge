defmodule ServerWeb.Schema.PetTypesTest do
  use ServerWeb.ConnCase, async: true

  import Mox

  setup :verify_on_exit!

  @dogs_query """
  query {
    dogs {
      uid
      breed
      description
      image_url
    }
  }
  """

  @dog_query """
  query dog($breed: String!){
    dog(breed: $breed) {
      uid
      breed
      description
      image_url
    }
  }
  """

  @create_dog_mutation """
  mutation create_dog($breed: String!, $description: String!, $filename: String!){
    create_dog(breed: $breed, description: $description, filename: $filename) {
      uid
      breed
      description
      image_url
    }
  }
  """

  describe "query dogs" do
    test "success: returns list of dogs", %{conn: conn} do
      english_bulldog = Factory.insert(:dog, breed: "english bulldog")
      boxer_dog = Factory.insert(:dog, breed: "boxer")

      params = %{
        "query" => @dogs_query
      }

      %{"data" => %{"dogs" => dogs}} = conn |> post("/graphql", params) |> json_response(200)

      assert length(dogs) == 2

      [first_dog, last_dog] = dogs

      assert first_dog["breed"] == boxer_dog.breed
      assert last_dog["breed"] == english_bulldog.breed
    end
  end

  describe "query dog" do
    test "success: returns dog", %{conn: conn} do
      persisted_dog = Factory.insert(:dog)

      params = %{
        "query" => @dog_query,
        "variables" => %{breed: persisted_dog.breed}
      }

      %{"data" => %{"dog" => fetched_dog}} =
        conn |> post("/graphql", params) |> json_response(200)

      assert persisted_dog.breed == fetched_dog["breed"]
    end

    @tag capture_log: true
    test "error: returns dog not found message", %{conn: conn} do
      params = %{
        "query" => @dog_query,
        "variables" => %{breed: "golden retriever"}
      }

      %{"errors" => errors} = conn |> post("/graphql", params) |> json_response(200)

      assert errors == [
               %{
                 "locations" => [%{"column" => 3, "line" => 2}],
                 "message" => "dog not found",
                 "path" => ["dog"]
               }
             ]
    end
  end

  describe "mutation create_dog" do
    test "success: returns dog", %{conn: conn} do
      expect(Server.MockS3, :put_object_copy, fn "dogs/golden_retriever.jpg", _opts ->
        {:ok, nil}
      end)

      expect(Server.MockS3, :put_object_acl, fn "dogs/golden_retriever.jpg", _opts ->
        {:ok, nil}
      end)

      expected_breed = "golden retriever"

      params = %{
        "query" => @create_dog_mutation,
        "variables" => %{
          breed: expected_breed,
          description: "about this dog",
          filename: "golden_retriever.jpg"
        }
      }

      %{"data" => %{"create_dog" => dog}} = conn |> post("/graphql", params) |> json_response(200)

      assert dog["breed"] == expected_breed
    end
  end
end
