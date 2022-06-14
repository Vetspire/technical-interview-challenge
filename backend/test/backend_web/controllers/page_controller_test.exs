defmodule BackendWeb.PageControllerTest do
  use BackendWeb.ConnCase

  test "GET / for react root element", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ ~s(<div id="app"></div>)
  end
end
