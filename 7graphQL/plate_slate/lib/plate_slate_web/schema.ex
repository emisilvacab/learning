defmodule PlateSlateWeb.Schema do
  use Absinthe.Schema

  alias Absinthe.Middleware
  alias PlateSlateWeb.Resolvers
  alias PlateSlateWeb.Schema.Middleware

  import_types(__MODULE__.MenuTypes)
  import_types(__MODULE__.OrderingTypes)
  import_types(__MODULE__.AccountTypes)
  import_directives Absinthe.Phoenix.Types
  import_types Absinthe.Phoenix.Types

  def middleware(middleware, field, object) do
    middleware
    |> apply(:errors, field, object)
    |> apply(:get_string, field, object)
    |> apply(:debug, field, object)
  end

  defp apply(middleware, :errors, _field, %{identifier: :mutation}) do
    middleware ++ [Middleware.ChangesetErrors]
  end
  defp apply([], :get_string, field, %{identifier: :allergy_info}) do
    [{Absinthe.Middleware.MapGet, to_string(field.identifier)}]
  end
  defp apply(middleware, :debug, _field, _object) do
    if System.get_env("DEBUG") do
      [{Middleware.Debug, :start}] ++ middleware
    else
      middleware
    end
  end
  defp apply(middleware, _, _, _) do
    middleware
  end

  #Funcionalmente es lo mismo pero nos da mas flexibilidad, previamente haciamos
  #pm por objetos o campos dentro de middleware/3 function heads
  # => cada situacion era manejada totalmente por separado
  #    si queriamos aplicar middleware comun para todos los campos
  #    lo debiamos agregar a cada clausula del middleware/3 block

  #--------------------------------------------------------------------------------

  # def middleware(middleware, field, %{identifier: :allergy_info} = object) do
  #   new_middleware = {Absinthe.Middleware.MapGet, to_string(field.identifier)}

  #   middleware
  #   |> Absinthe.Schema.replace_default(new_middleware, field, object)
  # end

  # def middleware(middleware, _field, %{identifier: :mutation}) do
  #   middleware ++ [Middleware.ChangesetErrors]
  # end

  # def middleware(middleware, _field, _object) do
  #   middleware
  # end

  query do
    import_fields(:menu_queries)

    field :search, list_of(:search_result) do
      arg(:matching, non_null(:string))
      resolve(&Resolvers.Menu.search/3)
    end

    field :me, :user do
      middleware Middleware.Authorize, :any
      resolve &Resolvers.Accounts.me/3
    end

    field :menu_item, :menu_item do
      arg :id, non_null(:id)
      resolve &Resolvers.Menu.get_item/3
    end
  end

  mutation do
    field :create_menu_item, :menu_item_result do
      arg(:input, non_null(:menu_item_input))
      middleware Middleware.Authorize, "employee"
      resolve(&Resolvers.Menu.create_item/3)
    end

    field :update_menu_item, :menu_item_result do
      arg(:input, non_null(:menu_item_input))
      arg(:id, non_null(:integer))
      middleware(Middleware.ChangesetErrors)
      resolve(&Resolvers.Menu.update_item/3)
    end

    field :place_order, :order_result do
      arg(:input, non_null(:place_order_input))
      middleware Middleware.Authorize, :any
      resolve(&Resolvers.Ordering.place_order/3)
    end

    field :ready_order, :order_result do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Ordering.ready_order/3)
    end

    field :complete_order, :order_result do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Ordering.complete_order/3)
    end

    field :login, :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      arg(:role, non_null(:role))
      resolve(&Resolvers.Accounts.login/3)
      middleware fn res, _ ->
        with %{value: %{user: user}} <- res do
          %{res | context: Map.put(res.context, :current_user, user)}
        end
      end
    end
  end

  subscription do
    field :new_order, :order do
      config(fn _args, %{context: context} ->
        case context[:current_user] do
          %{role: "customer", id: id} ->
            {:ok, topic: id}
          %{role: "employee"} ->
            {:ok, topic: "*"}
          _ ->
            {:error, "unauthorized"}
        end
      end)

      # resolve(fn root, _, _ ->
      #   IO.inspect(root)
      #   {:ok, root}
      # end)
    end

    field :update_order, :order do
      arg(:id, non_null(:id))

      config(fn args, _info ->
        {:ok, topic: args.id}
      end)

      trigger([:ready_order, :complete_order],
        topic: fn
          %{order: order} -> [order.id]
          _ -> []
        end
      )

      resolve(fn %{order: order}, _, _ ->
        {:ok, order}
      end)
    end
  end

  scalar :date do
    parse(fn input ->
      with %Absinthe.Blueprint.Input.String{value: value} <- input do
        Date.from_iso8601(value)
      else
        _ -> :error
      end
    end)

    serialize(fn date ->
      Date.to_iso8601(date)
    end)
  end

  scalar :decimal do
    parse(fn
      %{value: value}, _ ->
        # Decimal.parse(value)
        {:ok, Decimal.new(value)}

      _, _ ->
        :error
    end)

    serialize(&to_string/1)
  end

  enum :sort_order do
    value(:asc)
    value(:desc)
  end

  @desc "An error encountered trying to persist input"
  object :input_error do
    field :key, non_null(:string)
    field :message, non_null(:string)
  end

  def dataloader() do
    alias PlateSlate.Menu
    Dataloader.new
    |> Dataloader.add_source(Menu, Menu.data())
  end

  def context(ctx) do
    Map.put(ctx, :loader, dataloader())
  end

  def plugins do
    [Absinthe.Middleware.Dataloader | Absinthe.Plugin.defaults]
  end
end
