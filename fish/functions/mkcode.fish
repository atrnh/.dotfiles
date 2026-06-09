function mkcode
    set -l target $argv[1]
    if test -z "$target"
        set target $PWD
    end

    mkdir -p "$target/starter/"(basename "$target")
    mkdir -p "$target/solution/"(basename "$target")
    echo 'Successfully created:'
    tree -L3 "$target"
end
