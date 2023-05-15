defmodule RumblWeb.UserController do
  use RumblWeb, :controller
# use RumblWeb.Auth, :authenticate

  alias Rumbl.Accounts
  alias Rumbl.Accounts.User

  plug :authenticate_user when action in [:index, :show]

  def index(conn, _params) do
    #case authenticate(conn) do
    #  %Plug.Conn{halted: true} = conn ->
    #    conn
    #  conn ->
    users = Accounts.list_users()#le pido a Accounts que me de lista de usuarios
    render(conn, "index.html", users: users)
    #end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user(id)
    render(conn, "show.html", user: user)
  end

  def new(conn, _params) do
    changeset = Accounts.change_registration(%User{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do

      {:ok, user} ->
        conn
        |> RumblWeb.Auth.login(user)#Te loggea automáticamente cuando te creas el usuario
        |> put_flash(:info, "#{user.name} created!")
        |> redirect(to: Routes.user_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)

      end
  end
#Se movio a RumblWeb.Auth y se cambio por def authenticate_user para hacerla public y usarla entre
#routers y controllers
  # defp authenticate(conn, _opts) do
  #   if conn.assigns.current_user do
  #     conn
  #   else
  #     conn
  #     |> put_flash(:error, "You must be logged in to access that page")
  #     |> redirect(to: Routes.page_path(conn, :index))
  #     |> halt()
  #   end
  # end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end
end
