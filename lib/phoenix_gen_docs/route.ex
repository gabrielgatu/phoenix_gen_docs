defmodule PhoenixGenDocs.Route do
  defstruct [:id, :verb, :path, :docs]

  @type t :: %PhoenixGenDocs.Route{}

  def new(%{verb: verb, path: path, plug: plug, opts: opts}) do
    id = get_id_for_route(verb, path)
    docs = get_function_docs(plug, opts) || ""
    %__MODULE__{id: id, verb: verb, path: path, docs: docs}
  end

  defp get_function_docs(mod, func) do
    Code.get_docs(mod, :docs)
    |> Enum.find(fn {{fn_name, _}, _, :def, _, doc} -> fn_name == func end)
    |> elem(4)
  end

  defp get_id_for_route(verb, path) do
    filename =
      path
      |> String.replace("/", "")
      |> String.replace(":", "")

    Atom.to_string(verb) <> filename
  end
end
