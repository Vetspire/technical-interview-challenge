defmodule VetspireInterviewWeb.Dogs.NewLiveTest do
  use VetspireInterviewWeb.ConnCase

  alias VetspireInterview.Dogs

  test "connected mount", %{conn: conn} do
    {:ok, _view, html} =
      conn
      |> get(Routes.live_path(conn, VetspireInterviewWeb.Dogs.NewLive))
      |> live()

    assert html =~ "New Dog"
    assert html =~ "Back to list"
    assert html =~ "Breed"
    assert html =~ "Breed Picture"
  end

  test "creates new dog", %{conn: conn} do
    {:ok, view, _html} =
      conn
      |> get(Routes.live_path(conn, VetspireInterviewWeb.Dogs.NewLive))
      |> live()

    {:ok, _, html} =
      view
      |> form("#dog-form",
        dog: %{
          "breed" => "New Breed"
        }
      )
      |> render_submit()
      |> follow_redirect(conn)

    assert Dogs.get_dog_by_breed!("new_breed")

    assert html =~ "Dog New breed was created successfully!"
  end
end
