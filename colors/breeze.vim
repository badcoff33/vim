" Vim color theme
"
" Description: A light one with fresh colors.

if exists("syntax_on")
  syntax reset
endif

hi clear
set background=light
let g:colors_name = "breeze"

function! s:Hi(group, guifg, guibg, attr, guisp)
  if a:guifg != ''
    exec 'hi ' . a:group . ' guifg=' . a:guifg
  endif
  if a:guibg != ''
    exec 'hi ' . a:group . ' guibg=' . a:guibg
  endif
  if a:attr != ''
    exec 'hi ' . a:group . ' gui=' . a:attr
  endif
  if a:guisp != ''
    exec 'hi ' . a:group . ' guisp=' . a:guisp
  endif
endfunction

let s:black = "#1b1f23"
let s:white = "#ffffff"

" -------- Grays --------
let s:gray_9 = "#fafbfc"
let s:gray_8 = "#f6f8fa"
let s:gray_7 = "#e1e4e8"
let s:gray_6 = "#d1d5da"
let s:gray_5 = "#959da5"
let s:gray_4 = "#6a737d"
let s:gray_3 = "#586069"
let s:gray_2 = "#444d56"
let s:gray_1 = "#2f363d"
let s:gray_0 = "#24292e"

" -------- Blue --------
let s:blue_9 = "#f1f8ff"
let s:blue_8 = "#dbedff"
let s:blue_7 = "#c8e1ff"
let s:blue_6 = "#79b8ff"
let s:blue_5 = "#2188ff"
let s:blue_4 = "#0366d6"
let s:blue_3 = "#005cc5"
let s:blue_2 = "#044289"
let s:blue_1 = "#032f62"
let s:blue_0 = "#05264c"

" -------- Green --------
let s:green_9 = "#f0fff4"
let s:green_8 = "#dcffe4"
let s:green_7 = "#bef5cb"
let s:green_6 = "#85e89d"
let s:green_5 = "#34d058"
let s:green_4 = "#28a745"
let s:green_3 = "#22863a"
let s:green_2 = "#176f2c"
let s:green_1 = "#165c26"
let s:green_0 = "#144620"

" -------- Yellow --------
let s:yellow_9 = "#fffdef"
let s:yellow_8 = "#fffbdd"
let s:yellow_7 = "#fff5b1"
let s:yellow_6 = "#ffea7f"
let s:yellow_5 = "#ffdf5d"
let s:yellow_4 = "#ffd33d"
let s:yellow_3 = "#f9c513"
let s:yellow_2 = "#dbab09"
let s:yellow_1 = "#b08800"
let s:yellow_0 = "#735c0f"

" -------- Orange --------
let s:orange_9 = "#fff8f2"
let s:orange_8 = "#ffebda"
let s:orange_7 = "#ffd1ac"
let s:orange_6 = "#ffab70"
let s:orange_5 = "#fb8532"
let s:orange_4 = "#f66a0a"
let s:orange_3 = "#e36209"
let s:orange_2 = "#d15704"
let s:orange_1 = "#c24e00"
let s:orange_0 = "#a04100"

" -------- Red --------
let s:red_9 = "#ffeef0"
let s:red_8 = "#ffdce0"
let s:red_7 = "#fdaeb7"
let s:red_6 = "#f97583"
let s:red_5 = "#ea4a5a"
let s:red_4 = "#d73a49"
let s:red_3 = "#cb2431"
let s:red_2 = "#b31d28"
let s:red_1 = "#9e1c23"
let s:red_0 = "#86181d"

" -------- Purple --------
let s:purple_9 = "#f5f0ff"
let s:purple_8 = "#e6dcfd"
let s:purple_7 = "#d1bcf9"
let s:purple_6 = "#b392f0"
let s:purple_5 = "#8a63d2"
let s:purple_4 = "#6f42c1"
let s:purple_3 = "#5a32a3"
let s:purple_2 = "#4c2889"
let s:purple_1 = "#3a1d6e"
let s:purple_0 = "#29134e"

" -------- Pink --------
let s:pink_9 = "#ffeef8"
let s:pink_8 = "#fedbf0"
let s:pink_7 = "#f9b3dd"
let s:pink_6 = "#f692ce"
let s:pink_5 = "#ec6cb9"
let s:pink_4 = "#ea4aaa"
let s:pink_3 = "#d03592"
let s:pink_2 = "#b93a86"
let s:pink_1 = "#99306f"
let s:pink_0 = "#6d224f"

" -------- Defaults --------
let s:red        = s:red_4
let s:purple     = s:purple_4
let s:blue       = s:blue_4
let s:green      = s:green_4
let s:yellow     = s:yellow_4
let s:orange     = s:orange_4
let s:gray_dark  = s:gray_4
let s:gray_light = s:gray_9
let s:gray       = s:gray_5

if exists('&wincolor')
  augroup Wincolor
    au!
    " Low-key colors for non-file buffers
    autocmd BufWinEnter,WinEnter * if (&buftype!='' && &buftype!='nofile')
          \ | set wincolor=BlendDown | else | set wincolor= | endif
  augroup END
