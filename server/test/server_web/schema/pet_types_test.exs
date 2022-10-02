defmodule ServerWeb.Schema.PetTypesTest do
  use ServerWeb.ConnCase

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

  describe "query dogs" do
    test "success: returns list of dogs", %{conn: conn} do
      english_bulldog = Factory.insert(:dog, breed: "english bulldog")
      boxer_dog = Factory.insert(:dog, breed: "boxer")

      params = %{
        "query" => @dogs_query
      }

      %{"data" => %{"dogs" => dogs}} = conn |> post("/api", params) |> json_response(200)

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

      %{"data" => %{"dog" => fetched_dog}} = conn |> post("/api", params) |> json_response(200)

      assert persisted_dog.breed == fetched_dog["breed"]
    end

    @tag capture_log: true
    test "error: returns dog not found message", %{conn: conn} do
      params = %{
        "query" => @dog_query,
        "variables" => %{breed: "golden retriever"}
      }

      %{"errors" => errors} = conn |> post("/api", params) |> json_response(200)

      assert errors == [
               %{
                 "locations" => [%{"column" => 3, "line" => 2}],
                 "message" => "dog not found",
                 "path" => ["dog"]
               }
             ]
    end
  end
end
