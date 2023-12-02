defmodule LinnaeusWeb.Api.V1.BreedsController do
  use LinnaeusWeb, :controller

  @known_types ["dog"]

  def index(conn, %{"type" => type}) when type in @known_types do
    json(conn, separate_assocs(type))
  end

  def index(conn, %{}) do
    conn
    |> put_status(:not_found)
    |> json(%{})
  end

  @spec separate_assocs(String.t()) :: Linnaeus.Breed.assoc_map()
  def separate_assocs(type) do
    [Linnaeus, String.capitalize(type), :Breed]
    |> Module.concat()
    |> Linnaeus.Model.all(preload: :image)
    |> Enum.reduce(%{breeds: %{}, images: %{}}, &Linnaeus.Breed.separate_assocs/2)
  end
end
