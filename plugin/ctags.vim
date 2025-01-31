vim9script

import autoload "ctags.vim"
import autoload "config.vim" as cfg

g:ctags_cmd = get(g:, "ctags_cmd", "ctags")
g:ctags_options = get(g:, "ctags_options", [ "-R", "." ])

cfg.RegisterVariable("g:ctags_cmd")
cfg.RegisterVariable("g:ctags_options")

augroup GroupeCtags
  autocmd!
  autocmd BufWritePost *.c,*.h     ctags.CtagsUpdate()
  autocmd BufWritePost *.cpp,*.hpp ctags.CtagsUpdate()
augroup END

command! -nargs=0 CtagsForceUpdate ctags.CtagsUpdate({verbose: true, rebuild_sel_list: true})
nnoremap <Leader>T <Cmd>call ctags#Tags()<CR>
nnoremap <Leader>t <Cmd>call ctags#Tags("local")<CR>

defcompile
