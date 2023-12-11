defmodule Dogbook.Schema.Breed do
  use Ecto.Schema

  schema "breeds" do
    field :name, :string
    field :example_image, :string
  end
end
