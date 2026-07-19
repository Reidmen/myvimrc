# Neovim workstation bootstrap

Reproducible macOS workstation state centered on Neovim. The repository keeps the
current Lua configuration, its plugin lockfile, a legacy `vimrc`, and the
Homebrew inventory required to rebuild the surrounding toolchain.

## Bootstrap

```bash
git clone git@github.com:Reidmen/myvimrc.git ~/.dotfiles/myvimrc
~/.dotfiles/myvimrc/install.sh
```

`install.sh` is intentionally Brew-first:

1. Verify macOS and install Homebrew from the upstream installer when absent.
2. Load `brew shellenv` for the current process.
3. Reconcile the machine against `Brewfile` with `brew bundle`.
4. Symlink `nvim/` to `~/.config/nvim` and `vimrc` to `~/.vimrc`.
5. Synchronize plugins from `nvim/lazy-lock.json` in headless Neovim.

The installer is idempotent for links it owns. A conflicting file or directory
is moved alongside itself to `<name>.backup.<timestamp>` before linking; it is
never deleted.

## Editing policy

Zed is the preferred editor for sustained development. Neovim is the
agent-first, low-latency surface for quickly reviewing and navigating changes
produced by coding agents.

## Repository contract

| Path | Role |
| --- | --- |
| `Brewfile` | Declarative package inventory, grouped by operational intent. |
| `install.sh` | Homebrew bootstrap, package reconciliation, linking, and plugin sync. |
| `nvim/` | Live Neovim configuration copied from `~/.config/nvim`. |
| `nvim/lazy-lock.json` | Exact plugin revisions for deterministic restores. |
| `vimrc` | Preserved minimal Vim configuration for hosts without Neovim. |

The Brewfile records six taps, 43 explicitly requested formulae, 16 casks, and
three ecosystem-managed CLI tools. Sections distinguish editor/terminal tools,
version control, AI agents, language runtimes, language servers, quality gates,
data services, cloud tooling, and desktop applications. Transitive formulae are
resolved by Homebrew and deliberately omitted.

## Neovim architecture

- `init.lua` loads editor options, `lazy.nvim`, and keymaps.
- `lua/plugins/` contains single-purpose plugin specifications for navigation,
  UI, Treesitter, Git, LSP, and the Rose Pine theme.
- LSP uses the Neovim 0.11 native configuration and completion APIs. The
  Brewfile supplies ElixirLS, `gopls`, `rust-analyzer`, and `zls`.
- Treesitter installs Elixir and HEEx parsers; `lazy-lock.json` pins every plugin
  resolved by `lazy.nvim`.

## Operations

Validate machine drift without changing it:

```bash
brew bundle check --no-upgrade --file ./Brewfile
nvim --headless '+checkhealth' +qa
```

After changing the local setup, refresh `nvim/` and update the relevant Brewfile
section explicitly. Do not replace the Brewfile with an unreviewed dump: preserve
intent grouping, tap qualification, link options, and non-Homebrew tool entries.
