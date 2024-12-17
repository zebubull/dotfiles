set -l progname dotsync
set -l commands help info sync update

complete -c $progname -f
complete -c $progname -d "A dotfile sync utility"

complete -c $progname -n "not __fish_seen_subcommand_from $commands" -a help -d "Print a help message"
complete -c $progname -n "not __fish_seen_subcommand_from $commands" -a info -d "Show some info about the program"
complete -c $progname -n "not __fish_seen_subcommand_from $commands" -a sync -d "Sync current config and packages"
complete -c $progname -n "not __fish_seen_subcommand_from $commands" -a update -d "Update the installed package list"

complete -c $progname -n "__fish_seen_subcommand_from sync" -l dry -d "Do a dry run, only printing changes and not performing them"
complete -c $progname -n "__fish_seen_subcommand_from sync" -l force -d "Reinstall currently installed files and packages"
