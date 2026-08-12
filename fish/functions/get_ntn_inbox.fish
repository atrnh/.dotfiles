function get_ntn_inbox
  set -g __note_inbox_page_id "38224a04-d037-8085-badd-f61bdd24c0bd"

  if not command -q ntn
    echo 'get_ntn_inbox: notion is not installed' >&2
    return 127
  end

  ntn pages get $__note_inbox_page_id | bat -l markdown
end