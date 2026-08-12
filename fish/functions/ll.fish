function ll
  if command -q eza
    eza --git -l --no-user --color always --icons -a -s type $argv
  else
    command ll $argv
  end
end