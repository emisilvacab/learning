defmodule PlateSlateWeb.Schema.Mutation.UpdateMenuItemTest do
  use PlateSlateWeb.ConnCase, async: true

  alias PlateSlate.Repo
  alias PlateSlate.Menu
  alias PlateSlate.Menu.Item

  import Ecto.Query

  setup do
    PlateSlate.Seeds.run()

    category_id =
      from(t in Menu.Category, where: t.name == "Sandwiches")
      |> Repo.one!()
      |> Map.fetch!(:id)
      |> to_string

    {:ok, category_id: category_id}
  end

  @query """
  mutation ($menuItem: MenuItemInput!, $id: Int!) {
    updateMenuItem(input: $menuItem, id: $id) {
      errors {
        key
        message
      }
      menuItem {
        name
        description
        price
      }
    }
  }
  """
  test "updateMenuItem field updates an item", %{category_id: category_id} do
    menu_item = %{
      "name" => "RRRR",
      "price" => "8.50",
      "categoryId" => category_id,
      "description" => "De prueba"
    }

    item = Repo.get_by(Item, name: "Reuben")

    conn = build_conn()

    conn =
      post conn, "/api",
        query: @query,
        variables: %{menuItem: menu_item, id: item.id}

    assert json_response(conn, 200) == %{
             "data" => %{
               "updateMenuItem" => %{
                 "errors" => nil,
                 "menuItem" => %{
                   "name" => menu_item["name"],
                   "description" => menu_item["description"],
                   "price" => menu_item["price"]
                 }
               }
             }
           }
  end

  test "updating a menu item with an existing name fails",
       %{category_id: category_id} do
    menu_item = %{
      "name" => "Water",
      "description" => "Roast beef, caramelized onions, horseradish, ...",
      "price" => "5.75",
      "categoryId" => category_id
    }

    item = Repo.get_by(Item, name: "Reuben")

    conn = build_conn()

    conn =
      post conn, "/api",
        query: @query,
        variables: %{menuItem: menu_item, id: item.id}

    assert json_response(conn, 200) == %{
             "data" => %{
               "updateMenuItem" => %{
                 "errors" => [
                   %{"key" => "name", "message" => "has already been taken"}
                 ],
                 "menuItem" => nil
               }
             }
           }
  end
end
