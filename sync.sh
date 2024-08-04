#!/bin/bash

system=$1

if [[ -z $1 ]]; then
    system=$(uname -n)
    echo "No system name was provided, using hostname '$system'"
fi

if [[ ! -d "$system" ]]; then
    echo "No configuration for system '$system' found"
    exit 1
fi

dcount=0
dskipped=0

fcount=0
fskipped=0

link_dir() {
	local target=$HOME/.config/$1
    local source="$PWD/common/$1"
    if [[ -d "$PWD/$system/$1" ]]; then
        echo "Using system config ($system) for $1"
        source="$PWD/$system/$1"
    fi

    if [[ -L "$target" ]]; then
        local link=$(readlink -f $target)
        if [[ $link != $source ]]; then
            echo "Link to $target is $link, updating to $source."
        else
            echo "Link to $target already exists, skipping."
            dskipped=$((dskipped+1))
            return
        fi
    fi

	if [[ -f "$target" ]]; then
		echo "Config for $target already exists, skipping."
		dskipped=$((dskipped+1))
		return
	fi

	ln -sfn "$source" "$target"
	echo "Installed $target"
	dcount=$((dcount+1))
	return
}

link_file() {
    if [[ -L "$2" ]]; then
        echo "Link to $2 (from $1) already exists, skipping."
        fskipped=$((fskipped+1))
        return
    fi
    if [[ -f "$2" ]]; then
        echo "File $2 (from $1) already exists, skipping."
        fskipped=$((fskipped+1))
        return
    fi
    # in case we copy to /etc
     sudo ln -s "$1" "$2"
    echo "Installed $2 (from $1)"
    fcount=$((fcount+1))
}

config_dirs=(
	# desktop stuff
	"hypr" "mako" "eww" "gtk-3.0" "wal" "rofi"
	# editor
	"nvim" # "nvim-scheme"
    # term
    "kitty" "fish"
    # misc
    "neofetch" "mpd"
)

config_files=(
    "/etc/pacman.d/hooks/pkglist.hook,$HOME/.config/dotfiles/pacman/pkglist.hook"
    "$HOME/.config/mpd-notification.conf,$HOME/.config/dotfiles/mpd-notification/mpd-notification.conf"
    "$HOME/.config/eww/colors.scss,$HOME/.cache/wal/colors.scss"
    "$HOME/.config/kitty/current-theme.conf,$HOME/.cache/wal/colors-kitty.conf"
    "$HOME/.config/hypr/colors-hyprland.conf,$HOME/.cache/wal/colors-hyprland.conf"
    "$HOME/.config/mako/config,$HOME/.cache/wal/colors-mako"
    "$HOME/.config/rofi/config.rasi,$HOME/.cache/wal/colors-rofi-dark.rasi"
    "$HOME/.local/bin/wallpaper,$HOME/.config/dotfiles/scripts/wallpaper"
)

mkdir -p "/etc/pacman.d/hooks"
mkdir -p "$HOME/.local/bin"

for target in ${config_dirs[@]}; do
	link_dir "$target"
done

for target in ${config_files[@]}; do
    IFS=',' read -ra split <<< "$target"
    in=${split[1]}
    out=${split[0]}
    link_file "$in" "$out"
done

if ! [[ -f "pkgignore.txt" ]]; then
    echo "File 'pkgignore.txt' not found, creating."
    touch pkgignore.txt
fi

if [[ -f "/etc/pkglist.txt" && -f "./pkglist.txt" ]]; then
    cat /etc/pkglist.txt | grep --color=never -v -x -f pkgignore.txt > /tmp/current-packages.txt
    if cmp -s "./pkglist.txt" "/tmp/current-packages.txt"; then
        echo "Package list is up-to-date."
    elif [[ "./pkglist.txt" -nt "/etc/pkglist.txt" ]]; then
        echo "./pkglist.txt is newer, updating packages."
        sudo pacman -S --needed - < pkglist.txt
        echo "Installed packages not in package list:"
        git -P diff --no-index -U0 -- pkglist.txt /etc/pkglist.txt | grep --color=always '^[+-][^+-]\S*' | grep -v -f pkgignore.txt
    else
        echo "/etc/pkglist.txt is newer, updating ./pkglist.txt."
        echo "Added packages:"
        git -P diff --no-index -U0 -- pkglist.txt /etc/pkglist.txt | grep --color=always '^[+-][^+-]\S*' | grep -v -f pkgignore.txt
        cat /etc/pkglist.txt | grep --color=never -v -x -f pkgignore.txt > pkglist.txt
    fi

else
    if [[ -f "/etc/pkglist.txt" ]]; then
        echo "Generating ./pkglist.txt"
        cat /etc/pkglist.txt | grep --color=never -v -x -f pkgignore.txt > pkglist.txt
    else
        echo "Generating /etc/pkglist.txt"
        sudo pacman -Qqen > /etc/pkglist.txt
    fi

    if [[ -f "./pkglist.txt" ]]; then
        echo "Installing packages from ./pkglist.txt"
        sudo pacman -S --needed - < pkglist.txt
    fi
fi

echo "$dcount dirs installed, $dskipped skipped."
echo "$fcount files installed, $fskipped skipped."
echo "Done."
