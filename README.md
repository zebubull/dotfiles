# The official zebubull dotfiles
This repository contains my very official and very important dotfiles for my arch linux machines.
Everything is structured around the wonderful `sync.sh` script that installs all dotfiles by making
a bunch of symlinks to everything as need be. It also manages a list of installed packages that are
automatically synced with a pacman hook every time something is changed. Basically a scuffed version
of NixOS with a very weird and cursed shell script that does everything. 

## Normal Config
All normal config is placed in folders which are symlinked to their corresponding folder in $HOME/.config.
Some miscellaneous files that don't follow that pattern are linked to a specified target location.

## System-dependent Config
I have both a laptop and a desktop so being able to config certain things for multiple systems is necessary.
When linking a directory, `sync.sh` will check to see if a folder with the name of the current system (by default the hostname)
has a matching directory and link it. It will fall back to the common directory if it is not found. Individual file
linking does not support system-dependent config yet and those files live in the base directory, not common.

## Todo
- [x] Basic config
- [x] Sync packages
- [ ] Sync AUR packages
- [x] System-dependent config
- [x] Maybe overhaul system-dependent config
