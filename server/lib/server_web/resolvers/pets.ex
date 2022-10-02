defmodule ServerWeb.Resolvers.Pets do
  @moduledoc """
  The Pets Resolver context
  """

  alias Server.Pets
  alias Server.S3
  alias Server.Image

  require Logger

  def list_dogs(_args, _resolution) do
    {:ok, Pets.list_dogs()}
  end

  def get_dog(args, _resolution) do
    {:ok, Pets.get_dog!(args.breed)}
  rescue
    e in Ecto.NoResultsError ->
      Logger.error("[[#{__MODULE__}]] error log message: #{e.message}")

      {:error, "dog not found"}
  end
end
