defmodule PgBmWeb.PageController do
  use PgBmWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
