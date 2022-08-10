defmodule PlayaWeb.DogControllerTest do
  use PlayaWeb.ConnCase

  import Playa.DogsFixtures

  @update_attrs %{breed: "some updated breed"}
  @invalid_attrs %{breed: nil}

  describe "index" do
    test "lists all dogs", %{conn: conn} do
      conn = get(conn, Routes.dog_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Dogs"
    end
  end

  describe "new dog" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.dog_path(conn, :new))
      assert html_response(conn, 200) =~ "New Dog"
    end
  end

  describe "edit dog" do
    setup [:create_dog]

    @tag :skip
    test "renders form for editing chosen dog", %{conn: conn, dog: dog} do
      conn = get(conn, Routes.dog_path(conn, :edit, dog))
      assert html_response(conn, 200) =~ "Edit Dog"
    end
  end

  describe "update dog" do
    setup [:create_dog]

    @tag :skip
    test "redirects when data is valid", %{conn: conn, dog: dog} do
      conn = put(conn, Routes.dog_path(conn, :update, dog), dog: @update_attrs)
      assert redirected_to(conn) == Routes.dog_path(conn, :show, dog)

      conn = get(conn, Routes.dog_path(conn, :show, dog))
      assert html_response(conn, 200) =~ "some updated breed"
    end

    @tag :skip
    test "renders errors when data is invalid", %{conn: conn, dog: dog} do
      conn = put(conn, Routes.dog_path(conn, :update, dog), dog: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Dog"
    end
  end

  describe "delete dog" do
    setup [:create_dog]

    @tag :skip
    test "deletes chosen dog", %{conn: conn, dog: dog} do
      conn = delete(conn, Routes.dog_path(conn, :delete, dog))
      assert redirected_to(conn) == Routes.dog_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.dog_path(conn, :show, dog))
      end
    end
  end

  defp create_dog(_) do
    dog = dog_fixture()
    %{dog: dog}
  end
end
