defmodule PlateSlate.Accounts do
  @moduledoc """
  The Accounts context.
  """
  import Ecto.Query, warn: false
  alias PlateSlate.Repo
  alias Comeonin.Ecto.Password

  alias PlateSlate.Accounts.User

  def authenticate(role, email, password) do
    user = Repo.get_by(User, role: to_string(role), email: email)
    # digest es hashed password
    # valid? nos dice si coincide la primera con la segunda(hasheada)
    with %{password: digest} <- user,
         true <- Password.valid?(password, digest) do
      {:ok, user}
    else
      _ -> :error
    end
  end

  def lookup(role, id) do
    Repo.get_by(User, role: to_string(role), id: id)
  end
end
