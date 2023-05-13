defmodule HelloWeb.HelloHTML do
  use HelloWeb, :html

  embed_templates "page_html/*"
end
