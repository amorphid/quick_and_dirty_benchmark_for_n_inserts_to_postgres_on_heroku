# PgBm

A quick & dirty benchmark to insert N rows into the most basic Postgres database available on Heroku.

# Tested with:

- erlang 20.3.8.9
- elixir 1.6.6-otp-20
- python 2.7.15
- nodejs 8.12.0

# Setup:

    $ heroku create --buildpack "https://github.com/HashNuke/heroku-buildpack-elixir.git"
    $ heroku buildpacks:add "https://github.com/gjaldon/heroku-buildpack-phoenix-static.git"
    $ heroku addons:create heroku-postgresql:hobby-dev
    $ heroku config:set POOL_SIZE=18 
    $ SECRET_KEY_BASE="$(mix phx.gen.secret)"
    $ heroku config:set SECRET_KEY_BASE="${SECRET_KEY_BASE}"
    $ heroku run "POOL_SIZE=2 mix.ecto migrate"

# Benchmark:

    # start an IEX console
    $ heroku run "POOL_SIZE=2 iex -S mix"

    # create the query to insert N rows
    iex(1)> (
      qd_bm = fn num_rows -> 
        datetime = DateTime.utc_now()
        1..num_rows
        |> Enum.reduce([], fn _, acc -> 
          [[quantity: 123, price: 123, inserted_at: datetime, updated_at: datetime]|acc]
        end)
        |> case do
          rows -> 
            PgBm.Repo.transaction(fn -> PgBm.Repo.insert_all(PgBm.Buy, rows) end)
        end
      end
    )
    #Function<6.99386804/1 in :erl_eval.expr/5>

    # Insert 10K rows
    iex(8)> qd_bm.(10_000)
    00:13:12.959 [debug] QUERY OK db=1.2ms queue=0.1ms # time for transaction query
    begin []
    00:13:13.646 [debug] QUERY OK db=527.1ms           # time for 10K inserts