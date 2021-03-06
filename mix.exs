defmodule PhoenixGenDocs.Mixfile do
  use Mix.Project

  def project do
    [app: :phoenix_gen_docs,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  def application do
    [applications: [:logger, :earmark]]
  end

  # Dependencies
  defp deps do
    [
      {:earmark, "~> 1.0.1"}
    ]
  end
end
