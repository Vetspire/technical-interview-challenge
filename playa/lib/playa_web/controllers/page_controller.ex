defmodule PlayaWeb.PageController do
  use PlayaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
