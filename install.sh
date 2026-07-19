#!/usr/bin/env bash
set -Eeuo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly REPO_ROOT
BACKUP_TIMESTAMP="$(date +%Y%m%d%H%M%S)"
readonly BACKUP_TIMESTAMP

fail() {
  printf 'error: %s\n' "$*" >&2
  exit 1
}

configure_brew_shell() {
  if command -v brew >/dev/null 2>&1; then
    eval "$(brew shellenv)"
  elif [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  else
    fail "Homebrew was installed but its executable could not be located"
  fi
}

install_homebrew() {
  [[ "$(uname -s)" == "Darwin" ]] || fail "this Brewfile targets macOS casks"

  if ! command -v brew >/dev/null 2>&1; then
    command -v curl >/dev/null 2>&1 || fail "curl is required to install Homebrew"
    printf '%s\n' "Homebrew not found; running the upstream installer."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  configure_brew_shell
}

link_with_backup() {
  local source_path="$1"
  local destination_path="$2"

  if [[ -L "$destination_path" ]] && [[ "$(readlink "$destination_path")" == "$source_path" ]]; then
    printf 'linked: %s\n' "$destination_path"
    return
  fi

  if [[ -e "$destination_path" || -L "$destination_path" ]]; then
    local backup_path="${destination_path}.backup.${BACKUP_TIMESTAMP}"
    mv "$destination_path" "$backup_path"
    printf 'backup: %s -> %s\n' "$destination_path" "$backup_path"
  fi

  ln -s "$source_path" "$destination_path"
  printf 'linked: %s -> %s\n' "$destination_path" "$source_path"
}

main() {
  install_homebrew

  printf '%s\n' "Reconciling Homebrew packages."
  brew bundle --file "$REPO_ROOT/Brewfile"

  mkdir -p "$HOME/.config"
  link_with_backup "$REPO_ROOT/nvim" "$HOME/.config/nvim"
  link_with_backup "$REPO_ROOT/vimrc" "$HOME/.vimrc"

  printf '%s\n' "Synchronizing pinned Neovim plugins."
  nvim --headless "+Lazy! sync" +qa

  printf '%s\n' "Bootstrap complete."
}

main "$@"
