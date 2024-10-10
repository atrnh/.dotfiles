if [ "$(command -v gh)" ]; then
  ghpr() {
    gh pr view -w $@
  }

  create-issue() {
    gh issue create -e $@
  }
fi
