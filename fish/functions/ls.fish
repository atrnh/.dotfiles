function ls
  if command -q eza
    eza -G --color always --icons -a -s type $argv
  else
    command ls $argv
  end
end