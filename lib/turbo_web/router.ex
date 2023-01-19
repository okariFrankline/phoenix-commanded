defmodule TurboWeb.Router do
  alias TurboWeb.TaskController
  use TurboWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TurboWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # scope "/", TurboWeb do
  #   pipe_through :browser

  #   get "/", PageController, :index
  # end

  scope "/tasks" do
    pipe_through :browser

    get "/", TaskController, :index
    get "/list", TaskController, :list
    get "/new", TaskController, :new
    get "/show/:uuid", TaskController, :show
    get "/update/:uuid", TaskController, :update_form

    post "/create", TaskController, :create
    post "/update/:uuid", TaskController, :update
  end

  scope "/stimulus", TurboWeb do
    pipe_through :browser

    get "/counter", StimulusController, :counter
  end

  # Other scopes may use custom stacks.
  # scope "/api", TurboWeb do
  #   pipe_through :api
  # end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
