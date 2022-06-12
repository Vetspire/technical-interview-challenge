defmodule BackendWeb.BreedController do
  use BackendWeb, :controller

  alias Backend.Dogs
  alias Backend.Uploader

  action_fallback BackendWeb.FallbackController

  def index(conn, _params) do
    breeds = Dogs.list_breeds()
    render(conn, "index.json", breeds: breeds)
  end

  @doc """
  Handle raw HTML Multi-part form uploads
  """
  def create(conn, %{
        "breedName" => name,
        "breedDescription" => description,
        "breedImage" => image
      }) do
    with {:ok, uploaded_image} <- Uploader.upload(image),
         {:ok, breed} <-
           Dogs.create_breed(%{name: name, description: description, image: uploaded_image}) do
      conn
      # |> put_status(:created)
      # |> put_resp_header("location", Routes.breed_path(conn, :show, breed))
      # |> render("show.json", breed: breed)
      |> redirect(to: "/breeds/#{breed.id}")
    end
  end

  def show(conn, %{"id" => id}) do
    breed = Dogs.get_breed!(id)
    render(conn, "show.json", breed: breed)
  end
end
