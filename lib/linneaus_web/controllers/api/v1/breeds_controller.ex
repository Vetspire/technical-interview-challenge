defmodule LinnaeusWeb.Api.V1.BreedsController do
  require Logger
  use LinnaeusWeb, :controller

  alias Ecto.Changeset

  @known_types ["dog"]

  plug LinnaeusWeb.Plug.FileUploader

  def index(conn, %{"type" => type}) when type in @known_types do
    json(conn, build_response_json(type))
  end

  def index(conn, %{"type" => _}) do
    not_found(conn)
  end

  def create(%Plug.Conn{} = conn, %{
        "type" => type,
        "breed_name" => breed_name
      })
      when type in @known_types do
    file_url = Map.get(conn.assigns, :asset_url)

    %{breed: %{name: breed_name}, asset_url: file_url}
    |> module(type, :Image).new()
    |> case do
      {:ok, _} ->
        conn
        |> put_status(:created)
        |> json(build_response_json(type))

      {:error, error} ->
        Logger.warning(error)

        Linnaeus.Uploader.delete(file_url)

        conn
        |> put_status(:bad_request)
        |> json(%{
          errors: Changeset.traverse_errors(error, &elem(&1, 0))
        })
    end
  end

  def create(conn, %{"type" => type}) when type in @known_types do
    conn
    |> put_status(:bad_request)
    |> json(%{})
  end

  def create(conn, %{"type" => _}) do
    not_found(conn)
  end

  # I decided to structure the response data as separate hashmaps instead of
  # nesting the Images inside of the Breed objects. Although it adds
  # a little more processing to the response, I feel it makes the frontend
  # architecture more flexible.

  # Currently this app simply sends down everything in the database, but if
  # we were working with a large amount of data, I would recommend adding
  # in some kind of pagination or filtering mechanism.
  defp build_response_json(type) do
    type
    |> module(:Breed)
    |> Linnaeus.Repo.all()
    |> Linnaeus.Repo.preload(:image)
    |> Enum.reduce(%{breeds: %{}, images: %{}}, &do_build_response_json/2)
  end

  defp do_build_response_json(breed, acc) do
    acc
    |> Map.update!(
      :breeds,
      &Map.put(&1, breed.id, Linnaeus.Breed.encode(breed))
    )
    |> Map.update!(
      :images,
      &Map.put(&1, breed.image.id, Linnaeus.Image.encode(breed.image))
    )
  end

  defp not_found(conn) do
    conn
    |> put_status(:not_found)
    |> json(%{})
  end

  defp module(type, breed_or_image)
       when type in @known_types and breed_or_image in [:Breed, :Image] do
    Module.concat([Linnaeus, String.capitalize(type), breed_or_image])
  end
end
