vim9script

g:scope_in_statusline = false
g:statusline_search_mode = ""

g:mode_translation = {
  "n": "NORM",
  "v": "VIS",
  "V": "V·LINE",
  "\<C-V>": "V·BLOCK",
  "i": "INS",
  "r": "PROMPT",
  "R": "R",
  "Rv": "V·Replace",
  "c": "CMD",
  "t": "TERM"
}
def GetSearchMode(): string
  if &ignorecase && !&smartcase
    return "/ignore"
  elseif !&ignorecase && !&smartcase
    return "/case"
  elseif &ignorecase && &smartcase
    return "/smart"
  endif
  return ""
enddef

def g:GetMode(): string
  var m = mode()
  if has_key(g:mode_translation, m)
    m = g:mode_translation[m]
    if m == "CMD"
      m ..= g:statusline_search_mode
    endif
  endif
  return m
enddef

def IsOption(opt: string): bool
  if getbufvar("%", "&" .. opt) == true
   return true
  else
   return false
  endif
enddef

def g:GetScopeforSL(): string
  var scope: string
  if exists('g:scope_in_statusline') && (g:scope_in_statusline == true)
    scope = scope#GetScope()
    if len(scope) == 0
      return ''
    else
      return ',' .. scope
    endif
  else
    return ''
  endif
enddef

def g:BuildStatusline(): string
    var sl: string
    if exists("g:statusline_winid") && (win_getid() == g:statusline_winid)
        sl = sl .. "%1* %{GetMode()} "
    endif
    sl = sl .. "%2*" .. (len(v:errors) > 0 ? ",!" : "")
    sl = sl .. " %{get(b:\, 'vcs_status'\, '')}%{get(b:\, 'vcs_branch_name'\, '')}"
    if v:versionlong >= 9001307
        sl = sl .. "%="
    endif
    sl = sl .. " %0*%{get(b:\, 'unique_name_prefix'\, '')}%t%M%R"
    sl = sl .. " %{GetScopeforSL()}"
    sl = sl .. " %=%1*%Y%W %l:%c "
    return sl
enddef

set statusline=%!BuildStatusline()

augroup GroupStatusline
  au!
  au CmdlineEnter / g:statusline_search_mode = GetSearchMode()
  au CmdlineEnter : g:statusline_search_mode = ""
  au BufEnter * nnoremap <buffer> <LocalLeader>? <Cmd>let g:scope_in_statusline = g:scope_in_statusline ? v:false : v:true<CR>
augroup END

command -nargs=0 ShowScopeToggle {
  if exists('g:scope_in_statusline') && (g:scope_in_statusline == true)
    g:scope_in_statusline = false
  else
    g:scope_in_statusline = true
  endif
}

defcompile
