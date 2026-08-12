function ovl --description 'Append a bulleted item to today\'s Obsidian daily note'
    if test (count $argv) -eq 0
        echo 'Usage: ovl <text>' >&2
        return 2
    end

    if not command -q obsidian
        echo 'ovl: obsidian CLI is not installed' >&2
        return 127
    end

    set -l text (string join ' ' -- $argv)
    set -l daily_note "Daily/"(date +%Y-%m-%d)".md"

    if not obsidian file path="$daily_note" >/dev/null 2>&1
        obsidian templater:create-from-template template=Templates/daily.md file="$daily_note"
        or return
    end

    obsidian append path="$daily_note" content="- $text"
end
