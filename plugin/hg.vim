command! -complete=file -nargs=+ Hg call run#Run(#{cmd: 'hg <args>', regexp: '%m'})
command! -nargs=0 HgStatus call run#Run(#{cmd: 'hg status', regexp: '%m'})
command! -nargs=0 HgLast3 call run#Run(#{cmd: 'hg log -r "tip~3:tip"<CR>', regexp: '%m'})
command! -nargs=0 HgList call run#Run(#{cmd: 'hg log --limit 6 --template "{node|short} | {date|isodatesec} | {author|user}: {desc|strip|firstline}\n"', regexp: '%m'})
