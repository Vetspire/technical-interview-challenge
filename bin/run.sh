#!/bin/sh

set -ex

if [ "$RESET_DATABASE" = "true" ]
then
  mix ecto.drop -f
  mix ecto.create
  mix ecto.migrate
  mix run priv/repo/seeds.exs
else
  mix ecto.create
  mix ecto.migrate
fi

mix phx.server
