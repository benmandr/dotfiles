source /usr/share/cachyos-fish-config/cachyos-config.fish

function fish_greeting
end

# pnpm
set -gx PNPM_HOME "/home/ben/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# ssh
if not pgrep -f ssh-agent >/dev/null
    eval (ssh-agent -c)
    set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    set -Ux SSH_AGENT_PID $SSH_AGENT_PID
end

# Auto-add your SSH key
ssh-add -q ~/.ssh/id_ed25519 2>/dev/null
