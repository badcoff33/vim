vim9script

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

def g:GetMode(): string
    var m = mode()
    if has_key(g:mode_translation, m)
        return g:mode_translation[m]
    endif
    return m
enddef

def g:GetSearchMode(): string
  if &ignorecase == true && &smartcase == true
    return 'sc'
  elseif &ignorecase == false
    return 'cs'
  else
    return 'ic'
  endif
enddef

def g:GetScopeforSL(): string
  var scope: string
  if exists('b:scope_in_statusline') && b:scope_in_statusline
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
        sl =  " %{GetSearchMode()}" .. " %{GetMode()} "
    endif
    sl = sl .. " %Y%R%M"
    sl = sl .. (len(v:errors) > 0 ? ",!" : "")
    sl = sl .. "%{g:GetScopeforSL()}"
    if v:versionlong >= 9001307
        sl = sl .. "%="
    endif
    sl = sl .. "%{get(b:\, \"unique_name_prefix\"\, \"\")}%t%w"
    sl = sl .. "%= %l(%L):%c "
    return sl
enddef

set statusline=%!BuildStatusline()

defcompile
