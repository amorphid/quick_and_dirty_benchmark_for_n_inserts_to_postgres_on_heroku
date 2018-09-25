# PgBm

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

Setup:

    $ heroku create --buildpack "https://github.com/HashNuke/heroku-buildpack-elixir.git"
    $ heroku buildpacks:add "https://github.com/gjaldon/heroku-buildpack-phoenix-static.git"
    $ heroku addons:create heroku-postgresql:standard-0
    $ heroku config:set POOL_SIZE=118 
    $ SECRET_KEY_BASE="$(mix phx.gen.secret)"
    $ heroku config:set SECRET_KEY_BASE="${SECRET_KEY_BASE}"
    $ heroku run "POOL_SIZE=2 mix.ecto migrate"
    $ heroku run "POOL_SIZE=2 iex -S mix"