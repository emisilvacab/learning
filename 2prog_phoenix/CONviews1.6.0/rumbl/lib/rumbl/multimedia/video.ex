defmodule Rumbl.Multimedia.Video do
  use Ecto.Schema

  import Ecto.Changeset
  #Para que pk se forme por id y permalink, le ponemos la opcion autogenerate true para id
  @primary_key {:id, Rumbl.Multimedia.Permalink, autogenerate: true}
  schema "videos" do
    field :description, :string
    field :title, :string
    field :url, :string
    field :slug, :string
    #field :user_id, :id REPLACED BY:
    belongs_to :user, Rumbl.Accounts.User
    belongs_to :category, Rumbl.Multimedia.Category
    has_many :annotations, Rumbl.Multimedia.Annotation

    timestamps()
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:url, :title, :description, :category_id])
    #cast prepara input conteniendo campos especificos para inclusion segura a la db, requerimos que
    #todos los campos esten presentes, usa una whitelist para decirle a Eto que campos de user-input
    #son validos/estan habilitados en el input input
    |> validate_required([:url, :title, :description])
    #valida qué campos deben estar presentes de la lista de campos
    #user_id no es necesario porque no se hace input de este, se saca directamente de la aplicacion, de
    #el usuario logeado,
    |> assoc_constraint(:category)
    |> slugify_title()
  end

  defp slugify_title(changeset) do
    case fetch_change(changeset, :title) do
      {:ok, new_title} -> put_change(changeset, :slug, slugify(new_title))
      :error -> changeset
    end
  end

  defp slugify(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[^\w-]+/u, "-")
  end
end
