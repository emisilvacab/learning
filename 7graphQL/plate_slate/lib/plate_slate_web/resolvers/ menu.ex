defmodule PlateSlateWeb.Resolvers.Menu do
  import Absinthe.Resolution.Helpers

  alias Absinthe.Phase.Schema.Arguments.Data
  alias PlateSlate.Menu
  alias PlateSlate.Menu.Item
  alias PlateSlate.Repo

  def menu_items(_, args, _) do
    {:ok, Menu.list_items(args)}
  end

  def search(_, %{matching: term}, _) do
    {:ok, Menu.search(term)}
  end

  def items_for_category(category, args, %{context: %{loader: loader}}) do
    loader
    |> Dataloader.load(Menu, {:items, args}, category)
    |> on_load(fn loader ->
      items = Dataloader.get(loader, Menu, {:items, args}, category)
      {:ok, items}
    end)
  end

  # def items_for_category(category, _, _) do
  #   query = Ecto.assoc(category, :items)
  #   {:ok, PlateSlate.Repo.all(query)}
  # end

  def category_for_item(menu_item, _, %{context: %{loader: loader}}) do
    loader
    |> Dataloader.load(Menu, :category, menu_item)
    |> on_load(fn loader ->
      category = Dataloader.get(loader, Menu, :category, menu_item)
      {:ok, category}
    end)
  end

  # def category_for_item(menu_item, _, _) do
  #   batch({PlateSlate.Menu, :categories_by_id}, menu_item.category_id, fn
  #     categories ->
  #       {:ok, Map.get(categories, menu_item.category_id)}
  #   end) |> IO.inspect
  # end

  def create_item(_, %{input: params}, _) do
    with {:ok, item} <- Menu.create_item(params) do
      {:ok, %{menu_item: item}}
    end
    # case context do
    #   %{current_user: %{role: "employee"}} ->
    #     with {:ok, item} <- Menu.create_item(params) do
    #       {:ok, %{menu_item: item}}
    #     end

    #   _ ->
    #     {:error, "unauthorized"}
    # end
  end

  def update_item(_, %{input: params, id: id}, _) do
    menu_item = Repo.get(Item, id)

    with {:ok, menu_item} <- Menu.update_item(menu_item, params) do
      {:ok, %{menu_item: menu_item}}
    end
  end

  def get_item(_, %{id: id}, %{context: %{loader: loader}}) do
    loader
    |> Dataloader.load(Menu, Menu.Item, id)
    |> on_load(fn loader ->
      {:ok, Dataloader.get(loader, Menu, Menu.Item, id)}
    end)
  end
end
