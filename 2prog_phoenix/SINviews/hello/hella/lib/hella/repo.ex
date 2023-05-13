defmodule Hella.Repo do
  use Ecto.Repo,
    otp_app: :hella,
    adapter: Ecto.Adapters.Postgres
end
