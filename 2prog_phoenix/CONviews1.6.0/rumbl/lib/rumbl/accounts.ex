defmodule Rumbl.Accounts do
  @moduledoc """
  The Accounts context.
  """
  alias Rumbl.Repo
  alias Rumbl.Accounts.User
  #Without db
  # def list_users do
  #   [
  #     %User{id: "1", name: "José", username: "josevalim"},
  #     %User{id: "2", name: "Bruce", username: "redrapids"},
  #     %User{id: "3", name: "Chris", username: "chrismccord"}
  #   ]
  # end

  # def get_user(id) do
  #   Enum.find(list_users(), fn map -> map.id == id end)
  # end

  # def get_user_by(params) do
  #   Enum.find(list_users(), fn map ->
  #     Enum.all?(params, fn {key, val} -> Map.get(map, key) == val end)
  #   end)
  # end

  def get_user(id) do
    Repo.get(User, id)
  end

#Raises Ecto.NotFoundError when looking up user that not exists
  def get_user!(id) do
    Repo.get!(User, id)
  end

  def get_user_by(params) do
    Repo.get_by(User, params)
  end

  def list_users do
    Repo.all(User)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def change_registration(%User{} = user, params) do
    User.registration_changeset(user, params)
  end

  def register_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def authenticate_by_username_and_pass(username, given_pass) do
    user = get_user_by(username: username)

    cond do

      user && Pbkdf2.verify_pass(given_pass, user.password_hash) ->
        {:ok, user}

      user ->
        {:error, :unauthorized}#Found user but bad password

      true ->
        Pbkdf2.no_user_verify()#Simula password check with variable timing, para mejorar capa de autenticación contra timming attacks
        {:error, :not_found}#User not found (user == nil)
    end
  end
end
