defmodule Zenrows.MixProject do
  use Mix.Project

  def project do
    [
      app: :zenrows,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:tesla, "~> 1.8.0"},
      {:hackney, "~> 1.20"},
      {:jason, ">= 1.0.0"},
      {:nimble_options, "~> 1.1"}
    ]
  end
end
