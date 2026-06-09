set -l conda_bin /opt/homebrew/Caskroom/miniconda/base/bin/conda
set -l conda_fish /opt/homebrew/Caskroom/miniconda/base/etc/fish/conf.d/conda.fish

if test -x "$conda_bin"
    "$conda_bin" shell.fish hook | source
else if test -f "$conda_fish"
    source "$conda_fish"
end