elseif exists('&winhighlight')
  augroup Winhighlight
    au!
    " Low-key colors for non-file buffers
    autocmd BufWinEnter,WinEnter * if (&buftype!='' && &buftype!='nofile')
          \ | set winhighlight=Normal:BlendDown | set winhighlight= | endif
  augroup END
endif

" Color scheme specific
call s:Hi('BlendDown', s:white, s:gray_9, '', '')

" Basics
call s:Hi('Normal', s:gray_2, s:white, 'NONE', '')
call s:Hi('Bold',   s:white, '', 'bold', '')
call s:Hi('Italic', s:white, '', 'italic', '')
call s:Hi('NonText', s:gray_5, s:gray_8, '', '')
call s:Hi('Visual', s:blue_0, s:blue_7, '', '')
call s:Hi('StatusLine', s:blue_8, s:gray_2, 'bold', '')
call s:Hi('StatusLineNC', s:gray_3, s:gray_6, 'bold', '')
call s:Hi('VertSplit', s:gray_6, 'bg', 'NONE', '')
call s:Hi('IncSearch', s:black, s:blue_6, 'none', '')
call s:Hi('Search', s:blue_0, s:yellow_6, 'NONE', '')
call s:Hi('MatchParen', s:green_1, s:green_7, '', '')
call s:Hi('QuickFixLine', '', s:yellow_8, 'bold', '')
call s:Hi('CursorLine', '', s:gray_8, '', '')
call s:Hi('LineNr', s:gray_6, '', '', '')

highlight! link CursorColumn CursorLine
highlight! link CursorLineNr CursorLine
highlight! link SignColumn LineNr
highlight! link FoldColumn LineNr
highlight! link Folded Comment
highlight! link StatusLineTerm StatusLine
highlight! link StatusLineTermNC StatusLineNC
highlight! link PmenuSel IncSearch
highlight! link Pmenu Search
highlight! link PmenuSbar Search
highlight! link PmenuThumb IncSearch
highlight! link TabLineFill Normal
highlight! link TabLine StatusLineNC
highlight! link TabLineSel Statusline
highlight! link WildMenu PmenuSel

" Breeze specific
call s:Hi('BlendDown', s:gray_0, s:gray_8, '', '')

" Code
call s:Hi('Statement', s:purple_4, '', 'none', '')
call s:Hi('Conditional', s:purple_5, '', 'none', '')
call s:Hi('Type', s:pink_2, '', 'none', '')
call s:Hi('Structure', s:green_1, '', '', '')
call s:Hi('StorageClass', s:blue_1, '', '', '')
call s:Hi('PreProc', s:blue_4, '', 'bold', '')
call s:Hi('PreCondit', s:blue_5, '', 'bold', '')
call s:Hi('Comment', s:green_3, '', '', '')
call s:Hi('Function', s:green_1, '', '', '')
call s:Hi('Identifier', s:green_1, '', '', '')
call s:Hi('Special', s:green_1, '', '', '')
call s:Hi('Constant', s:blue_2, '', '', '')
call s:Hi('Number', s:blue_2, '', '', '')
call s:Hi('Title', s:gray_2, '', '', '')
call s:Hi('Todo', s:gray_2, s:gray_7, '', '')
call s:Hi('Error', s:red_1, s:red_8, '', '')
call s:Hi('Directory', s:gray_2, '', '', '')
call s:Hi('ErrorMsg', s:red_0, s:red_7, '', '')
call s:Hi('WarningMsg', s:green_0, s:green_7, '', '')
call s:Hi('ModeMsg', s:yellow_0, s:yellow_7, '', '')
call s:Hi('Question', s:green_1, 'bg', '', '')
call s:Hi('qfFileName', s:blue_2, '', '', '')
call s:Hi('qfSeparator', s:gray_1, '', '', '')
highlight! link qfLineNr    LineNr

" Filetype VIM
call s:Hi('vimCommentTitle', s:blue_6, '', 'bold', '')

" Filetype C
call s:Hi('cCppOut', s:gray_3, '', '', '')
call s:Hi('cCppOutIf2', s:gray_3, '', '', '')
call s:Hi('cParen', s:gray_3, '', '', '')
call s:Hi('cBlock', s:gray_3, '', '', '')

" filetype HTML
call s:Hi('htmlH1', s:green_2, '', 'bold', '')
call s:Hi('htmlH2', s:green_2, '', 'bold', '')
call s:Hi('htmlH3', s:green_2, '', 'bold,italic', '')

" markdown
call s:Hi('markdownCode', s:gray_2, s:gray_7, '', '')
call s:Hi('markdownCodeBlock', s:gray_2, '', '', '')

" Diffs
call s:Hi('DiffChange', s:blue_3, s:blue_8, '', '')
call s:Hi('DiffText', s:blue_3, s:blue_7, '', '')
call s:Hi('DiffDelete', s:red_6, s:red_8, '', '')
call s:Hi('DiffAdd', s:green_3, s:green_8, '', '')
