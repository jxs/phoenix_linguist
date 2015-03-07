  defmodule PhoenixLinguistPlugTest.ErrorView do
    use Phoenix.View, root: "test/fixtures/templates"
    use Phoenix.HTML

    def render("404.html", _assigns) do
      "Page not found - 404"
    end

  end
