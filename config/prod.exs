use Mix.Config

config :pg_bm, PgBmWeb.Endpoint, 
  load_from_system_env: true,
  url: [scheme: "https", host: "mysterious-meadow-6277.herokuapp.com", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: Map.fetch!(System.get_env(), "SECRET_KEY_BASE")

config :logger, level: :debug

config :pg_bm, PgBm.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true

  fn num,num2 -> datetime = DateTime.utc_now() ; qd_bm = fn i -> 1..i |> Enum.reduce([], fn _, acc -> [[quantity: 123, price: 123, inserted_at: datetime, updated_at: datetime]|acc] end) end ; :timer.tc(fn -> Enum.map(1..num, fn _ -> Task.async(fn -> PgBm.Repo.transaction(fn -> PgBm.Repo.insert_all(PgBm.Buy, qd_bm.(num2)) end) end) end) |> Enum.map(fn i -> Task.await(i, 60_000) end) end) |> elem(0) |> case do microsec -> IO.puts("#{(num2 * num) / (microsec / 1_000_000) |> trunc()} inserts per second") end end.(1000,100)


  Enum.map(1..2, fn _ -> Task.async(fn -> Postgrex.query!(pid, "INSERT INTO buys (price, quantity, inserted_at, updated_at) VALUES (123, 123, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)", []) end) end)

  