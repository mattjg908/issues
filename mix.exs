defmodule Issues.MixProject do
  use Mix.Project

  def project do
    [
      app: :issues,
      escript: escript_config(),
      version: "0.1.0",
      name: "Issues",
      source_url: "https://github.com/mattjg908/issues",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:benchee, "~> 1.0", only: :dev},
      {:excoveralls, "~> 0.5.5", only: :test},
      {:earmark, "~> 1.4.10"},
      {:ex_doc, "~> 0.20.0"},
      {:httpoison, "~> 1.0.0"},
      {:mix_test_watch, "~> 1.0", only: :dev, runtime: false},
      {:poison, "~> 3.1"},
      {:stream_data, "~> 0.1", only: :test}
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
  defp escript_config do
    [
      main_module: Issues.CLI
    ]
  end
end
