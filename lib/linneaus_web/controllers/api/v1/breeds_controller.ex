defmodule LinnaeusWeb.Api.V1.BreedsController do
  use LinnaeusWeb, :controller

  @breeds [:code.priv_dir(:linnaeus), "static", "images", "dogs"]
          |> Path.join()
          |> File.ls!()
          |> Enum.with_index()
          |> Enum.map(fn {file, idx} ->
            name =
              String.split(file, ".")
              |> Enum.at(0)
              |> String.split("_")
              |> Enum.map_join(" ", &String.capitalize/1)

            %{
              name: name,
              id: idx + 1,
              image_path: Path.join(["/", "images", "dogs", file])
            }
          end)

  def index(conn, %{}) do
    json(conn, @breeds)
  end
end
