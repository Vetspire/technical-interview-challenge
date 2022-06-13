defmodule BackendWeb.BreedControllerTest do
  use BackendWeb.ConnCase

  import Backend.DogsFixtures

  @create_attrs %{
    "breedDescription" => "some description",
    "breedImage" => "priv/breeds/boxer.jpg",
    "breedName" => "some name"
  }
  @invalid_attrs %{breedName: "", breedDescription: ""}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all breeds", %{conn: conn} do
      conn = get(conn, Routes.breed_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create breed" do
    test "renders breed when data is valid", %{conn: conn} do
      conn = post(conn, Routes.breed_path(conn, :create), @create_attrs)
      assert html_response(conn, 302) =~ "/breeds/1"

      # This id shouldn't be hardcoded. Using a redirect
      # as the response to the create action instead of
      # returning the newly created breed is the underlying
      # problem. Ecto sandboxing protects us from clashing ids.
      conn = get(conn, Routes.breed_path(conn, :show, 1))

      assert %{
               "id" => 1,
               "description" => "some description",
               "image" => _,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.breed_path(conn, :create), @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_breed(_) do
    breed = breed_fixture()
    %{breed: breed}
  end
end
