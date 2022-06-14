### Features
- [x] Backend API that serves:
    - A list of available dog breeds based on those available in `/images`
    - Individual dog images by breed
- [x] Frontend UI that provides:
    - A list of dog breeds
    - The ability to choose a breed and display the image for it
- [x] Bonus Feature:
  - Ability to add a new breed with a new image


# Dogonomicon
[Dogonomicon - Live Version](https://dogonomicon.fly.dev)
## Development Guide
Runs as a standard Phoenix app.

System Requirements:
  - Elixir/Erlang Installed (I'm on 1.13, but 1.10+ would probably work, possibly older)
  - Node/Npm/Yarn to fetch dependencies

Running steps:
  - `cd backend`
  - `mix setup`
  - `cd assets` then `yarn` or `npm install`, then `cd ../`
  - `iex -S mix phx.server`
  - The default breeds can be loaded from IEx
    - `iex(1)>Backend.BreedLoader.load_defaults()`
## Testing
Backend tests:
  - `mix test` from the backend directory
Frontend tests:
  - `yarn` or `npm install` from the root directory
  - `yarn test` from the root directory

## Production Guide
The app is deployed using Cloudflare R2 and Cloudflare Workers for static assets, and Fly.io for the app server. A full rundown is a bit out of scope but it basically follows standard deployment instructions for those services. Additionally there's a few places in the config files with values hardcoded for my production environment where I didn't fully parameterize things.
  - https://fly.io/docs/getting-started/elixir/
  - https://developers.cloudflare.com/r2/get-started/
  - Some modifications for Fly to support SQLite: https://gist.github.com/mcrumm/98059439c673be7e0484589162a54a01

Primarily your production environment needs to supply the following environment variables:


### Secrets
Variable | Description |
---------|----------|
 R2_ACCOUNT_ID | Cloudflare Account Id |
 R2_ACCESS_KEY_ID | Cloudflare R2 Access Key Id |
 R2_SECRET_ACCESS_KEY | Cloudflare R2 Secret Access Key |
 R2_QUERY_SECRET | Some random string. Must match secret set in Cloudflare Worker |
 UPLOAD_PASSWORD | Password to protect adding breed using basic auth

### Non-secret
Variable | Description |
---------|-------------|
R2_BUCKET_NAME | Name of bucket specificed in `wrangler.toml`
UPLOAD_USERNAME | Username to protect adding breed using basic auth
DATABASE_PATH | Path to where the SQLite database file should be stored

I deployed using Fly.io so `fly deploy --remote-only` handles running all of the build and release steps.


# Design
I had two initial goals in addition to the basic feature requirements:
  - Host images using a CDN for performance
  - Host the app in two regions on Fly.io's free tier

With those goals in mind I focused on feature development at the cost of unit testing and additional error handling logic. In a real app I would slow down and build out tests alongside each feature. Definitely went with a bit more of a prototyping mindset than methodical feature development.

I did get a bit carried away and spent more than 2 hours chasing those goals.

In the end I accomplished the first goal. The second one still needs a bit more work to add clustering and to properly handle database writes from multiple regions. Postgres would have somewhat simplified this step.

## Features

### BreedDetail
Nothing notable. Fetches info already available on BreedList. A more complex schema could benefit from GraphQL.

Basic unit testing verifies that data returned by fetching the endpoint makes it to the component, and two likely error scenarios are handled. Could refactor pure function component from data fetching component.

### BreedList
Lists breeds. Has a basic unit test to verify that it calls the BreedList endpoint and displays the returned data.

Further Development:
  - Should support paging
  - Needs some style work to handle images of different sizes
### Add a breed
This is the biggest shortcut I took on the frontend. Handling file inputs in React requires creating a ref and doing some extra work with the File API in Javascript. Instead I just let it submit as a standard HTML form using multipart form upload, letting the browser and Phoenix handle the complexity for me. Upgrading this to a real React implementation would be a top priority for continued development.

On the backend this is protected by Basic Auth

Further Development:
  - Handle file upload using Javascript

### Handle File Upload
The Uploader logic on the backend is my favorite part of the app. It designed to handle local and R2 uploads. Local upload support was important to me so that the app would be easy to run in development. Further work could be spent here adding additional guards and error handling or retry logic.

I modeled the `FileUpload` as an embedded_schema, this has turned out to be less than ideal. There's no easy way to handle dangling files in the bucket or uploads directory. This would be better handled as a table with ForeignKey relationships. Additionally, Ecto transactions could be used to clean up the file after failed inserts.

Further Development:
  - Switch FileUpload to a table-backed schema
  - Add Ecto transactions
  - Additional guards on files being uploaded
  - Additional error handling and retry logic
  - Handle JSON uploads instead/in addition to multi-part forms
  - Add unit tests

### BreadCrumbs
This feature on the frontend is very tightly coupled to the current feature set. While it works reliably it would not be easily extended to accomadate more features. Would benefit greatly from adding Redux or spending some time building out a context. There are also some NPM libraries to help with this.

Further Development:
  - Build an actual generic implementation

## Tech Choices
### Elixir/Phoenix
I used Elixir+Phoenix for the backend as that's my stack of choice, as well as the one used at Vetspire. I opted to use REST over GraphQL as it's what I'm more familiar with and because this simple project wouldn't benefit much the additional features of GraphQL.

Benefits:
  - Functional/Immutable data makes code easier to reason about
  - Fast with good concurrency support

Further development:
  - More testing

### Typescript/React
It's been a few years since I've done much frontend work and most of my previous experience is in Vue. Most of my previous React experience has been building features and making changes inside established apps, so I was excited to take the opportunity to build with React from the ground up. I'm a big fan of React Hooks and Typescript so React was a natural choice here. With that being said, I'm still a bit rusty on both React and Typescript so it's possible I violated a number of best practices.

I limited my dependencies as much as possible. For a larger app a state management library (like Redux) would likely be useful.

Getting Jest to play nicely with ESbuild was a bit rough. I ended up configuring Jest at the root directory which still runs tests in the backend directory just fine. I haven't fixed all the warnings in the tests yet but they do work. Could still use more coverage.

Benefits:
  - Well supported
  - Good typescript support
  - Hooks are fun

Further development:
  - More robust error handling
  - Split out pure functional components from data fetching components
  - More unit tests
  - State management

### Tailwind CSS
This is really my first foray into Tailwind. It made it easy to quickly build a decent and functional UI with good UX. I leaned pretty heavily on some Tailwind examples for styling here.

Further development:
  - Some style issues still need to be worked on, e.g. images getting squished on the BreedList page
### SQLite
I chose SQLite as my database to simplify deployment and minimize extra services needed to run in development and production. It ended up adding a bit of complexity to the production deployment, but overall was worthwhile. SQLite performance is more than sufficient for this application.

In a real app I would generally use Postgres.

Benefits:
  - Fast enough
  - No service dependency for dev or prod

### Cloudflare R2
I wanted to explore using a CDN or S3 like service to store the static images. Cloudflare R2 has a cheaper storage price than S3 and doesn't charge outbound egress. This app should easily stay in R2s free tier.

Benefits:
  - CDN distribution and caching for better performance
  - Avoid outbound bandwidth costs on app server with Fly.io (not really a problem in this app)
  - Avoid disk space and filesystem issues on app server

Further development:
  - Upgrade worker to use HMACs for verification instead of a static PSK
  - Add tests