defmodule Mix.Tasks.Phoenix.Gen.Docs do
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
