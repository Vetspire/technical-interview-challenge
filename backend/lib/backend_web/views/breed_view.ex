defmodule BackendWeb.BreedView do
  use BackendWeb, :view
  alias BackendWeb.BreedView

  def render("index.json", %{breeds: breeds, conn: conn}) do
    %{data: render_many(breeds, BreedView, "breed.json", %{conn: conn})}
  end

  def render("show.json", %{breed: breed, conn: conn}) do
    %{data: render_one(breed, BreedView, "breed.json", %{conn: conn})}
  end

  def render("breed.json", %{breed: breed, conn: conn}) do
    %{
      id: breed.id,
      name: breed.name,
      image: Routes.static_path(conn, breed.image.filename),
      description: breed.description
    }
  end
end
