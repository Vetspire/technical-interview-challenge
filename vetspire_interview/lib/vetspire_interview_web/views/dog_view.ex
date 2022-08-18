defmodule VetspireInterviewWeb.DogView do
  use VetspireInterviewWeb, :view

  alias VetspireInterview.Dogs.Dog

  def humanize_breed(%Dog{breed: breed}), do: humanize_breed(breed)

  def humanize_breed(breed) when is_binary(breed),
    do:
      breed
      |> String.replace("_", " ")
      |> String.capitalize()

  def atomize_breed(%Dog{breed: breed}), do: atomize_breed(breed)

  def atomize_breed(breed) when is_binary(breed),
    do:
      breed
      |> String.replace(" ", "_")
      |> String.downcase()
end
