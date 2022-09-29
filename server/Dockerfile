FROM elixir:1.13

# Enable shell history
ENV ERL_AFLAGS "-kernel shell_history enabled"

# Setup mix environment
ARG MIX_ENV="prod"
ENV MIX_ENV ${MIX_ENV}

# Install hex and rebar
RUN mix do local.hex --force, local.rebar --force

# Copy source to app directory
RUN mkdir /app
WORKDIR /app
COPY . /app

# Compile application
RUN mix do deps.get, phx.digest, compile
