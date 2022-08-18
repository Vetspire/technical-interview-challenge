defmodule VetspireInterviewWeb.Dogs.ShowLiveTest do
  use VetspireInterviewWeb.ConnCase

  test "connected mount", %{conn: conn} do
    dog = insert(:dog)

    {:ok, _view, html} =
      conn
      |> get(Routes.live_path(conn, VetspireInterviewWeb.Dogs.ShowLive, dog.breed))
      |> live()

    assert html =~ "Chihuahua"
    assert html =~ "Back to list"
    assert html =~ "<img src=\"/images/dogs/chihuahua.jpg\"/>"
  end
end
