#!/bin/bash

if [[ -z $1 ]]; then
    echo "No system name was provided"
    echo "Usage: sync.sh [system name]"
    exit 1
elif [[ ! -d $1 ]]; then
    echo "No configuration for system '$1' found"
    exit 1
fi

dcount=0
dskipped=0

fcount=0
fskipped=0

link_dir() {
	local target=$HOME/.config/$1
    if [[ -L "$target" ]]; then
		echo "Link to $target already exists, skipping."
		dskipped=$((dskipped+1))
		return
    fi
	if [[ -f "$target" ]]; then
		echo "Config for $target already exists, skipping."
		dskipped=$((dskipped+1))
		return
	fi
	ln -s "$PWD/$1" "$target"
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
    sudo ln -s "$PWD/$1" "$2"
    echo "Installed $2 (from $1)"
    fcount=$((fcount+1))
}

config_dirs=(
	# desktop stuff
	"hypr" "mako" "eww"
	# editor
	"nvim" "nvim-scheme"
    # term
    "kitty" "fish"
    # misc
    "neofetch" "mpd"
)

config_files=(
    "/etc/pacman.d/hooks/pkglist.hook,pacman/pkglist.hook"
    "$HOME/.config/mpd-notification.conf,mpd-notification/mpd-notification.conf"
)

for target in ${config_dirs[@]}; do
	link_dir "$target"
done

for target in ${config_files[@]}; do
    IFS=',' read -ra split <<< "$target"
    in=${split[1]}
    out=${split[0]}
    link_file "$in" "$out"
done

shopt -s globstar

for target in $1/**/*; do
    if [[ -f $target ]]; then
        link_file "$target" "$HOME/.config/${target#$1/}"
    fi
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
