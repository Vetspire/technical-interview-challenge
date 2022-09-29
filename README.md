# Vetspire Take-home

## Motivation and general thoughts

I built the solution to this task with Elixir on the backend and Javascript on the frontend. I used Phoenix with Absinthe to create a GraphQL API that serves the breed data from a Postgres database to the React client. In my opinion, this is immensely overkill for the simplicity of this project. However, given that Vetspire makes use of all of these technologies, I wanted to demonstrate my knowledge of them here.

If I were to build the solution to this task in a real-world scenario, I would likely have gone with something much simpler. I might have done a basic Phoenix application that serves html pages containing the the breed names and images. In fact, given that the uploading feature is optional, one could argue that a satisfactory solution might be to use a simple webserver like nginx to serve the given `images` directory.

Since I opted for using all of these extra technologies, I admittedly ended up taking around four or five hours to complete this, despite the recommendation of just two. Here are some things I would like to have done but didn't because I've already used so much time:
* Tests. I am big proponent of testing. In many cases I even like to practice test-driven development.
* Prettier frontend. I find CSS to be quite the time sink, but it would have been nice to do a bit more formatting/touching up.
* Better documentation in the Elixir code. I'd like to have included some function and module docs, as I typically would in a real-world scenario.
* Separating the frontend React components into their own files.
* Better error-handling and input validation. Users should recieve feedback indicating why their actions have failed, in the case that they do.

## Design

The design of the app is quite simple. The GraphQL API contains two root queries: `breeds` and `breed`. These are for listing all breeds and detailing a single breed respectively. They both serve the `breed` type, which contains the `name` and `imageUrl` of the breed. This type is resolved with a `Breed` struct, which resembles a row from the `breeds` table in the database. This table has a sequential `id` primary key, a `name` column, and an `image` column. This is useful because if a client decided they want to show the image of each breed in the list view instead of just the individual breed view, they could do so without having to change the backend code (behold, the power of GraphQL).

The API also contains a mutation, `addBreed`. This is what's used for adding a new breed and uploading an associated image. This works by base 32 encoding the name of the breed and using that for the filename of the image. The image is saved to `priv/static/images` so that it's accessible to clients. Encoding the breed name as the filename ensures that I don't need to be concerned about any special user-inputted characters that might not play well with the filesystem. The breed name and filename are inserted as a new record in the `breeds` table.

I must admit the frontend did not get much design attention from me. I opted to go for a straight-forward react app (create-react-app to the rescue). Using the Apollo GraphQL client I connected to the backend to query for the breeds. A basic list component that uses the `breeds` query and a breed view component that uses the `breed` query. For uploading, I added a simple form that uses the `addBreed` mutation.

## Running the solution

### Docker (recommended)

You can run whole project using [docker-compose](https://docs.docker.com/compose/). Simply:
```sh
docker-compose up
```
Then you can access:
* Client: http://localhost:3000
* Server: http://localhost:4000
* GraphQL playground: http://locahost:4000/graphiql

### Bare-metal

I recommend using elixir v1.13 and nodejs v16. You can start the server like this:
```sh
mix do phx.digest, compile
mix ecto.create
mix ecto.migrate
mix run priv/repo/seeds.exs # This adds the intital breeds
mix phx.server
```
It will be running locally on port 4000. GraphQL playground available at `/graphiql`.

The client can be started like so:
```sh
npm install
npm start
```
It will be running locally on port 3000.
