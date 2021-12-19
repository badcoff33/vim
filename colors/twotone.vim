" Vim color theme
"
" Description: A light one with fresh colors.

if exists("g:syntax_on")
  syntax reset
endif

hi clear
set background=light
let g:colors_name = "twotone"

let s:black    = "#000000"
let s:white    = "#FFFFFF"
let s:blue     = "#2188FF"
let s:red      = "#FF2382"

let s:silver_9 = "#F2F2F4"
let s:silver_8 = "#E1E1E3"
let s:silver_7 = "#D1D1D4"
let s:silver_6 = "#B5B5B7"
let s:silver_5 = "#959597"
let s:silver_4 = "#737375"
let s:silver_3 = "#585859"
let s:silver_2 = "#444447"
let s:silver_1 = "#333336"
let s:silver_0 = "#252528"

let s:GuiFg = {str -> empty(str) ? "":"guifg=".str}
let s:GuiBg = {str -> empty(str) ? "":"guibg=".str}
let s:GuiAttr = {str -> empty(str) ? "":"gui=".str}

" Color scheme specific
execute 'hi BlendDown' s:GuiFg(s:white) s:GuiBg(s:silver_8)

" Basics
execute 'hi Normal' s:GuiFg(s:silver_2) s:GuiBg(s:white) s:GuiAttr('NONE')
execute 'hi Bold' s:GuiFg(  s:white)  s:GuiAttr('bold')
execute 'hi Italic' s:GuiFg(s:white)  s:GuiAttr('italic')
execute 'hi NonText' s:GuiFg(s:silver_6) s:GuiBg('bg')
execute 'hi Visual' s:GuiFg(s:silver_0) s:GuiBg(s:silver_8)
execute 'hi StatusLine' s:GuiFg(s:white) s:GuiBg(s:silver_5) s:GuiAttr('bold')
execute 'hi StatusLineNC' s:GuiFg(s:silver_3) s:GuiBg(s:silver_7) s:GuiAttr('bold')
execute 'hi VertSplit' s:GuiFg(s:silver_6) s:GuiBg('bg') s:GuiAttr('NONE')
execute 'hi IncSearch' s:GuiFg(s:white) s:GuiBg(s:black) s:GuiAttr('none')
execute 'hi Search' s:GuiFg(s:white) s:GuiBg(s:blue) s:GuiAttr('NONE')
execute 'hi MatchParen' s:GuiFg(s:silver_1) s:GuiBg(s:silver_9) s:GuiAttr('underline')
execute 'hi QuickFixLine' s:GuiFg(s:white) s:GuiBg(s:red) s:GuiAttr('NONE')
execute 'hi CursorLine' s:GuiBg(s:silver_9)
execute 'hi CursorLineNr' s:GuiFg(s:silver_1) s:GuiBg(s:silver_7) s:GuiAttr('bold')
execute 'hi LineNr' s:GuiFg(s:silver_6) s:GuiAttr('italic')

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

" Breeze specific
execute 'hi BlendDown' s:GuiFg(s:silver_0) s:GuiBg(s:silver_8)

" Code
execute 'hi Statement' s:GuiFg(s:red)  s:GuiAttr('bold')
execute 'hi Conditional' s:GuiFg(s:red)  s:GuiAttr('bold')
execute 'hi Type' s:GuiFg(s:blue)  s:GuiAttr('italic')
execute 'hi Structure' s:GuiFg(s:red) s:GuiAttr('italic')
execute 'hi StorageClass' s:GuiFg(s:red)
execute 'hi PreProc' s:GuiFg(s:blue) s:GuiAttr('bold')
execute 'hi PreCondit' s:GuiFg(s:blue)  s:GuiAttr('bold')
execute 'hi Comment' s:GuiFg(s:silver_6)
execute 'hi Function' s:GuiFg(s:blue)
execute 'hi Identifier' s:GuiFg(s:blue)
execute 'hi Special' s:GuiFg(s:silver_1)
execute 'hi Constant' s:GuiFg(s:red)
execute 'hi Number' s:GuiFg(s:red)
execute 'hi Title' s:GuiFg(s:black)  s:GuiAttr('bold')
execute 'hi Todo' s:GuiFg(s:silver_2) s:GuiBg(s:silver_7)
execute 'hi Error' s:GuiFg(s:red) s:GuiBg('bg') s:GuiAttr('underline')
execute 'hi Directory' s:GuiFg(s:silver_2)
execute 'hi ErrorMsg' s:GuiFg(s:white) s:GuiBg(s:red)
execute 'hi WarningMsg' s:GuiFg(s:silver_0) s:GuiBg(s:silver_7)
execute 'hi ModeMsg' s:GuiFg(s:silver_0) s:GuiBg(s:silver_7)
execute 'hi Question' s:GuiFg(s:silver_1) s:GuiBg('bg')
execute 'hi qfFileName' s:GuiFg(s:blue)
execute 'hi qfSeparator' s:GuiFg(s:silver_1)
execute 'hi qfLineNr' s:GuiFg(s:red)

" Filetype VIM
execute 'hi vimCommentTitle' s:GuiFg(s:blue)  s:GuiAttr('bold')

" Filetype C
execute 'hi cCppOut' s:GuiFg(s:silver_3)
execute 'hi cCppOutIf2' s:GuiFg(s:silver_3)
execute 'hi cParen' s:GuiFg(s:silver_3)
execute 'hi cBlock' s:GuiFg(s:silver_3)

" filetype HTML
execute 'hi htmlH1' s:GuiFg(s:silver_2)  s:GuiAttr('bold')
execute 'hi htmlH2' s:GuiFg(s:silver_2)  s:GuiAttr('bold')
execute 'hi htmlH3' s:GuiFg(s:silver_2)  s:GuiAttr('bold')

" markdown
execute 'hi markdownCode' s:GuiFg(s:silver_3) s:GuiBg(s:silver_9)
execute 'hi markdownCodeBlock' s:GuiFg(s:silver_2)
execute 'hi rstEmphasis' s:GuiFg(s:silver_2)
execute 'hi rstStrongEmphasis' s:GuiFg(s:silver_2)  s:GuiAttr('bold')

" Diffs
execute 'hi DiffChange' s:GuiFg(s:blue) s:GuiBg(s:blue)
execute 'hi DiffText' s:GuiFg(s:blue) s:GuiBg(s:blue)
execute 'hi DiffDelete' s:GuiFg(s:red) s:GuiBg(s:red)
execute 'hi DiffAdd' s:GuiFg(s:silver_3) s:GuiBg(s:silver_8)
