function cat --wraps cat
    if test (count $argv) -gt 0; and string match -qri '\.(gif|jpe?g|png)$' -- $argv[1]; and command -q wezterm
        wezterm imgcat $argv
    else if command -q bat
        bat $argv
    else
        command cat $argv
    end
end
