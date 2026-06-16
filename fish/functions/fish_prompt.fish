set -g __fish_git_prompt_showdirtystate yes
set -g __fish_git_prompt_showuntrackedfiles yes
set -g __fish_git_prompt_showupstream informative
set -g __fish_git_prompt_use_informative_chars yes
set -g __fish_git_prompt_color_branch brmagenta
set -g __fish_git_prompt_color_dirtystate bryellow
set -g __fish_git_prompt_color_untrackedfiles brred
set -g __fish_git_prompt_char_stateseparator '  '

function fish_prompt
    set -l last_status $status

    set_color brblack
    printf ' %s ' $USER

    set_color --bold blue
    printf '%s' (prompt_pwd)

    set -l vcs (fish_git_prompt " • %s")
    if test -n "$vcs"
        set_color normal
        printf '%s' $vcs
    end

    printf '\n'

    if test $last_status -eq 0
        set_color magenta
        printf '> '
    else
        set_color red
        printf '%s > ' $last_status
    end

    set_color normal
end