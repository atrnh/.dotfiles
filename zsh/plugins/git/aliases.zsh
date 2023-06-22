gcob () {
  git checkout $(git branch | fzf)
}
