defmodule LinnaeusWeb.Api.V1.BreedsController do
  use LinnaeusWeb, :controller

  @known_types ["dog"]

  def index(conn, %{"type" => type}) when type in @known_types do
    json(conn, %{
      breeds: all(type, :Breed),
      images: all(type, :Image)
    })
  end

  def index(conn, %{}) do
    conn
    |> put_status(:not_found)
    |> json(%{})
  end

  @spec all(String.t(), :Breed | :Image) :: list(Linnaeus.Dog.Breed)
  def all(type, breed_or_image) do
    [Linnaeus, String.capitalize(type), breed_or_image]
    |> Module.concat()
    |> Linnaeus.Repo.all()
    |> Enum.into(%{}, &{&1.id, &1})
  end
end
