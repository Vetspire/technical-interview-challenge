defmodule BackendWeb.BreedController do
  use BackendWeb, :controller

  alias Backend.Dogs
  alias BackendWeb.Uploader

  action_fallback BackendWeb.FallbackController

  if Application.compile_env!(:backend, :environment) == :prod do
    plug :basic_env_auth when action in [:create]

    defp basic_env_auth(conn, _opts) do
      # Default provided here, runtime.exs will raise if ENV not provided in prod
      username = System.fetch_env!("UPLOAD_USERNAME")
      password = System.fetch_env!("UPLOAD_PASSWORD")

      Plug.BasicAuth.basic_auth(conn, username: username, password: password)
    end
  end

  def index(conn, _params) do
    breeds = Dogs.list_breeds()
    render(conn, "index.json", breeds: breeds)
  end

  @doc """
  Handle raw HTML Multi-part form uploads

  Returns an error if a required key is missing.
  """
  def create(conn, %{
        "breedName" => name,
        "breedDescription" => description,
        "breedImage" => image
      }) do
    with {:ok, uploaded_image} <- Uploader.upload_file(image),
         {:ok, breed} <-
           Dogs.create_breed(%{name: name, description: description, image: uploaded_image}) do
      conn
      # |> put_status(:created)
      # |> put_resp_header("location", Routes.breed_path(conn, :show, breed))
      # |> render("show.json", breed: breed)
      |> redirect(to: "/breeds/#{breed.id}")
    end
  end

  # Ideally this error handling would be more generic and use changesets
  # but this handles the non-React version of the form upload and avoids
  # crashing while providing a useful error message.
  def create(conn, params) do
    param_keys = params |> Map.keys() |> MapSet.new()
    required_keys = MapSet.new(~w(breedName breedDescription breedImage))

    missing_keys = MapSet.difference(required_keys, param_keys) |> MapSet.to_list()

    conn
    |> put_status(422)
    |> json(%{errors: "Missing required params: #{missing_keys}", missing_params: missing_keys})
  end

  def show(conn, %{"id" => id}) do
    breed = Dogs.get_breed!(id)
    render(conn, "show.json", breed: breed)
  end
end
