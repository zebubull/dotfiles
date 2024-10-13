if status is-interactive
    # Commands to run in interactive sessions can go here
    alias userctl="systemctl --user"
    alias neofetch="fastfetch"
    alias l="ll"
end

fish_add_path ~/.local/bin
set -x EDITOR helix
source ~/.config/fish/secrets.fish

starship init fish | source
