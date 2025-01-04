if status is-interactive
    # Commands to run in interactive sessions can go here
end

set --export VISUAL nvim
set --export EDITOR nvim

set --export GOPATH "$HOME/.go"

zoxide init fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Created by `pipx` on 2024-06-28 01:05:45
set PATH $PATH /home/jeff/.local/bin

eval "$(pyenv init -)"
source (/usr/bin/starship init fish --print-full-init | psub)
# pnpm
set -gx PNPM_HOME "/home/jeff/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end

# pnpm end
~/.local/bin/mise activate fish | source

# >>> coursier install directory >>>
set -gx PATH "$PATH:/home/jeff/.local/share/coursier/bin"
# <<< coursier install directory <<<
