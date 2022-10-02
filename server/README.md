## Getting Started

1. [Install Brew](https://brew.sh/)
2. Before `asdf install` follow the instruction in [asdf-erlang README.md](https://github.com/asdf-vm/asdf-erlang#osx) for your OS. If using the Apple M1 Chip here's [a good guide](https://devheroes.io/en/erlang-elixir-macos-m1/) on installing Erlang and Elixir.
3. Set environment variables for asdf when installing erlang `export KERL_CONFIGURE_OPTIONS="--without-javac --without-wx --without-odbc --with-ssl=$(brew --prefix openssl@1.1)"`
4. Install asdf `asdf install`
5. Install dependencies `mix deps.get`
6. Start Postgres in Docker Desktop `docker run --name postgres -p 5432:5432 -e POSTGRES_PASSWORD=postgres -e POSTGRES_USER=postgres -d postgres`
7. Setup database `mix ecto.setup`
8. Start server `mix phx.server`
