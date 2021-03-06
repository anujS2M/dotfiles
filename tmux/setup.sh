#!/usr/bin/env bash

RED='\033[0;31m'
NC='\033[0m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'

is_app_installed() {
  type "$1" &>/dev/null
}

# Check if tmux is installed
if ! is_app_installed tmux; then
  printf "%sCreating symlink for .tmux.conf\n%s" "${GREEN}" "${NC}"
  printf "${GREEN}Creating symlink for .tmux.conf\n${NC}"
  ln -sf "$(pwd)"/tmux/tmux.conf "$HOME"/.tmux.conf
  printf "${RED}Missing dependency: Tmux\n${NC}"
  printf "${GREEN}Installing tmux\n${NC}"
  nix-env -i tmux
  printf "${GREEN}Installing tmux plugin manager\n${NC}"
  if [ ! -e "$HOME/.tmux/plugins/tpm" ]; then
    printf "${YELLOW}WARNING: Cannot found TPM (Tmux Plugin Manager) at default location: \$HOME/.tmux/plugins/tpm.\n${NC}"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    # Install TPM plugins.
    # TPM requires running tmux server, as soon as `tmux start-server` does not work
    # create dump __noop session in detached mode, and kill it when plugins are installed
    printf "${GREEN}Installing TPM plugins\n${NC}"
    tmux new -d -s __noop >/dev/null 2>&1 || true
    tmux set-environment -g TMUX_PLUGIN_MANAGER_PATH "$HOME/.tmux/plugins"
    "$HOME"/.tmux/plugins/tpm/bin/install_plugins || true
    tmux kill-session -t __noop >/dev/null 2>&1 || true
  fi
fi

# Refer https://github.com/tmuxinator/tmuxinator
if ! is_app_installed ruby; then
  gem install tmuxinator
  sudo wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh -O /usr/local/share/zsh/site-functions/_tmuxinator
fi
