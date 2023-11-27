defmodule VetspireTakeHomeWeb.PageController do
  use VetspireTakeHomeWeb, :controller

  def home(conn, _params) do
    render(conn, :home, layout: false)
  end
end
