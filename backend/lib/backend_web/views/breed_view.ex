defmodule BackendWeb.BreedView do
  use BackendWeb, :view
  alias BackendWeb.BreedView

  alias BackendWeb.Uploader

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
      image: Uploader.get_file_url(breed.image),
      description: breed.description
    }
  end
end
