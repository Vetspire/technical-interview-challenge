defmodule VetspireInterviewWeb.DogViewTest do
  use VetspireInterviewWeb.ConnCase, async: true

  alias VetspireInterview.Dogs.Dog
  alias VetspireInterviewWeb.DogView

  test "humanize_breed/1 displays breed name" do
    assert DogView.humanize_breed("irish_terrier") == "Irish terrier"

    assert DogView.humanize_breed(%Dog{breed: "great_dane", image_path: "great_dane.jpg"}) ==
             "Great dane"
  end

  test "atomize_breed/1 prepares a breed name for the database" do
    assert DogView.atomize_breed("Irish Terrier") == "irish_terrier"

    assert DogView.atomize_breed(%Dog{breed: "new breed", image_path: "new_breed.jpg"}) ==
             "new_breed"
  end
end
