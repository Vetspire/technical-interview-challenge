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
        assert breed["id"] == String.to_integer(id)
        assert breed |> Map.keys() |> length() == 3

        for key <- ["name", "image_id"] do
          assert Map.fetch!(breed, key)
        end
      end

      assert map_size(images) == @limit

      for {id, image} <- images do
        assert id =~ ""
        assert image["id"] == String.to_integer(id)

        assert image |> Map.keys() |> length() == 3

        for key <- ["asset_url", "breed_id"] do
          assert Map.fetch!(image, key)
        end
      end
    end
  end
end
