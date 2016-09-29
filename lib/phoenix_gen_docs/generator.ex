defmodule PhoenixGenDocs.Generator do
  import Mix.Generator

  def generate(scopes) do
    prompt_for_overwrite_if_docs_dir_already_exists()

    create_directory "docs"

    # Create html files
    Enum.each scopes, fn {scope, routes} ->
      Enum.each routes, fn route ->
        create_file "./docs/#{route.id}.html", website_template(route: route, scopes: scopes, app_name: Mix.Phoenix.base())
      end
    end

    # Create css file
    create_directory "./docs/css/"
    create_file "./docs/css/markdown.css", css_markdown_text()

    Mix.shell.info """

    The API documentation has been created successfully!

    You can find them inside the /docs folder, at the root of
    your project.
    """
  end

  defp prompt_for_overwrite_if_docs_dir_already_exists do
    if File.exists?("docs") do
      Mix.shell.info [:green, "* info ", :reset, "Found an existing /docs folder in your project root."]
      overwrite? = Mix.shell.yes?("Do you want to overwrite it?")
      if overwrite? do
        Mix.shell.info [:green, "* info ", :reset, "Overwriting /docs folder"]
        File.rm_rf!("docs")
      end
    end
  end

  embed_text(:css_markdown, File.read! "./lib/phoenix_gen_docs/website/markdown.css")
  embed_template(:website, File.read! "./lib/phoenix_gen_docs/website/template.html.eex")
end
