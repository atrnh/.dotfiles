function mkdemo
    set -l target $argv[1]
    if test -z "$target"
        set target $PWD
    end

    mkdir "$target/"(basename "$target")-demo
    echo 'Successfully created:'
    tree -L3 "$target"
end
