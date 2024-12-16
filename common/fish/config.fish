if status is-interactive
    # Commands to run in interactive sessions can go here
    alias userctl="systemctl --user"
    alias neofetch="fastfetch"
    alias l="ll"
    alias mount="mount -o uid=zebu,gid=users"
end

fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
set -x EDITOR helix
set __fish_git_prompt_showupstream informative
set __fish_git_prompt_showdirtystate 1
set __fish_git_prompt_showcolorhints 1
set __fish_git_prompt_color purple
source ~/.config/fish/secrets.fish
