defmodule PlayaWeb.DogControllerTest do
  use PlayaWeb.ConnCase

  import Playa.DogsFixtures

  @create_attrs %{breed: "some breed"}
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

  describe "create dog" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.dog_path(conn, :create), dog: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.dog_path(conn, :show, id)

      conn = get(conn, Routes.dog_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Dog"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.dog_path(conn, :create), dog: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Dog"
    end
  end

  describe "edit dog" do
    setup [:create_dog]

    test "renders form for editing chosen dog", %{conn: conn, dog: dog} do
      conn = get(conn, Routes.dog_path(conn, :edit, dog))
      assert html_response(conn, 200) =~ "Edit Dog"
    end
  end

  describe "update dog" do
    setup [:create_dog]

    test "redirects when data is valid", %{conn: conn, dog: dog} do
      conn = put(conn, Routes.dog_path(conn, :update, dog), dog: @update_attrs)
      assert redirected_to(conn) == Routes.dog_path(conn, :show, dog)

      conn = get(conn, Routes.dog_path(conn, :show, dog))
      assert html_response(conn, 200) =~ "some updated breed"
    end

    test "renders errors when data is invalid", %{conn: conn, dog: dog} do
      conn = put(conn, Routes.dog_path(conn, :update, dog), dog: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Dog"
    end
  end

  describe "delete dog" do
    setup [:create_dog]

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
