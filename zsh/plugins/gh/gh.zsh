if [ "$(command -v gh)" ]; then
  ghpr() {
    gh pr view -w $@
  }
fi
