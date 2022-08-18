defmodule VetspireInterviewWeb.Dogs.NewLive do
  @moduledoc """
  The LiveView form for submitted a new `VetspireInterview.Dogs.Dog` and uploading an
  image.
  """

  use VetspireInterviewWeb, :live_view

  alias VetspireInterview.Dogs
  alias VetspireInterview.Dogs.Dog
  alias VetspireInterviewWeb.DogView

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:changeset, Dogs.change_dog(%Dog{}))
     |> assign(:uploaded_files, [])
     |> allow_upload(:breed_image, accept: ~w(.jpg .jpeg), max_entries: 1)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <a href={Routes.live_path(@socket, VetspireInterviewWeb.Dogs.IndexLive)}>Back to list</a>

    <h1>New Dog</h1>

    <.form id="dog-form" class="dog-form" let={f} for={@changeset} phx-change="validate" phx-submit="save">
      <%= label f, :breed %>
      <%= text_input f, :breed %>
      <%= error_tag f, :breed %>

      <%= label f, :breed_image, "Breed Picture" %>
      <%= live_file_input @uploads.breed_image %>

      <%= for entry <- @uploads.breed_image.entries do %>
        <article class="upload-entry">

          <figure>
            <%= live_img_preview entry %>
            <figcaption><%= entry.client_name %></figcaption>
          </figure>

          <%= for err <- upload_errors(@uploads.breed_image, entry) do %>
            <p class="alert alert-danger"><%= error_to_string(err) %></p>
          <% end %>

        </article>
      <% end %>

      <%= submit "Save", disabled: !@changeset.valid? %>
    </.form>
    """
  end

  @impl Phoenix.LiveView
  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :breed_image, ref)}
  end

  @impl Phoenix.LiveView
  def handle_event("validate", %{"dog" => dog_params}, socket) do
    changeset =
      %Dog{}
      |> Dogs.change_dog(dog_params)
      |> Map.put(:action, :create)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl Phoenix.LiveView
  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  @impl Phoenix.LiveView
  def handle_event("save", %{"dog" => %{"breed" => breed}}, socket) do
    uploads =
      consume_uploaded_entries(socket, :breed_image, fn %{path: path}, _entry ->
        dest =
          Path.join([
            :code.priv_dir(:vetspire_interview),
            "static",
            "images/dogs",
            Path.basename(path)
          ])

        File.cp!(path, dest)
        {:ok, Path.basename(dest)}
      end)

    dog_params = %{
      breed: DogView.atomize_breed(breed),
      image_path: Enum.at(uploads, 0)
    }

    case Dogs.create_dog(dog_params) do
      {:ok, %{breed: breed}} ->
        {:noreply,
         socket
         |> put_flash(:info, "Dog #{DogView.humanize_breed(breed)} was created successfully!")
         |> push_redirect(to: Routes.live_path(socket, VetspireInterviewWeb.Dogs.IndexLive))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp error_to_string(:too_large), do: "Too large"
  defp error_to_string(:not_accepted), do: "You have selected an unacceptable file type"
end
