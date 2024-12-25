# Dotfiles
This repository contains all the dotfiles I use on my desktop and laptop. I use a custom script `dotsync` to allow myself to synchronize packages and common dotfiles between my machines while still being able to have machine-specific config for certain programs (mainly those that depend on screen size and/or monitor configuration).

## `dotsync`
Dotsync is a simple python script that keeps packages and dotfiles synchronized between my machines. Configuration is done through `dotconf.py` which contains enough comments and examples to be able to figure out how it works.
Essentially, common config is in the `common` directory and machine-specific config lies in the directory matching that machines name. The `manual_config` directory contains files that are manually copied, mainly for security reasons.

## dwl
The `dwl` directory contains all the patches and dwl config that I use on my machine. dwl must be manually patched and installed. I probably won't ever change this because it works good enough and I don't have to do it very often.

## Disclaimer
I've only tested this stuff on my own machines, use it at your own risk.
