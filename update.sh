
if [[ -f "/etc/pkglist.txt" && -f "./pkglist.txt" ]]; then
    cat /etc/pkglist.txt | grep --color=never -v -x -f pkgignore.txt > /tmp/current-packages.txt
    if cmp -s "./pkglist.txt" "/tmp/current-packages.txt"; then
        echo "Package list is up-to-date."
    elif [[ "./pkglist.txt" -nt "/etc/pkglist.txt" && $1 != "-f" ]]; then
        echo "./pkglist.txt is newer, run ./sync.sh to sync your system or run ./update.sh -f to force an update."
    else
        if [[ $1 == "-f" ]]; then
            echo "[WARNING]: Force updating ./pkglist.txt, unsynced packages will be removed."
        else
            echo "/etc/pkglist.txt is newer, updating ./pkglist.txt."
        fi
        echo "Added packages:"
        git -P diff --no-index -U0 -- pkglist.txt /etc/pkglist.txt | grep --color=always '^[+-][^+-]\S*' | grep -v -f pkgignore.txt
        cat /etc/pkglist.txt | grep --color=never -v -x -f pkgignore.txt > pkglist.txt
        echo "Done."
    fi
else
    echo "Run ./sync.sh to bootstrap your system."
fi
