defmodule MhZ19.MixProject do
  use Mix.Project

  def project do
    [
      app: :mh_z19,
      version: "0.1.1",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: "https://github.com/kentaro/mh_z19_ex",
      homepage_url: "https://github.com/kentaro/mh_z19_ex",
      description: description(),
      package: package(),
      docs: docs(),
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
      {:ex_doc, "~> 0.23", only: :dev, runtime: false}
    ]
  end

  defp description do
    "A Elixir library to retrieve CO2 concentration value from MH-Z19 sensor."
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/kentaro/mh_z19_ex"}
    ]
  end

  defp docs do
    [
      main: "MhZ19",
    ]
  end
end
