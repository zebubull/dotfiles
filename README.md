# Dotfiles
This repository mainly exists as a way for me to sync my dotfiles between my desktop and laptop. The `sync.sh` script does most of the work: it symlinks the relevant configs on each machine and installs some common packages. This is way too complex and sucks to use, but I haven't found anything that sucks less.

## sync.sh
Inside `synch.sh` are lists of directories and files to sync.
- For each directory, `sync.sh` will try to symlink the directory inside the folder matching the computer's hostname. If that directory does not exist, it will symlink the directory located in `common`.
- For each file, `sync.sh` is given a target and a destitination to sync. Individual files do not have system-dependent config, and will always be common to all systems. Files that need root permission to copy (i.e. those that go to `/etc`) have their own list as to not constantly prompt for root access.
`sync.sh` also uses the contents of `pkglist.txt` to sync packages between systems. Packages listed in `pkgignore.txt` will be ignored.

### Custom name
A custom name can be provided, i.e. `sync.sh foo` will search for directories inside `foo` instead of the computer's hostname. Fallbacks to `common` remain unchanged.

## update.sh
`update.sh` is a simple script that updates `pkglist.txt` with all installed packages (not including those in `pkgignore.txt`) and prints the diff from the latest commit.

## Disclaimer
These scripts have not been tested on anything but my personal machines. They are much more complicated than they need to be, and they are difficult to configure. I have tried to put failsafes in place but still be careful if you decide to borrow these (for some reason).
