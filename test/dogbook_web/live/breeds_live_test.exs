defmodule DogbookWeb.BreedsLiveTest do
	use DogbookWeb.ConnCase

	import Phoenix.LiveViewTest
	import Ecto.Changeset

	alias Dogbook.Repo
	alias Dogbook.Schema.Breed

	test "lists dog breeds", %{conn: conn} do
		boxer = create_breed("Boxer", "abc123")
		great_dane = create_breed("Great Dane", "abc124")
		bulldog = create_breed("English Bulldog", "abc125")

	  {:ok, view, _html} = get(conn, "/") |> live()

	  assert view |> element("div", "Breeds") |> has_element?()

	  assert view |> element("#breed_row_#{boxer.id}", "Boxer") |> has_element?()
	  assert view |> element("#breed_row_#{great_dane.id}", "Great Dane") |> has_element?()
	  assert view |> element("#breed_row_#{bulldog.id}", "English Bulldog") |> has_element?()
	end

	test "adds a new breed", %{conn: conn} do
		# Pre-condition to avoid false positives
		assert [] = Breed |> Repo.all

		{:ok, view, _html} = get(conn, "/") |> live()

		#file_input and assert_render can be used to test uploads when time permits

		view |> element("form") |> render_submit(%{"breed" => %{"name" => "Irish Terrier"}})

	  assert view |> element("div", "Irish Terrier") |> has_element?()
	end

	defp create_breed(name, example_image) do
		%Breed{} |> cast(%{name: name, example_image: example_image}, [:name, :example_image]) |> Repo.insert!()
	end
end
