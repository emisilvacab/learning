defmodule RumblWeb.Router do
  use RumblWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {RumblWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug RumblWeb.Auth#Agregamos el module plug de autenticación
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RumblWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/users", UserController, only: [:index, :show, :new, :create]
    # resources es para CRUD operations ~
    # get "/users", UserController, :index
    # get "/users/:id/edit", UserController, :edit
    # get "/users/new", UserController, :new
    # get "/users/:id", UserController, :show
    # post "/users", UserController, :create
    # patch "/users/:id", UserController, :update
    # put "/users/:id", UserController, :update
    # delete "/users/:id", UserController, :delete
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    #tres prepackaged REST routes
    #get "/sessions/new" para mostrar new session login form
    #post "/sessions" para log in
    #delete "/sessions/:id" para log out
  end

  scope "/manage", RumblWeb do
    pipe_through [:browser, :authenticate_user]
    #Soporta lista tambien, como pipelines son tambien plugs podemos usar authenticate_user directamente aca

    resources "/videos", VideoController
    #Espectro completo de REST actions
    #get "/videos" para listar videos
    #get "/videos/:id" para ver video identificado por :id
    #get "/videos/new" para mostrar interfaz para crear nuevo video
    #post "/videos/new" para enviar formulario con nuevo video
    #put y patch "/videos/:id/edit" para editar video
    #delete "/videos/:id" para eliminar video identificado por :id
  end

  # Other scopes may use custom stacks.
  # scope "/api", RumblWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: RumblWeb.Telemetry
    end
  end

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
