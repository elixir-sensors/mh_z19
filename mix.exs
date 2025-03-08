defmodule MhZ19.MixProject do
  use Mix.Project

  @version "0.1.1"
  @source_url "https://github.com/elixir-sensors/mh_z19"
  @reuse_compliance_url "https://api.reuse.software/info/github.com/elixir-sensors/mh_z19"

  def project do
    [
      app: :mh_z19,
      version: @version,
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      docs: docs()
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
      {:circuits_uart, "~> 1.3"},
      {:ex_doc, "~> 0.23", only: :dev, runtime: false},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.1", only: [:dev, :test], runtime: false}
    ]
  end

  defp description do
    "A Elixir library to retrieve CO2 concentration value from MH-Z19 sensor."
  end

  defp package do
    [
      files: [
        "lib",
        "mix.exs",
        "README.md",
        "CHANGELOG*",
        "LICENSES",
        "NOTICE",
        "REUSE.toml"
      ],
      licenses: ["Apache-2.0"],
      links: %{
        "GitHub" => @source_url,
        "REUSE compliance" => @reuse_compliance_url
      }
    ]
  end

  defp docs do
    [
      extras: ["README.md"],
      main: "MhZ19",
      source_ref: "v#{@version}",
      source_url: @source_url
    ]
  end
end
