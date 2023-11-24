defmodule VetspireTakeHomeWeb.Resolvers.Breeds do
  def list_breeds(_parent, _args, _resolution) do
    {:ok, VetspireTakeHome.Breeds.list_breeds()}
  end

  def get_breed(_parent, %{id: id}, _resolution) do
    {:ok, VetspireTakeHome.Breeds.get_breed(id)}
  end
end
