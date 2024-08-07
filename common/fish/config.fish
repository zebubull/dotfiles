if status is-interactive
    # Commands to run in interactive sessions can go here
    alias userctl="systemctl --user"
    alias neofetch="fastfetch"
    alias l="ll"
end

set PATH $PATH ~/.local/bin
source ~/.config/fish/secrets.fish
