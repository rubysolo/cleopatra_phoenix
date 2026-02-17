# Cleopatra Phoenix

A Phoenix generator for the [Cleopatra](https://github.com/moesaid/cleopatra) design system. Drop in 22 production-ready components, 10 color themes with dark mode, and an optional interactive storybook — with a single Mix task.

> **Credit:** The Cleopatra design system itself is created and maintained by [@moesaid](https://github.com/moesaid). This package is an unofficial Phoenix/LiveView generator that makes it easy to use those components in Elixir projects. All design credit belongs to the original author.

Cleopatra Phoenix replaces the default `CoreComponents` module that ships with `phx.new`, giving you a cohesive set of themed, accessible components built on Tailwind CSS v4 semantic color tokens. Every component works with Phoenix LiveView out of the box.

## What You Get

**22 Components**, each with multiple variants, sizes, and states:

| Category   | Components                                                          |
| ---------- | ------------------------------------------------------------------- |
| Layout     | `header`, `card`, `modal`, `drawer`, `separator`                    |
| Navigation | `breadcrumb`, `pagination`, `tabs`                                  |
| Forms      | `input` (text, select, checkbox, textarea — with labels and errors) |
| Actions    | `button`, `dropdown_menu`, `tooltip`                                |
| Feedback   | `alert`, `flash`, `badge`, `progress`, `skeleton`                   |
| Data       | `table`, `list`, `avatar`, `accordion`                              |
| Icons      | `icon` (Heroicons v2)                                               |

**10 Color Themes**, each with light and dark variants:

`neutral` `blue` `green` `orange` `yellow` `stone` `slate` `sky` `azure` `rose`

Themes are applied via CSS custom properties and a `data-theme` attribute, with client-side switching and `localStorage` persistence included in the generated root layout.

**PhoenixStorybook Integration** (optional) — stories for every component, ready to browse at `/storybook`.

## Installation

Add `cleopatra_phoenix` to your dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:cleopatra_phoenix, "~> 0.1.0"}
  ]
end
```

Then fetch and install:

```bash
mix deps.get
mix cleopatra.install
```

The installer generates:

- `lib/your_app_web/components/core_components.ex` — all 22 components
- `assets/css/app.css` — Tailwind v4 config with theme definitions
- `assets/css/components.css` — component CSS layer
- `lib/your_app_web/components/layouts/root.html.heex` — root layout with theme switching

Skip storybook files with `--no-storybook`:

```bash
mix cleopatra.install --no-storybook
```

### Post-Install Setup

The installer will print detailed next steps, but the short version:

1. **Add Heroicons** to `mix.exs` (required for the `icon` component):

    ```elixir
    {:heroicons,
     github: "tailwindlabs/heroicons",
     tag: "v2.1.1",
     sparse: "optimized",
     app: false,
     compile: false,
     depth: 1}
    ```

2. **Add PhoenixStorybook** to `mix.exs` (if you kept storybook):

    ```elixir
    {:phoenix_storybook, "~> 0.6.0"}
    ```

3. Run `mix deps.get` and follow the printed instructions for router, config, and watcher setup.

## Usage

Components work exactly like the Phoenix defaults — same function component API, same slot patterns. If you've used `CoreComponents` before, you already know the interface:

```heex
<.button variant="default">Save Changes</.button>
<.button variant="destructive" size="sm">Delete</.button>
<.button variant="outline" navigate={~p"/settings"}>Settings</.button>

<.card>
  <:header>
    <h3>Account Settings</h3>
  </:header>
  <p>Manage your preferences.</p>
</.card>

<.alert variant="success">
  <:title>Saved</:title>
  Your changes have been applied.
</.alert>

<.avatar src={@user.avatar_url} fallback="JD" size="lg" status="online" />

<.modal id="confirm-dialog" size="lg">
  <:title>Are you sure?</:title>
  This action cannot be undone.
</.modal>
```

### Theming

Themes are set via the `data-theme` attribute on `<html>`. The generated root layout handles this automatically, reading from `localStorage` and falling back to system preference.

Switch themes from LiveView:

```elixir
# Push a theme change event from your LiveView
{:noreply, push_event(socket, "phx:set-theme", %{theme: "blue"})}
```

Or set it directly in the client:

```javascript
localStorage.setItem("phx:theme", "rose-dark");
document.documentElement.setAttribute("data-theme", "rose-dark");
```

### Tailwind Integration

All semantic colors are registered as Tailwind theme values, so you can use them anywhere in your templates:

```heex
<div class="bg-primary text-primary-foreground rounded-lg p-4">
  Themed content
</div>
<span class="text-muted-foreground">Secondary text</span>
```

Available color tokens: `primary`, `secondary`, `destructive`, `success`, `warning`, `info`, `muted`, `accent`, `card`, `popover`, `background`, `foreground`, `border`, `input`, `ring`, `chart-1` through `chart-5`, and `sidebar-*` variants.

## Requirements

- Elixir ~> 1.14
- Phoenix >= 1.7.0
- Tailwind CSS v4

## Acknowledgments

This project is a Phoenix generator for the [Cleopatra design system](https://github.com/moesaid/cleopatra) by [@moesaid](https://github.com/moesaid). The component designs, themes, and styling are adapted from their work.

## License

MIT
