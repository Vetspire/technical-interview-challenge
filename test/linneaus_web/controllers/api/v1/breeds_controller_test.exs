defmodule LinnaeusWeb.Api.V1.BreedsControllerTest do
  use LinnaeusWeb.ConnCase
  alias Mix.Tasks.Linnaeus.SeedDb

  @limit 2

  setup do
    SeedDb.seed_db(%{limit: @limit})
  end

  describe "GET /api/v1/breeds/:type" do
    test "returns 404 when type is not dog", %{conn: conn} do
      response = get(conn, ~s(/api/v1/breeds/cat))
      assert json_response(response, 404)
    end

    test "returns 200 when type is dog", %{conn: conn} do
      conn = get(conn, ~s(/api/v1/breeds/dog))
      assert %{"breeds" => breeds, "images" => images} = json_response(conn, 200)

      assert map_size(breeds) == @limit

      for {id, breed} <- breeds do
        assert id =~ ""
        assert breed |> Map.keys() |> length() == 3
        assert Map.fetch!(breed, "id") == String.to_integer(id)
        assert Map.fetch!(breed, "name")

        assert %{} =
                 Map.fetch!(
                   images,
                   breed |> Map.fetch!("image_id") |> Integer.to_string()
                 )
      end

      assert map_size(images) == @limit

      for {id, image} <- images do
        assert id =~ ""
        assert image["id"] == String.to_integer(id)

        assert image |> Map.keys() |> length() == 3

        assert Map.fetch!(image, "id")
        assert Map.fetch!(image, "asset_url")
        assert %{} = Map.fetch!(breeds, image |> Map.fetch!("breed_id") |> Integer.to_string())
      end
    end
  end

  @valid_attrs %{
    "asset_url" => "http://cdn.com/path/to/asset.jpg",
    "breed_name" => "German Shepherd"
  }

  describe "POST /api/v1/breeds/:type" do
    test "returns 200 when breed is created", %{conn: conn} do
      conn =
        conn
        |> assign(:asset_url, @valid_attrs["asset_url"])
        |> post(~s(/api/v1/breeds/dog), @valid_attrs)

      response = assert json_response(conn, :created)
      assert %{"breeds" => %{}, "images" => %{}} = response
    end

    test "returns 400 if post body is invalid", %{conn: conn} do
      conn = post(conn, ~s(/api/v1/breeds/dog), Map.delete(@valid_attrs, "asset_url"))
      response = assert json_response(conn, 400)
      assert response == %{"errors" => %{"asset_url" => ["can't be blank"]}}
    end
  end
end
