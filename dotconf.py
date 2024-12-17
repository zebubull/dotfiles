import os
from typing import Set

class DotConf:
    def __init__(self, host: str, installed_packages: Set[str], target_packages: Set[str], dry_run: bool, force: bool):
        """ create a new DotConf context. """
        self.host = host
        self.home = os.getenv("HOME")
        self.dry_run = dry_run
        self.force = force

        self.installed_confs = 0
        self.skipped_confs = 0
        self.failed_confs = 0

        self.current_pkgs = installed_packages
        self.target_pkgs = target_packages

        self.installed_pkgs = 0
        self.skipped_pkgs = 0

    def _home_path(self, path):
        """ prepend the user's home directory to `path` """
        return f"{self.home}/{path}"

    def _link_file(self, name, source, target):
        """ link a `name` from `source` to `target`. if `target` already exists,
            then nothing will be done. during a dry run this will only print changes
            and not execute them. """
        if not self.force and os.path.exists(target):
            print(f"Ignoring {name}: target already exists")
            self.skipped_confs += 1
            return

        source = os.path.abspath(source)

        if self.dry_run:
            print(f"DR: linking {source} to {target}")
            self.installed_confs += 1
            return
        else:
            print(f"linking {source} to {target}")

        try:
            os.symlink(source, target)
            self.installed_confs += 1
        except Exception as e:
            print(f"Failed to install config {name}: {e}")
            self.failed_confs += 1

    def _install_local(self, dir):
        """ install a local (not common) config dir. """
        source = f"{self.host}/{dir}"
        target = self._home_path(f".config/{dir}")
        self._link_file(dir, source, target)

    def _install_shared(self, dir):
        """ install a shared (common) config dir. """
        source = f"common/{dir}"
        target = self._home_path(f".config/{dir}")
        self._link_file(dir, source, target)

    def _local_config_exists(self, dir):
        """ check if local config exists for the given directory. """
        return os.path.exists(f"{self.host}/{dir}")

    def install_directory(self, dir: str):
        """ install the directory `dir`. local config will be used if it exists,
            otherwise common config will be linked. """
        if self._local_config_exists(dir):
            self._install_local(dir)
        else:
            self._install_shared(dir)

    def install_file(self, source: str, target: str):
        """ install a file `source` to `target`. ~ will be replaced with the
            user's home directory. """
        source = source.replace('~', self.home)
        target = target.replace('~', self.home)
        self._link_file(source, source, target)

    def sync_packages(self):
        """ sync the system packages with all packages in .pkglist. """
        to_install = self.target_pkgs
        installed = set()
        if not self.force:
            installed = self.target_pkgs.intersection(self.current_pkgs)
            to_install -= installed

        with open ('/tmp/pkgs.dotconf', 'w') as f:
            f.writelines([pkg + '\n' for pkg in to_install])

        self.skipped_pkgs = len(installed)

        if len(to_install) == 0:
            return

        if self.dry_run:
            for pkg in to_install:
                print(f"DR: installing {pkg}")
        else:
            print("Installing packages with pacman...")
            if os.system("sudo pacman -S - < /tmp/pkgs.dotconf") != 0:
                print("error: failed to sync packages with pacman")
                return

        self.installed_pkgs = len(to_install)

    def print_summary(self):
        """ print a summary of all changes made. """
        print("DotConf Summary:")
        print(f"\t{self.installed_confs} files linked, {self.skipped_confs} files skipped, {self.failed_confs} files failed")
        print(f"\t{self.installed_pkgs} packages installed, {self.skipped_pkgs} packages skipped")

def install(ctx: DotConf):
    """ this function is what actually does the config file linking using
        DotConf.install_directory and DotConf.install_file. """

    # list of all directories to install
    dirs = ["hypr", "mako", "eww", "gtk-3.0",
            "wal", "rofi", "waybar", "helix",
            "kitty", "fish", "fastfetch", "mpd",
            "dotsync"]
    # install each directory
    for dir in dirs:
        ctx.install_directory(dir)

    # list of all files to install, stored as a tuple holding (target, source).
    # note that this is backwards to how the arguments are passed to install_file.
    files = [
        ("~/.config/mpd-notification.conf", "~/.config/dotfiles/mpd-notification/mpd-notification.conf"),
        ("~/.config/eww/colors.scss","~/.cache/wal/colors.scss"),
        ("~/.config/kitty/current-theme.conf","~/.cache/wal/colors-kitty.conf"),
        ("~/.config/hypr/colors-hyprland.conf","~/.cache/wal/colors-hyprland.conf"),
        ("~/.config/mako/config","~/.cache/wal/colors-mako"),
        ("~/.config/rofi/theme.rasi","~/.cache/wal/colors-rofi.rasi"),
        ("~/.local/bin/wallpaper","~/.config/dotfiles/scripts/wallpaper"),
        ("~/.local/bin/updates","~/.config/dotfiles/scripts/updates"),
        ("~/.local/bin/aur","~/.config/dotfiles/scripts/aur"),
        ("~/.local/bin/dotsync","~/.config/dotfiles/dotsync"),
    ]

    for (target, source) in files:
        ctx.install_file(source, target)

    ctx.sync_packages()
    ctx.print_summary()

if __name__ == '__main__':
    print('sync config by running `dotsync sync`')
    exit(1)
