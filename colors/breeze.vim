" Vim color theme
"
" Description: A light one with fresh colors.

if exists("syntax_on")
  syntax reset
endif

hi clear
set background=light
let g:colors_name = "breeze"

let s:black = "#1b1f23"
let s:white = "#F8FCFC"

" -------- Grey --------
let s:grey_9 = "#f8fafb"
let s:grey_8 = "#f3f5f8"
let s:grey_7 = "#e1e4e8"
let s:grey_6 = "#d1d5da"
let s:grey_5 = "#959da5"
let s:grey_4 = "#6a737d"
let s:grey_3 = "#586069"
let s:grey_2 = "#444d56"
let s:grey_1 = "#2f363d"
let s:grey_0 = "#24292e"

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

if exists('&wincolor')
  augroup Wincolor
    au!
    " Low-key colors for non-file buffers
    autocmd BufWinEnter,WinEnter * if &buftype=='help' || &buftype=='quickfix'
          \ | set wincolor=BlendDown | else | set wincolor= | endif
  augroup END
endif

" Color scheme specific
call lib#color#Hi('BlendDown', s:white, s:grey_7, '', '')

" Basics
call lib#color#Hi('Normal', s:grey_2, s:grey_8, 'NONE', '')
call lib#color#Hi('NonText', s:grey_3, s:grey_8, 'NONE', '')
call lib#color#Hi('Ignore', s:grey_3, s:white, 'NONE', '')
call lib#color#Hi('Bold',   s:white, '', 'bold', '')
call lib#color#Hi('Italic', s:white, '', 'italic', '')
call lib#color#Hi('Visual', s:grey_2, s:grey_6, '', '')
call lib#color#Hi('StatusLine', s:white, s:blue_4, 'none', '')
call lib#color#Hi('StatusLineNC', s:grey_1, s:grey_7, 'none', '')
call lib#color#Hi('VertSplit', s:grey_6, s:grey_8, 'NONE', '')
call lib#color#Hi('IncSearch', s:pink_1, s:pink_7, 'none', '')
call lib#color#Hi('Search', s:blue_1, s:blue_7, 'NONE', '')
call lib#color#Hi('MatchParen', s:green_1, s:green_7, '', '')
call lib#color#Hi('QuickFixLine', s:black, s:orange_7, 'NONE', '')
call lib#color#Hi('CursorLine', 'skip', s:yellow_8, '', '')
call lib#color#Hi('CursorLineNr', s:yellow_2, s:yellow_6, 'bold', '')
call lib#color#Hi('LineNr', s:grey_4, 'skip', '', '')
call lib#color#Hi('PmenuSel', s:white, s:green_4, 'none', '')
call lib#color#Hi('Pmenu', s:black, s:green_6, 'none', '')
call lib#color#Hi('PmenuThumb', s:black, s:grey_5, 'none', '')
call lib#color#Hi('PmenuSbar', s:black, s:grey_7, 'none', '')

highlight! link Terminal Normal
highlight! link CursorColumn CursorLine
highlight! link SignColumn LineNr
highlight! link FoldColumn LineNr
highlight! link Folded Comment
highlight! link StatusLineTerm StatusLine
highlight! link StatusLineTermNC StatusLineNC
highlight! link TabLineFill Normal
highlight! link TabLine StatusLineNC
highlight! link TabLineSel StatusLine
highlight! link WildMenu PmenuSel

call lib#color#Hi('SignifySignAdd', s:green_4, '', '', '')
call lib#color#Hi('SignifySignChange', s:blue_4, '', '', '')
call lib#color#Hi('SignifySignDelete', s:red_4, '', '', '')

" Breeze specific
call lib#color#Hi('BlendDown', s:grey_0, s:grey_9, '', '')

" Code
call lib#color#Hi('Statement', s:red_3, '', '', '')
call lib#color#Hi('Conditional', s:red_4, '', '', '')
call lib#color#Hi('Type', s:pink_2, 'skip', 'none', '')
call lib#color#Hi('Structure', s:green_1, '', '', '')
call lib#color#Hi('StorageClass', s:purple_3, '', '', '')
call lib#color#Hi('PreProc', s:blue_5, 'skip', 'bold', '')
call lib#color#Hi('PreCondit', s:blue_6, '', 'bold', '')
call lib#color#Hi('Comment', s:green_3, 'skip', '', '')
call lib#color#Hi('Function', s:blue_3, 'skip', '', '')
call lib#color#Hi('Identifier', s:green_4, 'skip', '', '')
call lib#color#Hi('Special', s:green_1, 'skip', '', '')
call lib#color#Hi('Constant', s:blue_4, 'skip', '', '')
call lib#color#Hi('Number', s:blue_2, 'skip', '', '')
call lib#color#Hi('Title', s:grey_2, '', 'bold', '')
call lib#color#Hi('Todo', s:grey_2, s:grey_7, '', '')
call lib#color#Hi('Error', s:red_3, 'bg', 'undercurl', s:red_4)
call lib#color#Hi('Directory', s:blue_4, 'skip', 'underline', '')
call lib#color#Hi('ErrorMsg', s:red_2, 'bg', '', '')
call lib#color#Hi('WarningMsg', s:green_0, s:green_7, '', '')
call lib#color#Hi('ModeMsg', s:yellow_0, s:yellow_7, '', '')
call lib#color#Hi('Question', s:green_1, 'bg', '', '')
call lib#color#Hi('qfFileName', s:blue_2, '', '', '')
call lib#color#Hi('qfSeparator', s:grey_1, '', '', '')
call lib#color#Hi('qfLineNr', s:red_6, '', '', '')

" Filetype VIM
call lib#color#Hi('vimCommentTitle', s:blue_6, '', 'bold', '')

" Filetype C
call lib#color#Hi('cCppOut', s:grey_3, '', '', '')
call lib#color#Hi('cCppOutIf2', s:grey_3, '', '', '')
call lib#color#Hi('cParen', s:grey_3, '', '', '')
call lib#color#Hi('cBlock', s:grey_3, '', '', '')

" filetype HTML
call lib#color#Hi('htmlH1', s:green_2, '', 'bold', '')
call lib#color#Hi('htmlH2', s:green_2, '', 'bold', '')
call lib#color#Hi('htmlH3', s:green_2, '', 'bold,italic', '')

" markdown
call lib#color#Hi('markdownCode', s:grey_3, s:grey_9, '', '')
call lib#color#Hi('markdownCodeBlock', s:grey_2, '', '', '')
call lib#color#Hi('rstEmphasis', s:green_2, '', '', '')
call lib#color#Hi('rstStrongEmphasis', s:green_2, '', 'bold', '')

" Diffs
call lib#color#Hi('DiffChange', s:blue_3, s:blue_8, '', '')
call lib#color#Hi('DiffText', s:blue_3, s:blue_6, '', '')
call lib#color#Hi('DiffDelete', s:red_6, s:red_8, '', '')
call lib#color#Hi('DiffAdd', s:green_3, s:green_8, '', '')
