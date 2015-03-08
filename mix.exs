defmodule PhoenixLinguist.Mixfile do
  use Mix.Project

  def project do
    [app: :phoenix_linguist,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: applications(Mix.env)]
  end

  defp applications(:test) do
    [:phoenix] ++ applications(:prod)
  end

  defp applications(_) do
    [:logger]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    # [{:phoenix, ">= 0.8.0"},
    [{:phoenix, ">= 0.10.0"},
     {:cowboy, "~> 1.0"},
     {:linguist, ">= 0.1.5"}
    ]
  end
end
