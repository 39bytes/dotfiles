if status is-interactive
    # Commands to run in interactive sessions can go here
end

set --export VISUAL nvim
set --export EDITOR nvim

zoxide init fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Created by `pipx` on 2024-06-28 01:05:45
set PATH $PATH /home/jeff/.local/bin
