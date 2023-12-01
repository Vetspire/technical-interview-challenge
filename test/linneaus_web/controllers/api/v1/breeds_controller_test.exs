defmodule LinnaeusWeb.Api.V1.BreedsControllerTest do
  use LinnaeusWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~s(/api/v1/breeds/))
    response = json_response(conn, 200)
    assert is_list(response)

    for breed <- response do
      assert breed |> Map.keys() |> length() == 3

      for key <- [:id, :name, :image_path] do
        assert breed[Atom.to_string(key)]
      end
    end
  end
end
