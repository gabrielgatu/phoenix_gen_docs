defmodule Mix.Tasks.Phoenix.Gen.Docs do
  @moduledoc """
  USE THIS ONLY FOR PHOENIX BASED PROJECTS!

  It generates a HTML based documentation for the routes
  contained in YourApp.Routes module.

  You just need to write function documentation for
  the route handlers, example:

  If you have in your router

  get "/user/:id", MyController, :show

  Then in the MyController module, above
  the `def show(conn, params) do` function,
  you'll write the docs.

  @doc "Given an integer id in url params, it returns the relative user"
  def show(conn, params) do
     ...
  end

  Automatically it will be used as a documentation for this route.

  All the docs are contained inside the /docs folder, at the root
  of your project.
  """
  
  use Mix.Task

  @shortdoc "Generates an API documentation"

  def run(args) do
    Mix.Task.run "compile", args

    Module.concat(Mix.Phoenix.base(), "Router")
    |> apply(:__routes__, [])
    |> Enum.map(&PhoenixGenDocs.Route.new/1)
    |> PhoenixGenDocs.Scope.group_routes_based_on_scope()
    |> PhoenixGenDocs.Generator.generate()
  end
end
