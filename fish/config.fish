if status is-interactive
    set fish_greeting
    set width (tput cols)
    figlet -w $width -c -k "I use Arch BTW"
    # Commands to run in interactive sessions can go here
end
