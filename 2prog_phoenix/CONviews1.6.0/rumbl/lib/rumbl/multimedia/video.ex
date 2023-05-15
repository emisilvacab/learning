defmodule Rumbl.Multimedia.Video do
  use Ecto.Schema
  import Ecto.Changeset

  schema "videos" do
    field :description, :string
    field :title, :string
    field :url, :string
    #field :user_id, :id REPLACED BY:
    belongs_to :user, Rumbl.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:url, :title, :description])
    #cast prepara input conteniendo campos especificos para inclusion segura a la db, requerimos que
    #todos los campos esten presentes, usa una whitelist para decirle a Eto que campos de user-input
    #son validos/estan habilitados en el input input
    |> validate_required([:url, :title, :description])
    #valida qué campos deben estar presentes de la lista de campos
    #user_id no es necesario porque no se hace input de este, se saca directamente de la aplicacion, de
    #el usuario logeado,
  end
end
