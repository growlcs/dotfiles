# Dotfiles

- `home/files/` holds standalone dotfiles under their `$HOME`-relative paths.
- `nix/flake/tools/` groups each tool's packages and configuration. `nix/flake/hjem.nix` combines them into the standalone manifest.
- `pkgs/` holds local package recipes.
- `flake.nix` declares inputs. `flake.output.nix` exposes the standalone profile, `hjemConfigurations.default`.

## Migrate to Determinate Nix on macOS

When ready, download and run `Determinate.pkg` from the [official macOS migration guide](https://docs.determinate.systems/guides/migrating-from-upstream-nix/#macos). The package upgrades the existing Nix installation in place, preserving its store and profiles. Open a fresh terminal and run `nix --version` to confirm it reports `Determinate Nix`, then validate the Hjem build below.

## Validate without applying

With the standalone Hjem CLI installed, run from the repo root:

```sh
hjem standalone build --flake . --flake-attr hjemConfigurations.default --impure
```

`--impure` makes `$HOME` available to Nix. Add new source files to Git before building so the flake can see them.

## Tools

- **Helix:** `hx` from the upstream Helix flake, currently at 25.07.1. Edit `config.toml` and `languages.toml` in `nix/flake/tools/helix/`.
- **CLI:** eza, Nushell, Atuin, Jujutsu (`jj`), Lazygit, Delta, zoxide, jq, Mike Farah's yq, direnv, and nix-direnv. Git comes from the existing system/profile. A separate nixpkgs pin supplies the CLI and language packages. Atuin uses a pinned upstream macOS binary until nixpkgs catches up.
- **Languages:** Rust (rust-analyzer and rustfmt), Zig (ZLS and `zig fmt`), Go (gopls and gofumpt), Java (JDT LS and google-java-format), Lean (Lean 4 and `lake serve`), TypeScript/TSX (TypeScript Language Server and Prettier), and Nix (nil and nixfmt). Lean has no formatter configured.
- **Rex (macOS):** `rex` runs the CLI bundled with `/Applications/Rex.app`. Install or update the app separately.
- **Autolith:** tracks the [upstream flake](https://github.com/lambda-symbolics/autolith) without a version in the input URL. Run `nix flake update autolith` to record the latest upstream commit in `flake.lock` before rebuilding.

After Hjem activation, binaries are in `${XDG_STATE_HOME:-$HOME/.local/state}/hjem/standalone/current-profile/bin`.

To use direnv in zsh, add `eval "$(direnv hook zsh)"` to your zsh startup config. With the default config directory, the Hjem-managed nix-direnv script provides `use flake` for trusted `.envrc` files.

## Lace in Helix

The Hjem profile installs `lace`, `lace-lsp`, and the Lace Tree-sitter runtime. Open `.lace` files for Lisp-style highlighting and two-space list indentation. Use `maf` to select a step or message handler, `mat` to select an entity or type, and `:format` to run `lace fmt`.

The flake input points to the local Lace Git checkout at `/Users/growl/eng/personal/lace`. After committing changes to `main` there, run `nix flake update lace` here to refresh the pin. If the checkout moves, update the input URL first.

From the dotfiles root, apply the profile and verify it:

```sh
hjem standalone switch --flake . --flake-attr hjemConfigurations.default --impure
command -v lace lace-lsp
hx --health lace
```
