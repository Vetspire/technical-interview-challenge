defmodule LinnaeusWeb.Api.V1.BreedsController do
  use LinnaeusWeb, :controller

  alias Ecto.Changeset

  @known_types ["dog"]

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
    %{breed: %{name: breed_name}, asset_url: Map.get(conn.assigns, :asset_url)}
    |> module(type, :Image).new()
    |> case do
      {:ok, _} ->
        conn
        |> put_status(:created)
        |> json(build_response_json(type))

      {:error, error} ->
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
