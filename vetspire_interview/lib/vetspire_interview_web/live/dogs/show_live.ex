defmodule VetspireInterviewWeb.Dogs.ShowLive do
  @moduledoc """
  The LiveView page for displaying a `VetspireInterview.Dogs.Dog` by the passed
  `id` as well as their associated image.
  """

  use VetspireInterviewWeb, :live_view

  alias VetspireInterview.Dogs
  alias VetspireInterviewWeb.DogView

  @impl true
  def mount(%{"breed" => breed}, _session, socket) do
    {:ok, assign(socket, dog: Dogs.get_dog_by_breed!(breed))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <a href={Routes.live_path(@socket, VetspireInterviewWeb.Dogs.IndexLive)}>Back to list</a>

    <h1><%= DogView.humanize_breed(@dog.breed) %></h1>

    <%= if @dog.image_path do %>
      <img src={Routes.static_path(@socket, "/images/dogs/#{@dog.image_path}")} />
    <% else %>
      <h3>No image found.</h3>
    <% end %>
    """
  end
end
