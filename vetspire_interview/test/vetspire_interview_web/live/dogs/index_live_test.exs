defmodule VetspireInterviewWeb.Dogs.IndexLiveTest do
  use VetspireInterviewWeb.ConnCase

  test "connected mount", %{conn: conn} do
    {:ok, _view, html} =
      conn
      |> get(Routes.live_path(conn, VetspireInterviewWeb.Dogs.IndexLive))
      |> live()

    assert html =~ "Dogs by breed"
    assert html =~ "<a href=\"/affenpinscher\">Affenpinscher</a>"
    assert html =~ "<a href=\"/border_collie\">Border collie</a>"
    assert html =~ "<a href=\"/boxer\">Boxer</a>"
    assert html =~ "<a href=\"/cocker_spaniel\">Cocker spaniel</a>"
    assert html =~ "<a href=\"/english_bulldog\">English bulldog</a>"
    assert html =~ "<a href=\"/great_dane\">Great dane</a>"
    assert html =~ "<a href=\"/irish_terrier\">Irish terrier</a>"
    assert html =~ "<a href=\"/norwich_terrier\">Norwich terrier</a>"
    assert html =~ "<a href=\"/pomeranian\">Pomeranian</a>"
    assert html =~ "<a href=\"/shetland_sheepdog\">Shetland sheepdog</a>"
  end
end
