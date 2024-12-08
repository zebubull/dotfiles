function __fish_print_aur_packages
    pacman -Qm | string match -rv debug | string replace ' ' \t
    return 0
end
