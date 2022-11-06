# VgTrack

To start our Application:

## Instalação

```http
$ git clone url
$ cd fusion
$ cp config/dev.exs.example config/dev.exs
$ cp config/test.exs.example config/test.exs
$ mix deps.get
$ mix ecto.create
$ mix ecto.migrate
$ MIX_ENV=test mix ecto.create
$ MIX_ENV=test mix ecto.migrate
```

  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
# vg_track
