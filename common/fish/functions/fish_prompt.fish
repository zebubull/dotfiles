#
# Each prompt_draw_* function takes the color of the next prompt chunk as argument 1
#

function prompt_draw_user -d "draw the username part of the prompt"
    echo -s -n (set_color -b cyan black -o) ' ' $USER (set_color normal) (set_color -b cyan white) '@' (set_color black) (prompt_hostname) ' ' (set_color -b $argv[1] cyan) \uE0B0
end

function prompt_draw_cwd -d "draw the cwd part of the prompt"
    echo -s -n (set_color -b green black) ' ' (prompt_pwd) ' ' (set_color -b $argv[1] green) \uE0B0
end

# Argument 2 is the status value to display
function prompt_draw_status -d "draw the prompt status display"
    echo -s -n (set_color -b red black -o) ' ' $argv[2] ' ' (set_color -b $argv[1] red) \uE0B0
end

# Argument 2 is the prompt to draw
function prompt_draw_git -d "draw the prompt git display"
    echo -s -n (set_color -b magenta black -o) ' ' \uE0A0 ' ' $argv[2] ' ' (set_color -b $argv[1] magenta) \uE0B0
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
    else
        set prompt_end_color black
    end

    prompt_draw_user green

    if test $no_git -ne 1
        prompt_draw_cwd magenta
        prompt_draw_git $prompt_end_color $git_prompt
    else
        prompt_draw_cwd $prompt_end_color
    end

    if test $last_status -ne 0
        prompt_draw_status black $last_status
    end
    
    # classic shell prompt for vibes ig
    echo -s -n (set_color normal) ' $ '
end
