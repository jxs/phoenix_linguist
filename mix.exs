defmodule PhoenixLinguist.Mixfile do
  use Mix.Project

  def project do
    [app: :phoenix_linguist,
     version: "0.0.1",
     elixir: "~> 1.0",
     description: description,
     package: package,
     docs: &docs/0,
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
     {:linguist, ">= 0.1.5"},
     {:earmark, "~> 0.1", only: :docs},
     {:ex_doc, "~> 0.7.1", only: :docs}
    ]
  end

  defp description do
    "A project that integrates Phoenix with Linguist, providing a plug and view helpers"
  end

  defp package do
    [
        files: ["lib", "mix.exs", "README*", "LICENSE*"],
        contributors: ["Joao Oliveira"],
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/jxs/phoenix_linguist"}
    ]
  end

  defp docs do
    {ref, 0} = System.cmd("git", ["rev-parse", "--verify", "--quiet", "HEAD"])
    [source_ref: ref,
     main: "README",
     readme: "README.md"]
  end

end
