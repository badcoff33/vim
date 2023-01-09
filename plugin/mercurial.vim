command -nargs=+ -complete=file Hg terminal ++curwin hg -v <args>

autocmd BufWinLeave !hg* :bw!

cabbrev hgst Hg status
cabbrev hgci Hg commit -m ""
cabbrev hgla Hg log -r "tip~3:tip"
cabbrev hgls Hg log --limit 6 --template "{node\|short} \| {date\|isodatesec} \| {author\|user}: {desc\|strip\|firstline}\n"
