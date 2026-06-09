function _gh_issue_list
    gh issue list --json number,title,updatedAt --template '{{tablerow "NUM" "TITLE" "UPDATED"}}{{range .}}{{tablerow .number .title (timeago .updatedAt)}}{{end}}{{tablerender}}'
end
