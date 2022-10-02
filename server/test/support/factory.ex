defmodule Server.Factory do
  use ExMachina.Ecto, repo: Server.Repo
  use Server.DogFactory
end
