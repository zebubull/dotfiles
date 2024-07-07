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
A system config is just a folder that is specified when calling `sync.sh` which contains the exact same
structure of config dirs and then links individual files into where they should be. Take a peek in a system
folder for an example if you're confused. This feature might be removed in favor of a simpler system becuase
it is very over-engineered and I can see it becoming quite cumbersome in the future.

## Todo
[x] Basic config
[x] Sync packages
[ ] Sync AUR packages
[x] System-dependent config
[ ] Maybe overhaul system-dependent config
