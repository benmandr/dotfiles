source /usr/share/cachyos-fish-config/cachyos-config.fish

function fish_greeting
end

# pnpm
set -gx PNPM_HOME "/home/ben/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
