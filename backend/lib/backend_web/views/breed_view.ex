defmodule BackendWeb.BreedView do
  use BackendWeb, :view
  alias BackendWeb.BreedView

  def render("index.json", %{breeds: breeds}) do
    %{data: render_many(breeds, BreedView, "breed.json")}
  end

  def render("show.json", %{breed: breed}) do
    %{data: render_one(breed, BreedView, "breed.json")}
  end

  def render("breed.json", %{breed: breed}) do
    %{
      id: breed.id,
      name: breed.name,
      image: breed.image,
      description: breed.description
    }
  end
end
