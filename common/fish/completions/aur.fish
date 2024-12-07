set -l progname aur
set -l commands check get help search update
set -l listinstalled "(__fish_print_pacman_packages --installed)"

complete -c $progname -f
complete -c $progname -d "A bundle of useful AUR tools"

complete -c $progname -n "not __fish_seen_subcommand_from $commands" -a check -d "Check installed AUR packages for updates"
complete -c $progname -n "not __fish_seen_subcommand_from $commands" -a get -d "Install a package from the AUR"
complete -c $progname -n "not __fish_seen_subcommand_from $commands" -a help -d "Print a help message"
complete -c $progname -n "not __fish_seen_subcommand_from $commands" -a search -d "Search for a package on the AUR"
complete -c $progname -n "not __fish_seen_subcommand_from $commands" -a update -d "Update a package from the AUR"

complete -c $progname -n "__fish_seen_subcommand_from update" -xa $listinstalled
