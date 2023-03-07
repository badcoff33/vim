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

def g:BuildStatusline(): string
    var sl: string

    if exists("g:statusline_winid") && (win_getid() == g:statusline_winid)
        sl =  "%1* %{GetMode()} %*"
    endif

    sl = sl .. " %{GetSearchMode()}%Y%w "
    if v:versionlong >= 9001307
        sl = sl .. "%="
    endif
    sl = sl .. "%{get(b:\, \"unique_name_prefix\"\, \"\")}%t%m"
    sl = sl .. "%="
    sl = sl .. "%{scope#GetScope()}\ %l:%c "

    return sl
enddef

set statusline=%!BuildStatusline()

defcompile
