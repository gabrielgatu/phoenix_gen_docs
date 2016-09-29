defmodule PhoenixGenDocs.Scope do

  @spec group_routes_based_on_scope([PhoenixGenDocs.Route.t]) :: list
  def group_routes_based_on_scope(routes) do
    routes
    |> infer_common_scopes_in_routes()
    |> group_routes_based_on_common_scope(routes)
    |> group_scopes_with_only_one_route()
  end

  @spec group_routes_based_on_common_scope([list], [PhoenixGenDocs.Route.t]) :: list
  defp group_routes_based_on_common_scope(scopes, routes) do
    Enum.map(scopes, fn scope ->
      Enum.reduce(routes, %{}, fn(route, acc) ->
        if String.starts_with?(route.path, "/" <> scope),
          do: Map.update(acc, scope, [route], &(&1 ++ [route])), # Append to bottom
          else: acc
      end)
    end)
  end

  @spec group_scopes_with_only_one_route([list]) :: list
  defp group_scopes_with_only_one_route(scopes) do
    Enum.reduce(scopes, %{}, fn (scope_with_routes, scopes) ->
      {scope_name, scope_routes} = Enum.at(scope_with_routes, 0)

      if Enum.count(scope_routes) == 1,
        do: Map.update(scopes, "/", [Enum.at(scope_routes, 0)], &[Enum.at(scope_routes, 0) | &1]),
        else: Map.put(scopes, scope_name, scope_routes)
    end)
  end

  @spec infer_common_scopes_in_routes([PhoenixGenDocs.Route.t]) :: [String.t]
  defp infer_common_scopes_in_routes(routes) do
    Enum.reduce(routes, [], fn(route, scopes) ->
      case get_scope_from_path(route.path) do
        nil -> scopes
        scope -> if scope in scopes, do: scopes, else: [scope | scopes]
      end
    end)
  end

  @spec get_scope_from_path(String.t) :: String.t | nil
  defp get_scope_from_path(path) do
    case String.split(path, "/") do
      ["", scope | _] when scope != "" -> scope
      [scope | _] when scope != "" -> scope
      _ -> nil
    end
  end
end
