function fish_prompt -d "Write out the prompt"
    set -l last_status $status
    set -l stat
    if test $last_status -ne 0
        set stat (set_color red)"[$last_status]"(set_color normal)
    end
    string join '' -- (set_color -o brblue) $USER "@" $hostname " "(set_color -o green) (prompt_pwd) (set_color normal) $stat (fish_git_prompt) (set_color cyan)'> ' (set_color normal)
end
