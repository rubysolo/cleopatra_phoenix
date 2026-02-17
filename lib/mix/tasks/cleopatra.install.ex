defmodule Mix.Tasks.Cleopatra.Install do
  @shortdoc "Installs Cleopatra design system components into your Phoenix project"

  @moduledoc """
  Installs Cleopatra design system components, theme CSS,
  and optional storybook stories into your Phoenix project.

      $ mix cleopatra.install

  ## Options

    * `--no-storybook` - Skip installation of PhoenixStorybook files

  The installer copies themed core components, CSS (with semantic
  color tokens and dark mode support), and a root layout with
  theme switching. If storybook is included, it also sets up
  PhoenixStorybook with stories for every component.
  """

  use Mix.Task

  @switches [no_storybook: :boolean]

  @impl true
  def run(args) do
    if Mix.Project.umbrella?() do
      Mix.raise("mix cleopatra.install must be run inside an umbrella child app, not the root")
    end

    {opts, _} = OptionParser.parse!(args, strict: @switches)

    app = Mix.Project.config()[:app]
    app_name = to_string(app)
    web_module = app_name |> Macro.camelize() |> Kernel.<>("Web")
    sandbox_class = String.replace(app_name, "_", "-")

    bindings = [
      web_module: web_module,
      app_name: app_name,
      sandbox_class: sandbox_class
    ]

    templates = templates_path()

    # Core files (always installed)
    gen_template(templates, "core_components.ex.eex",
      "lib/#{app_name}_web/components/core_components.ex", bindings)

    gen_template(templates, "app.css.eex",
      "assets/css/app.css", bindings)

    gen_file(templates, "components.css",
      "assets/css/components.css")

    gen_template(templates, "root.html.heex.eex",
      "lib/#{app_name}_web/components/layouts/root.html.heex", bindings)

    # Storybook files (optional)
    unless opts[:no_storybook] do
      install_storybook(templates, app_name, bindings)
    end

    Mix.shell().info("\n")
    print_instructions(app_name, web_module, opts)
  end

  defp install_storybook(templates, app_name, bindings) do
    gen_template(templates, "storybook.ex.eex",
      "lib/#{app_name}_web/storybook.ex", bindings)

    gen_template(templates, "storybook.css.eex",
      "assets/css/storybook.css", bindings)

    gen_file(templates, "_root.index.exs",
      "storybook/_root.index.exs")

    gen_file(templates, "welcome.story.exs",
      "storybook/welcome.story.exs")

    gen_file(templates, "_core_components.index.exs",
      "storybook/core_components/_core_components.index.exs")

    stories_path = Path.join(templates, "stories")

    stories_path
    |> File.ls!()
    |> Enum.sort()
    |> Enum.each(fn story_template ->
      target_name = String.replace_suffix(story_template, ".eex", "")

      gen_template(stories_path, story_template,
        "storybook/core_components/#{target_name}", bindings)
    end)
  end

  defp gen_template(source_dir, source_file, target, bindings) do
    source = Path.join(source_dir, source_file)
    content = EEx.eval_file(source, bindings)
    Mix.Generator.create_file(target, content)
  end

  defp gen_file(source_dir, source_file, target) do
    source = Path.join(source_dir, source_file)
    Mix.Generator.create_file(target, File.read!(source))
  end

  defp templates_path do
    :cleopatra_phoenix
    |> :code.priv_dir()
    |> to_string()
    |> Path.join("templates")
  end

  defp print_instructions(app_name, web_module, opts) do
    storybook? = !opts[:no_storybook]

    Mix.shell().info("""
    Cleopatra design system installed successfully!

    == Next steps ==

    1. Add the heroicons dependency to mix.exs:

        {:heroicons,
         github: "tailwindlabs/heroicons",
         tag: "v2.1.1",
         sparse: "optimized",
         app: false,
         compile: false,
         depth: 1}
    #{if storybook? do
      """

      2. Add the storybook dependency to mix.exs:

          {:phoenix_storybook, "~> 0.6.0"}

      3. Add storybook routes to lib/#{app_name}_web/router.ex:

          import PhoenixStorybook.Router

          scope "/" do
            storybook_assets()
          end

          scope "/", #{web_module} do
            pipe_through :browser
            live_storybook "/storybook",
              backend_module: #{web_module}.Storybook
          end

      4. Add storybook build profiles to config/config.exs:

          config :esbuild,
            storybook: [
              args: ~w(./js/storybook.js --bundle --target=es2017 --outdir=../priv/static/assets),
              cd: Path.expand("../assets", __DIR__),
              env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
            ]

          config :tailwind,
            storybook: [
              args: ~w(--input=css/storybook.css --output=../priv/static/assets/storybook.css),
              cd: Path.expand("../assets", __DIR__)
            ]

      5. Add storybook watchers to your dev endpoint in config/dev.exs:

          watchers: [
            esbuild: {Esbuild, :install_and_run, [:storybook, ~w(--watch)]},
            tailwind: {Tailwind, :install_and_run, [:storybook, ~w(--watch)]}
          ]

      6. Add storybook patterns to live_reload in config/dev.exs:

          live_reload: [
            patterns: [
              ~r"storybook/.*(exs)$"
            ]
          ]
      """
    else
      ""
    end}
    Then run:

        $ mix deps.get
    """)
  end
end
