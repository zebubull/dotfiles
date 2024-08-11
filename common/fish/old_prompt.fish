#
# Each prompt_draw_* function takes the color of the next prompt chunk as argument 1
#

function prompt_draw_tip
    if test $argv[1] -ne 0
        echo -s -n \u25D7
    else
        echo -s -n \uE0B0
    end
end

function prompt_draw_user -d "draw the username part of the prompt"
    echo -s -n (set_color cyan) \u25D6 (set_color -b cyan black -o) ' ' $USER (set_color normal) (set_color -b cyan white) '@' (set_color black) (prompt_hostname) ' ' (set_color -b $argv[1] cyan)
    # echo -s -n (set_color cyan) \u25D6 (set_color -b cyan black -o) ' ' $USER ' ' (set_color -b $argv[1] cyan)
    prompt_draw_tip 0
end

function prompt_draw_cwd -d "draw the cwd part of the prompt"
    echo -s -n (set_color -b green black) ' ' (prompt_pwd) ' ' (set_color -b $argv[1] green)
    prompt_draw_tip $argv[2]
end

# Argument 2 is the status value to display
function prompt_draw_status -d "draw the prompt status display"
    echo -s -n (set_color -b red black -o) ' ' $argv[2] ' ' (set_color -b $argv[1] red)
    prompt_draw_tip $argv[3]
end

# Argument 2 is the prompt to draw
function prompt_draw_git -d "draw the prompt git display"
    echo -s -n (set_color -b magenta black -o) ' ' \uE0A0 ' ' $argv[2] ' ' (set_color -b $argv[1] magenta)
    prompt_draw_tip $argv[3]
end

function fish_prompt
    # Save the status
    set -l last_status $status

    # Config options for fish_git_prompt
    set -g __fish_git_prompt_showupstream informative
    set -g __fish_git_prompt_showdirtystate 1

    # Get the prompt text
    set -l git_prompt (fish_git_prompt '%s')
    # fish_git_prompt returns 1 if not in a git directory
    set -l no_git $status

    # probably a better way to handle this but prompt_end_color is just the prompt color after cwd or git if it exists
    if test $last_status -ne 0
        set prompt_end_color red
        set no_status 0
    else
        set prompt_end_color black
        set no_status 1
    end

    prompt_draw_user green

    if test $no_git -ne 1
        prompt_draw_cwd magenta 0
        prompt_draw_git $prompt_end_color $git_prompt $no_status
    else
        prompt_draw_cwd $prompt_end_color $no_status
    end

    if test $last_status -ne 0
        prompt_draw_status black $last_status 1
    end

    # classic shell prompt for vibes ig
    echo -s -n (set_color normal) ' $ '
end

function fish_right_prompt -d "Write out the right prompt"
    date '+%I:%M:%S'
end
