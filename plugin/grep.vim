vim9script

import autoload "grep.vim"
import autoload "config.vim" as cfg

g:grep_backend = "ripgrep"

if g:grep_backend == "grep"
  g:grep_cmd = get(g:, "grep_cmd", "grep")
  g:grep_options = get(g:, "grep_options", ["-Hnr"])
  g:grep_excludes = get(g:, "grep_excludes", [])
  g:grep_paths = get(g:, "grep_paths", ["."])
  g:grep_for_all = get(g:, "grep_for_all", ["false"])
endif

if g:grep_backend == "ripgrep"
  g:grep_cmd = get(g:, "grep_cmd", "rg")
  g:grep_options = get(g:, "grep_options", ["--vimgrep"])
  g:grep_excludes = get(g:, "grep_excludes", [])
  g:grep_paths = get(g:, "grep_paths", ["."])
  g:grep_for_all = get(g:, "grep_for_all", ["false"])
endif

cfg.RegisterVariable("g:grep_cmd")
cfg.RegisterVariable("g:grep_options")
cfg.RegisterVariable("g:grep_excludes")
cfg.RegisterVariable("g:grep_paths")
cfg.RegisterVariable("g:grep_for_all")

set grepprg=grep\ $*
set grepformat=%f:%l:%m

nnoremap <Leader>G :call grep#GrepPatternInput()<CR>
nnoremap <silent> <Leader>g :call grep#RunCompiledCmdLine("<C-r><C-w>")<CR>

defcompile

