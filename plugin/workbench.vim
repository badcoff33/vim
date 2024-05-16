vim9script
# File plugin for C
#
# Description: Workbench contain things to ease working in projects. is a project
#
# - Automaticalls update Ctags files after a buffer write.
# - Run Ripgrep
# - Run Make
#
# Maintainer: markus prepens (markus dot prepens at gmail dot com)

import autoload "run.vim"
import autoload "ctags.vim"
import autoload "popnews.vim"
import autoload "torchlight.vim"
import autoload "filter_menu.vim"


g:ctags_command         = "ctags -R ."
g:ctags_options         = ""
g:rg_command            = "rg"
g:rg_excludes           = get(g:, "rg_excludes", [])
g:rg_paths              = get(g:, "rg_paths", ".")
g:rg_option_all         = get(g:, "rg_option_all", false)
g:rg_find_files_options = get(g:, "rg_find_files_options", "-u")
g:rg_dict               = {}

var ctags_job: job
var rg_glob_patterns = {
  c:      ['*.c', '*.h', '*.850', '*.s'],
  cpp:    ['*.c', '*.h', '*.850', '*.s', '*.cc', '*.hh'],
  vim:    ['*.vim', '*vimrc'],
  asm:    ['*.850', '*.s'],
  py:     ['*.py'],
  cmake:  ['*.cmake', 'CmakeLists.txt']
}

def ToString(obj: any): string
  var toStr: string
  if type(obj) == v:t_string
    return obj
  elseif type(obj) == v:t_list
    return join(obj, " ")
  else
    popnews.Open("unknown type of 'g:ctags_options'", 4000, "ErrorMsg")
    return ""
  endif
enddef

def MakeCallback()
  torchlight.TorchlightUpdate()
enddef

def MakeStart(cmd: string)
  torchlight.TorchlightClearAll()
  run.RunStart({
    cmd: &makeprg .. " " .. cmd,
    callback: MakeCallback
  })
enddef

def g:CtagsTriggerUpdate(verbose = false)
  var ctags_options: string

  if job_status(ctags_job) == "run"
    return
  endif

    ctags_options = ToString(g:ctags_options)

  ctags_job = run.RunStart({cmd: 'ctags ' .. ctags_options, background: true})
  if job_status(ctags_job) != "run"
    popnews.Open("check ctags options", 4000, "ErrorMsg")
  elseif verbose == true
    popnews.Open('ctags ' .. ctags_options, 3000)
  endif
enddef

def g:RgPatternInput()
  var pattern = len(expand("<cword>")) == 0 ? "STRING" : expand("<cword>")
  execute join( [":Rg", g:RgExcludes(), g:RgIncludes(), input("Pattern (use '\\bPATTERN\\b' for exact matches'): ", pattern, "tag"), ToString(g:rg_paths) ], " ")
enddef

def g:RgPattern(): string
    return len(expand("<cword>")) == 0 ? "STRING" : '\b' .. expand("<cword>") .. '\b'
enddef

def g:RgPrettyPrint()
  for e in getqflist({ "nr": "$", "all": 0 }).items
    var temp: list<number>
    if has_key(g:rg_dict, e.bufnr)
      temp = g:rg_dict[e.bufnr]
    else
      temp = []
    endif
    add(temp, e.lnum)
    g:rg_dict[e.bufnr] = temp
  endfor
enddef

def g:RgIncludes(): string
  var include_string: string
  if g:rg_option_all == true
    include_string = g:RgGlobSwitch("*")
  else
    if has_key(rg_glob_patterns, &ft)
      for e in rg_glob_patterns[&ft]
        include_string = include_string .. g:RgGlobSwitch(e) .. " "
      endfor
    endif
  endif
  return include_string
enddef

def g:RgExcludes(): string
  var exclude_string = ""
  for e in g:rg_excludes
    exclude_string = exclude_string .. RgGlobSwitchExclude(e) .. " "
  endfor
  return exclude_string
enddef

def RgGlobSwitchExclude(anti_pattern: string): string
  if has("unix")
    return "-g !" .. anti_pattern
  else
    return "--iglob !" .. anti_pattern
  endif
enddef

