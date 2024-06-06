defmodule Zenrows.MixProject do
  use Mix.Project

  @source_url "https://github.com/guess/zenrows"
  @version "0.1.4"

  def project do
    [
      app: :zenrows,
      version: @version,
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      docs: docs()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:finch, "~> 0.13"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:jason, ">= 1.0.0"},
      {:nimble_options, "~> 1.1"},
      {:req, "~> 0.5.0"}
    ]
  end

  defp description() do
    """
    An Elixir client for the ZenRows API.
    """
  end

  defp package do
    [
      maintainers: ["Steve Strates"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp docs do
    [
      main: "readme",
      name: "ZenRows",
      source_ref: "v#{@version}",
      canonical: "http://hexdocs.pm/zenrows",
      source_url: @source_url,
      extras: ["README.md", "LICENSE"]
    ]
  end
end
