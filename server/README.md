## Getting Started

You would need to create a [free AWS account](https://aws.amazon.com/free).

After you would want to [add a new IAM user](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html#id_users_create_console) using the S3 console. When creating the user select `Access key - Programmatic access` this will allow use to access AWS API using `the access key ID` and `secret access key`. When setting the permissions select `Attach existing policies directly` and search and select `AmazonS3FullAccess` policy name. This will give our user full access to Amazon S3. That's all you have to do to create the user and are given the `the access key ID` and `secret access key`.

Create a `.env` file and copy the content in `.env.example`. Now enter `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` values.

After you would want to create a [S3 bucket](https://docs.aws.amazon.com/AmazonS3/latest/userguide/create-bucket-overview.html) recommend using the S3 console. When creating the new bucket to store the images make sure `ACLs enabled` and `Block all public access` is disabled.

Now enter `AWS_REGION` and `AWS_BUCKET` values into `.env`.

1. [Install Brew](https://brew.sh/)
2. Before `asdf install` follow the instruction in [asdf-erlang README.md](https://github.com/asdf-vm/asdf-erlang#osx) for your OS. If using the Apple M1 Chip here's [a good guide](https://devheroes.io/en/erlang-elixir-macos-m1/) on installing Erlang and Elixir.
3. Set environment variables for asdf when installing erlang `export KERL_CONFIGURE_OPTIONS="--without-javac --without-wx --without-odbc --with-ssl=$(brew --prefix openssl@1.1)"`
4. Install asdf `asdf install`
5. Install dependencies `mix deps.get`
6. Start Postgres in Docker Desktop `docker run --name postgres -p 5432:5432 -e POSTGRES_PASSWORD=postgres -e POSTGRES_USER=postgres -d postgres`
7. Setup database `mix ecto.setup`
8. Source environment variables `source .env`
9. Upload `priv/repo/images` to s3 `mix upload_images`
10. Start server `mix phx.server`
