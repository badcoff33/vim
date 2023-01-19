" Vim plugin files

augroup statusline
  au!
  au BufWinEnter,WinEnter * call unique#UpdateUniqueName()
augroup END

let g:currentmode={
       \ 'n'  : 'NORMAL',
       \ 'v'  : 'VISUAL',
       \ 'V'  : 'V·Line',
       \ "\<C-V>" : 'V·Block',
       \ 'i'  : 'INSERT',
       \ 'R'  : 'R',
       \ 'Rv' : 'V·Replace',
       \ 'c'  : 'Command',
       \}

function BuildStatusline()
    let sl = ""
    if win_getid() == g:statusline_winid
        let sl  .= "%1*%{toupper(g:currentmode[mode()])}%* "
    endif
    let sl .= "%{unique#GetUniqueName()}%t"
    let sl .= " %M%Y%w%{GetSearchMode()}"
    let sl .= "%="
    let sl .= "%{scope#GetScope()}\ %l:%c "
    let g:copy = sl
    return sl
endfunction
set statusline=%!BuildStatusline()

function! GetSearchMode()
  if &ignorecase == 1 && &smartcase == 1
    return ',sc'
  elseif &ignorecase == 0
    return ',cs'
  else
    return ',ic'
  endif
endfunction

