if status is-interactive
    set fish_greeting
    alias userctl="systemctl --user"
    set width (tput cols)
    figlet -w $width -c -k "I use Arch BTW"
    # Commands to run in interactive sessions can go here
end
