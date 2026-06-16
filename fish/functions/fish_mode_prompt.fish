function fish_mode_prompt
    switch $fish_bind_mode
        case default
            set_color --bold magenta
            echo -n ' '
        case insert
            set_color --bold green
            echo -n ' '
        case replace_one replace
            set_color --bold yellow
            echo -n ' '
        case visual
            set_color --bold cyan
            echo -n '󰫣 '
        case '*'
            set_color --bold red
            echo -n '󰓑 '
    end

    set_color normal
end
