defmodule BackendWeb.BreedControllerTest do
  use BackendWeb.ConnCase

  import Backend.DogsFixtures

  alias Backend.Dogs.Breed

  @create_attrs %{
    description: "some description",
    image: "some image",
    name: "some name"
  }
  @update_attrs %{
    description: "some updated description",
    image: "some updated image",
    name: "some updated name"
  }
  @invalid_attrs %{description: nil, image: nil, name: nil}

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
      conn = post(conn, Routes.breed_path(conn, :create), breed: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.breed_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => "some description",
               "image" => "some image",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.breed_path(conn, :create), breed: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update breed" do
    setup [:create_breed]

    test "renders breed when data is valid", %{conn: conn, breed: %Breed{id: id} = breed} do
      conn = put(conn, Routes.breed_path(conn, :update, breed), breed: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.breed_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => "some updated description",
               "image" => "some updated image",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, breed: breed} do
      conn = put(conn, Routes.breed_path(conn, :update, breed), breed: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete breed" do
    setup [:create_breed]

    test "deletes chosen breed", %{conn: conn, breed: breed} do
      conn = delete(conn, Routes.breed_path(conn, :delete, breed))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.breed_path(conn, :show, breed))
      end
    end
  end

  defp create_breed(_) do
    breed = breed_fixture()
    %{breed: breed}
  end
end
