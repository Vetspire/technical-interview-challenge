defmodule PlayaWeb.DogView do
  use PlayaWeb, :view

  alias Playa.Dogs.Dog
  alias Playa.S3.Config

  def image_path(%Dog{image_path: image_path}) do
    "#{Config.base_url()}/#{image_path}"
  end
end
