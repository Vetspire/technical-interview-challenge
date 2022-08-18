defmodule VetspireInterviewWeb.Dogs.IndexLive do
  @moduledoc """
  The LiveView page for displaying the list of `VetspireInterview.Dogs.Dog`s by their
  `breed` as a collection of links which when clicked will lead to the `Dog`'s Show page.
  """

  use VetspireInterviewWeb, :live_view

  alias VetspireInterview.Dogs
  alias VetspireInterviewWeb.DogView

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, dogs: Dogs.list_dogs())}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <h1>Dogs by breed</h1>

    <ul>
      <%= for dog <- @dogs do %>
        <li>
          <a href={Routes.live_path(@socket, VetspireInterviewWeb.Dogs.ShowLive, dog.breed)}><%= DogView.humanize_breed(dog.breed) %></a>
        </li>
      <% end %>
    </ul>
    """
  end
end
