defmodule DogbookWeb.BreedsLive do
  use DogbookWeb, :live_view

  import Phoenix.Component

  alias Dogbook.LiveEntryPoints.Breeds.{ExampleUploader, Api}

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    new_breed_form =
      Api.prepare_index()
      |> Map.update(:breed_form, :changeset, &to_form(&1))

    socket =
      socket
      |> assign(new_breed_form)
      |> allow_upload(
        :example_image,
        max_entries: 1,
        accept: ~w(.jpg .jpeg .png),
        chunk_size: 5 * 1024 * 1024,
        writer: fn name, entry, socket ->
          {ExampleUploader, %{name: name, entry: entry, assigns: socket.assigns}}
        end
      )

    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <div class="flex gap-2 sm:gap-24">
      <div class="grow flex flex-col space-y-12">
        <div class="text-xl font-bold text-brand">Breeds</div>
        <div class="flex flex-col gap-4" id="breed_list">
          <div
            :for={breed <- @breeds}
            phx-click={show_larger_image(breed.id)}
            class="flex items-center gap-4 justify-between hover:cursor-pointer"
            id={"breed_row_#{breed.id}"}
          >
            <div class="w-3/5 overflow-hidden"><%= breed.name %></div>
            <img src={breed.url} class="sm:h-16 w-16 sm:w-auto" id={"breed_image_#{breed.id}"} />
            <div
              id={"large_image_closer_#{breed.id}"}
              phx-click={hide_larger_image(breed.id)}
              class="hidden fixed top-0 sm:top-[5dvh] right-4 sm:right-auto sm:left-12 z-20 text-brand font-bold text-5xl"
            >
              &times;
            </div>
          </div>
          <div
            id="modal_mask"
            class="hidden fixed top-0 left-0 bottom-0 right-0 z-0 bg-[rgba(0,0,0,0.7)]"
          />
        </div>
      </div>
      <.form
        for={@breed_form}
        phx-change="validate"
        phx-submit="save"
        id="new_breed_form"
        class="flex flex-col space-y-4 w-2/5 border-l pl-2 sm:pl-8 mt-20"
      >
        <div class="font-bold">Add a Breed</div>
        <label for={@breed_form[:name].name}>Name</label>
        <input type="text" name={@breed_form[:name].name} value={@breed_form[:name].value} />
        <.live_file_input upload={@uploads.example_image} />
        <div :for={entry <- @uploads.example_image.entries}>
          <progress value={entry.progress} max="100" :if={entry.progress > 0}><%= entry.progress %>%</progress>
          <div :for={err <- upload_errors(@uploads.example_image, entry)}>
            <div class="alert alert-danger"><%= friendly_error(err) %></div>
          </div>
        </div>
        <button type="submit" class="rounded-full border border-brand w-fit text-white bg-brand px-2 py-1" phx-disable-with="Saving...">Save</button>
      </.form>
    </div>
    """
  end

  @impl Phoenix.LiveView
  def handle_event("validate", params, socket) do
    breed_form =
      Api.update_changeset(socket.assigns.breed_form.source, params["breed"]) |> to_form()

    {:noreply, assign(socket, %{breed_form: breed_form})}
  end

  @impl Phoenix.LiveView
  def handle_event("save", params, socket) do
    new_breeds =
    consume_uploaded_entries(socket, :example_image, fn upload_params, _entry ->
        new_breed =
          Map.put(params["breed"], "example_image", upload_params.file_name)
          |> Api.create_breed()

        {:ok, new_breed}
      end) 
    |> case do
    [_] = breeds -> breeds
    _ -> [Api.create_breed(params["breed"])]
    end
    breed_form = Api.new_changeset() |> to_form()
    {:noreply, assign(socket, %{breeds:  socket.assigns.breeds ++ new_breeds, breed_form: breed_form})}
  end

  defp show_larger_image(js \\ %JS{}, id) do
    js
    |> JS.add_class("full-page-image", to: "#breed_image_#{id}")
    |> JS.show(to: "#large_image_closer_#{id}")
    |> JS.show(to: "#modal_mask")
  end

  defp hide_larger_image(js \\ %JS{}, id) do
    js
    |> JS.remove_class("full-page-image", to: "#breed_image_#{id}")
    |> JS.hide(to: "#large_image_closer_#{id}")
    |> JS.hide(to: "#modal_mask")
  end

  defp friendly_error(:too_large), do: "Image file too large"
  defp friendly_error(:too_many_files), do: "Too many files"
  defp friendly_error(:not_accepted), do: "We only accept .jpg, .jpeg, or .png files"
end
