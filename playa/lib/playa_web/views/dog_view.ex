defmodule PlayaWeb.DogView do
  use PlayaWeb, :view

  alias Playa.Dogs.Dog

  def image_path(%Dog{image_path: image_path}) do
    "#{base_url()}/#{image_path}"
  end

  def base_url do
    Application.fetch_env!(:ex_aws, :base_url)
  end
end
