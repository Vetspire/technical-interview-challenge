## Vetspire Take-home (max 2 hours)

Fork this repo. Build a simple full stack app using frameworks of your choice. Submit your results as a pull request
to this repo with instruction on how to build/run it or, even better, a link to where we can see it already
running/deployed. Alternatively, feel free to send us an archive file of the work.

There is probably more here than can be finished in two hours. Don't worry about completeness. Focus on what's
important and interesting to you.

We use `Elixir`, `Ecto`, `Absinthe`, `GraphQL`, `Typescript/Javascript` and `React` at Vetspire but you are welcome to use
whatever languages and frameworks you prefer.

We encourage you to include a README with notes about your language and framework choices as well as your design
decisions.

### Features

- Backend API that serves:
  - A list of available dog breeds based on those available in `/images`
  - Individual dog images by breed
- Frontend UI that provides:
  - A list of dog breeds
  - The ability to choose a breed and display the image for it
- Bonus Feature:
  - Ability to add a new breed with a new image

### Technology Stack

- Backend:
  - [The Elixir programming language](https://elixir-lang.org/)
  - [Phoenix Framework](https://www.phoenixframework.org/)
  - [GraphQL](https://graphql.org/)
  - [Amazon S3](https://aws.amazon.com/s3/)
- Frontend:
  - [Next.js](https://nextjs.org/)
  - [Tailwind CSS](https://tailwindcss.com/)

### Reasoning For Techology Stack

The problem we are trying to solve is to create a full stack application that will display a list of dog breeds and the ability to add to the list. We have to save images and can save them in a database or use a cloud storage provider. I decided to use a cloud storage provider because it's more common. Going with Amazon S3 as it's a popular storage used today.

For the backend you can use any language for this case. When picking the backend language and framework it's good to keep in mind the problem you are solving. For example, if you are building an AI and ML solution, it's best to use Python. For me I enjoy writing in Elixir and it is my choice for the backend. Will be using GraphQL as it is easier to extend compared to REST endpoints along with other benefits.

For the Frontend it will be in React the most popular UI library used today. When picking the React framework I decided to go with Next.js for its support for Client Side Rendering CSR, Server Side Rendering SSR, and Static Site Generation SSG. For this application we can use SSG to generate all the dog detail pages at build time and SSR to generate the list of dog pages as the user can create new dogs. For the css styling going with Tailwind for it's easy to use utility classes and it's great optimization for production.

### Getting started

Please install [asdf](https://asdf-vm.com/guide/getting-started.html) as our programming language versions manager tool and [Docker Desktop](https://www.docker.com/products/docker-desktop/) for running our Postgres resource.
