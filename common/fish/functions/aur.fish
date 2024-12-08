#!/usr/bin/env fish

function __aur --description "A bundle of AUR related tools"
    if test (count $argv) -eq 0
        __aur_print_usage
        return 1
    end

    if test $argv[1] = check
        __aur_check
    else if test $argv[1] = search
        __aur_search $argv[2..]
    else if test $argv[1] = get
        __aur_get $argv[2..]
    else if test $argv[1] = update
        __aur_update $argv[2..]
    else if test $argv[1] = help
        __aur_print_usage
        return 1
    else
        __aur_print_usage
        return 1
    end
end

function __aur_print_usage
    echo "Usage: aur [subcommand]"
    echo ""
    echo "Subcommands:"
    echo "  check:  check for out-of-date packages from the AUR"
    echo "  get:    install a package from the AUR"
    echo "  help:   print this message"
    echo "  search: search for a package on the AUR"
    echo "  update: update an installed package from the AUR"
    return 1
end

function __aur_check
    # Arrays for currently installed package versions
    set -l names
    set -l old_vers

    # Loop over all aur packages
    for pkg in (pacman -Qm)
        # Ignore -debug packages
        if test (string match -r debug $pkg)
            continue
        end

        # Extract name and version info
        set -a names (string split " " $pkg)[1]
        set -a old_vers (string split " " $pkg)[2]
    end

    # Get info of all packages in order
    set -l json (curl "https://aur.archlinux.org/rpc/v5/info?arg[]=$(string join \&arg[]= $names)" 2>/dev/null)

    # Validate response
    if not __aur_response_validate $json
        return 1
    end

    # Extract versions
    set -l new_vers (__aur_parse_versions $json)

    # Make sure we got exactly one entry for each package
    if test (count $new_vers) -ne (count $names)
        echo "Failed to get versions of all aur packages"
        return 1
    end

    set -l outdated 0
    for i in (seq (count $names))
        # Ignore up-to-date packages
        if test $old_vers[$i] = $new_vers[$i]
            continue
        end

        # Print and count each out of date package
        echo -s $names[$i] " " $old_vers[$i] "->" $new_vers[$i]
        set outdated (math $outdated + 1)
    end

    # Fail if all packages are up to date
    if test $outdated -eq 0
        return 1
    end
end

function __aur_search
    # Search for package
    set -l json (curl "https://aur.archlinux.org/rpc/v5/search/$argv" 2>/dev/null)

    # Validate response
    if not __aur_response_validate $json
        return 1
    end

    # Parse out the name and description for each result
    set -l names (echo $json | jq -r '.results | .[] | .Name')
    set -l descs (echo $json | jq -r '.results | .[] | .Description')
    set -l vers (__aur_parse_versions $json)

    # Return 1 if there were no results
    if test (count $names) -eq 0
        return 1
    end

    # Print out each result
    for i in (seq (count $names))
        echo -s $names[$i] - $vers[$i] ":"
        echo -s \t $descs[$i]
    end
end

function __aur_get
    # Make sure the package exists by running an info query for it
    set -l json (curl "https://aur.archlinux.org/rpc/v5/info?arg[]=$argv" 2>/dev/null)

    # Validate response
    if not __aur_response_validate $json
        return 1
    end

    set -l vers (__aur_parse_versions $json)

    if pacman -Qm | string match -rq "$argv .*"
        echo package $argv "will be reinstalled"
    end

    if not __aur_confirm_install $argv $vers
        return 1
    end

    __aur_install_package $argv
end

function __aur_update
    # Get the current package info
    echo "checking installed packages..."
    set -l pkg (pacman -Qm | string match -r "$argv .*" | string match -rv debug)
    set -l name (string split " " $pkg)[1]
    set -l old_ver (string split " " $pkg)[2]

    # Make sure the package we found matches the name provided
    if not test $name = $argv
        echo package $argv "is not installed or is not an AUR package"
        return 1
    end

    # Get the package info
    echo -s "checking remote package " $name "..."
    set -l json (curl "https://aur.archlinux.org/rpc/v5/info?arg[]=$argv" 2>/dev/null)

    # Validate response
    if not __aur_response_validate $json
        return 1
    end

    # Extract version
    set -l new_ver (echo $json | jq -r '.results | .[] | .Version')

    # Make sure there's really an update
    if test $new_ver = $old_ver
        echo package $name "is already on latest version" $new_ver
        return 1
    end

    echo -s "found update "$argv " " $old_ver "->" $new_ver

    # Confirm the install and then update
    if not __aur_confirm_install $argv $new_ver
        return 1
    end

    __aur_install_package $argv
end

function __aur_install_package
    pushd .
    cd ~/.aur
    if test -e $argv
        echo "pulling latest changes from https://aur.archlinux.org/$argv.git..."
        cd $argv
        git fetch
        git merge
        echo "removing old build artifacts..."
        rm *.pkg.tar.zst
    else
        echo "fetching package from https://aur.archlinux.org/$argv.git"
        git clone "https://aur.archlinux.org/$argv.git"
        cd $argv
    end

    makepkg -sf
    sudo pacman -U --noconfirm *.pkg.tar.zst
    popd
end

function __aur_response_validate
    set type (echo $argv[1] | jq -r '.type')
    if test $type = error
        echo "Got error response from AUR"
        return 1
    else
        return 0
    end
end

function __aur_parse_versions
    echo $argv | jq -r '.results | .[] | .Version'
end

function __aur_confirm_install
    # This is really stupid but it looks fancy and is probably mostly accurate (no source)
    echo ""
    echo -s "Packages (2) " $argv[1] - $argv[2] "  " $argv[1] -debug- $argv[2]
    echo ""

    if not __aur_read_confirm
        echo "cancelling installation process..."
        return 1
    end

    return 0
end

function __aur_read_confirm
    while true
        read -l -P ':: Proceed with installation? [Y/n] ' confirm

        switch $confirm
            case N n
                return 1
            case '' Y y
                return 0
        end
    end
end
