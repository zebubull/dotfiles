if status is-interactive
    set fish_greeting
    alias ustatus="systemctl --user status"
    alias uenable="systemctl --user enable"
    alias ustart="systemctl --user start"
    set width (tput cols)
    figlet -w $width -c -k "I use Arch BTW"
    # Commands to run in interactive sessions can go here
end
