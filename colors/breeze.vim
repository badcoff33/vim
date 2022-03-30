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
let s:white = "#ffffff"

" -------- Grey --------
let s:grey_9 = "#fafbfc"
let s:grey_8 = "#f6f8fa"
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

let s:GuiFg = {str -> empty(str) ? "":"guifg=".str}
let s:GuiBg = {str -> empty(str) ? "":"guibg=".str}
let s:GuiAttr = {str -> empty(str) ? "":"gui=".str}

" Basics
execute 'hi Normal' s:GuiFg(s:grey_2) s:GuiBg(s:white) s:GuiAttr('NONE')
execute 'hi Bold' s:GuiFg(  s:white)  s:GuiAttr('bold')
execute 'hi Italic' s:GuiFg(s:white)  s:GuiAttr('italic')
execute 'hi NonText' s:GuiFg(s:grey_6) s:GuiBg(s:grey_9)
execute 'hi Visual' s:GuiFg(s:blue_0) s:GuiBg(s:green_7)
execute 'hi StatusLine' s:GuiFg(s:blue_8) s:GuiBg(s:grey_2) s:GuiAttr('bold')
execute 'hi StatusLineNC' s:GuiFg(s:grey_3) s:GuiBg(s:grey_6) s:GuiAttr('bold')
execute 'hi VertSplit' s:GuiFg(s:grey_6) s:GuiBg('bg') s:GuiAttr('NONE')
execute 'hi IncSearch' s:GuiFg(s:black) s:GuiBg(s:yellow_6) s:GuiAttr('none')
execute 'hi Search' s:GuiFg(s:blue_0) s:GuiBg(s:blue_9) s:GuiAttr('NONE')
execute 'hi MatchParen' s:GuiFg(s:green_1) s:GuiBg(s:green_7)
execute 'hi QuickFixLine' s:GuiFg(s:red_0) s:GuiBg(s:red_8) s:GuiAttr('bold')
execute 'hi CursorLine' s:GuiBg(s:green_9)
execute 'hi CursorLineNr' s:GuiFg(s:green_1) s:GuiBg(s:green_7) s:GuiAttr('bold')
execute 'hi LineNr' s:GuiFg(s:grey_6) s:GuiAttr('italic')

highlight! link CursorColumn CursorLine
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
highlight! link TabLineSel StatusLine
highlight! link WildMenu PmenuSel

" Code
execute 'hi Statement' s:GuiFg(s:pink_3)  s:GuiAttr('bold')
execute 'hi Conditional' s:GuiFg(s:pink_4)  s:GuiAttr('none')
execute 'hi Type' s:GuiFg(s:pink_2)  s:GuiAttr('none')
execute 'hi Structure' s:GuiFg(s:green_1)
execute 'hi StorageClass' s:GuiFg(s:purple_3)
execute 'hi PreProc' s:GuiFg(s:blue_5) s:GuiAttr('bold')
execute 'hi PreCondit' s:GuiFg(s:blue_6)  s:GuiAttr('bold')
execute 'hi Comment' s:GuiFg(s:green_3)
execute 'hi Function' s:GuiFg(s:green_1)
execute 'hi Identifier' s:GuiFg(s:green_4)
execute 'hi Special' s:GuiFg(s:green_1)
execute 'hi Constant' s:GuiFg(s:blue_4)
execute 'hi Number' s:GuiFg(s:blue_2)
execute 'hi Title' s:GuiFg(s:grey_2)  s:GuiAttr('bold')
execute 'hi Todo' s:GuiFg(s:grey_2) s:GuiBg(s:grey_7)
execute 'hi Error' s:GuiFg(s:red_3) s:GuiBg('bg') s:GuiAttr('undercurl')
execute 'hi Directory' s:GuiFg(s:grey_2)
execute 'hi ErrorMsg' s:GuiFg(s:red_0) s:GuiBg(s:red_7)
execute 'hi WarningMsg' s:GuiFg(s:green_0) s:GuiBg(s:green_7)
execute 'hi ModeMsg' s:GuiFg(s:yellow_0) s:GuiBg(s:yellow_7)
execute 'hi Question' s:GuiFg(s:green_1) s:GuiBg('bg')
execute 'hi qfFileName' s:GuiFg(s:blue_2)
execute 'hi qfSeparator' s:GuiFg(s:grey_1)
execute 'hi qfLineNr' s:GuiFg(s:red_6)

" Filetype VIM
execute 'hi vimCommentTitle' s:GuiFg(s:blue_6)  s:GuiAttr('bold')

" Filetype C
execute 'hi cCppOut' s:GuiFg(s:grey_3)
execute 'hi cCppOutIf2' s:GuiFg(s:grey_3)
execute 'hi cParen' s:GuiFg(s:grey_3)
execute 'hi cBlock' s:GuiFg(s:grey_3)

" filetype HTML
execute 'hi htmlH1' s:GuiFg(s:green_2)  s:GuiAttr('bold')
execute 'hi htmlH2' s:GuiFg(s:green_2)  s:GuiAttr('bold')
execute 'hi htmlH3' s:GuiFg(s:green_2)  s:GuiAttr('bold')

" markdown
execute 'hi markdownCode' s:GuiFg(s:grey_3) s:GuiBg(s:grey_9)
execute 'hi markdownCodeBlock' s:GuiFg(s:grey_2)
execute 'hi rstEmphasis' s:GuiFg(s:green_2)
execute 'hi rstStrongEmphasis' s:GuiFg(s:green_2)  s:GuiAttr('bold')

" Diffs
execute 'hi DiffChange' s:GuiFg(s:blue_3) s:GuiBg(s:blue_8)
execute 'hi DiffText' s:GuiFg(s:blue_3) s:GuiBg(s:blue_7)
execute 'hi DiffDelete' s:GuiFg(s:red_6) s:GuiBg(s:red_8)
execute 'hi DiffAdd' s:GuiFg(s:green_3) s:GuiBg(s:green_8)
