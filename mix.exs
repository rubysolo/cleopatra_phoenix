defmodule CleopatraPhoenix.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :cleopatra_phoenix,
      version: @version,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "Cleopatra design system components for Phoenix"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:phoenix, ">= 1.7.0"}
    ]
  end
end
