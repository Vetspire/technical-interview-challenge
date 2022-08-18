defmodule VetspireInterview.Factory do
  use ExMachina.Ecto, repo: VetspireInterview.Repo

  def dog_factory do
    %VetspireInterview.Dogs.Dog{
      breed: "chihuahua",
      image_path: "chihuahua.jpg"
    }
  end
end
