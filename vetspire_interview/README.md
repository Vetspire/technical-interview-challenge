# Cody Rogers - Technical Interview

Hello! For this exercise, I decided to make a simple full-stack application in Phoenix
utilizing LiveView for the front-end component.

For the data model, I created a `VetspireInterview.Dogs.Dog` schema which contains string fields for the `breed` and
an `image_path`. The `breed` is required and unique, and is stored in snake_case in the database.
The `image_path` is nullable to allow for more flexibility when creating entries if desired. Entries
are saved with a generated UUID `id` primary key to ensure uniqueness, and also contain inserted and updated
timestamps.

The context module `VetspireInterview.Dogs` performs simple operations on the `Dog` struct such as
listing all dogs in the database, retrieving dogs by id or by breed, creating a new dog from passed params,
and returning a `Dog` changeset.

For the front-end, there are 3 pages at `VetspireInterviewWeb.Dogs` that are configured in the router:

- IndexLive: Lists dogs by breed, displayed as links which can be clicked to visit their show page.
- ShowLive: Shows the dog breed and it's picture with a link to return to the index.
- NewLive: A form for creating a new dog by specifying breed and uploading an optional image.

For the sake of simplicity for this exercise, images are saved to and read from `priv/static/images/dogs`.
Dog `image_path` fields are saved as the filename contained within this path. For a more "production-ready" solution or one
that involved a separate frontend that uploads images, I'd probably store the images on S3 instead of handling it locally.

Starting the server should be as simple as:

- `cd vetspire_interview`
- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
