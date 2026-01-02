source /usr/share/cachyos-fish-config/cachyos-config.fish

function fish_greeting
end

set --export VISUAL nvim
set --export EDITOR nvim
set --export MANPAGER 'nvim +Man!'

zoxide init fish | source
source (/usr/bin/starship init fish --print-full-init | psub)

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

alias ls='eza -al --no-user --color=always --group-directories-first --icons'

# pnpm
set -gx PNPM_HOME "/home/solitus/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
