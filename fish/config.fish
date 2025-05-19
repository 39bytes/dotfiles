if status is-interactive
    # Commands to run in interactive sessions can go here
end

set --export VISUAL nvim
set --export EDITOR nvim
set --export MANPAGER 'nvim +Man!'

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


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/home/jeff/.opam/opam-init/init.fish' && source '/home/jeff/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/jeff/.ghcup/bin # ghcup-env
