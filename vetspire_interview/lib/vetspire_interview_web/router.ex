defmodule VetspireInterviewWeb.Router do
  use VetspireInterviewWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_live_flash)
    plug(:put_root_layout, {VetspireInterviewWeb.LayoutView, :root})
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", VetspireInterviewWeb do
    pipe_through(:browser)

    scope "/", Dogs do
      live("/", IndexLive)
      live("/new", NewLive)
      live("/:breed", ShowLive)
    end
  end
end