def g:RgGlobSwitch(pattern: string): string
  if has("unix")
    return "-g " .. pattern
  else
    return "--iglob " .. pattern
  endif
enddef

def g:WbConfig()
  echo printf("g:ctags_command\t= %s", g:ctags_command)
  echo printf("g:ctags_options\t= %s", ToString(g:ctags_options))
  echo printf("g:rg_command\t= %s", g:rg_command)
  echo printf("g:rg_paths\t= %s", join(g:rg_paths, ", "))
  echo printf("g:rg_excludes\t= %s", join(g:rg_excludes, ", "))
  echo printf("g:rg_option_all\t= %s", g:rg_option_all)
enddef

# filter and open buffers
def g:SelectBuf()
  filter_menu.FilterMenu("Buffers",
    getbufinfo({'buflisted': 1})->mapnew((_, v) => {
      return {bufnr: v.bufnr, text: (v.name ?? $'[{v.bufnr}: No Name]')}
    }),
    (res, key) => {
      if key == "\<c-t>"
        exe $":tab sb {res.bufnr}"
      elseif key == "\<c-w>"
        exe $":bwipeout {res.bufnr}"
        g:SelectBuf()
      else
        exe $":b {res.bufnr}"
      endif
    })
  echo "EE"
enddef

var FileSig = (fn) => substitute(fn, "[\\\\/]", "", "g") # get rid of the slash problem

# works with tag file an relative file paths.
# Restrictions: No etags support or with line  numbers
def g:SelectTags()
  if empty(findfile('tags', expand('%:p') .. ';'))
    return
  endif
  var fsig = substitute(FileSig(expand('%:p')), FileSig(getcwd()), '', '') # make file relative as ctags files names
  var buf_tag_dict = filter(taglist('.'), (key, val) => FileSig(val['filename']) =~ fsig)
  filter_menu.FilterMenu("Tags",
    mapnew(buf_tag_dict, (key, val) => val['name']),
    (res, key) => {
      var cmd = filter(buf_tag_dict, 'v:val["name"] == "' .. res.text .. '"')[0]['cmd']
      execute ":" .. escape(cmd, '*')
    })
enddef

# filter and open MRU (Most Recently Used) aka oldfiles
def g:SelectFiles()
  filter_menu.FilterMenu("MRU",
    split(system('rg --files -g * .'), '\n'),
    (res, key) => {
    if key == "\<c-t>"
      exe $":tab sb {res.bufnr}"
    else
      exe $":e {res.text}"
    endif
  })
enddef

augroup GroupeWorkbench
  autocmd!
  autocmd BufWritePost *.c,*.h g:CtagsTriggerUpdate()
  autocmd BufWritePost *.cpp,*.hpp g:CtagsTriggerUpdate()
augroup END

if executable("rg")
  # Using links? Ripgrep supports this by the option '--follow'
  set grepprg=rg\ --vimgrep\ $*
  set grepformat=%f:%l:%c:%m
  command!                -nargs=0 WbConfig g:WbConfig()
  command! -complete=file -nargs=* RgFindFiles run.RunStart({cmd: g:rg_command .. " --files " .. g:rg_find_files_options .. " " .. g:RgGlobSwitch('<args>'), name: "RgFiles"})
  command! -complete=file -nargs=* Rg run.RunStart({cmd: g:rg_command .. ' --vimgrep ' .. ' <args>', regexp: &grepformat, no_popup: true})
endif
command! -nargs=0                CtagsForceUpdate g:CtagsTriggerUpdate(true)
command! -nargs=* -complete=file                  Make MakeStart(<q-args>)

nnoremap <Leader>m :<C-u>Make<Up>
nnoremap <Leader>b <Cmd>call SelectBuf()<CR>
nnoremap <Leader>t <Cmd>call SelectTags()<CR>
nnoremap <Leader>f <Cmd>call SelectFiles()<CR>
if executable("rg")
  nnoremap <Leader><CR> :call g:RgPatternInput()<CR>
  nnoremap <silent> <Leader><Leader> :<C-r>=join([":Rg", g:RgExcludes(), g:RgIncludes(), g:RgPattern(), ToString(g:rg_paths), " ")<CR><CR>
endif

defcompile
