" Vim color theme
"
" Description: A dark color theme with yellow/orange/gray-scale colors.

if exists("g:syntax_on")
  syntax reset
endif

hi clear
set background=dark
let g:colors_name = "80s"

let s:black    = "#000000"
let s:white    = "#FFFFFF"

let s:yellow = "#FFCE40"
let s:orange = "#E09040"
let s:red    = "#E84040"
let s:blue   = "#40C0FF"

let s:gray9 = "#F8F8F8"
let s:gray8 = "#E7E2E7"
let s:gray7 = "#D5D1D5"
let s:gray6 = "#BEB0BE"
let s:gray5 = "#989098"
let s:gray4 = "#7A708A"
let s:gray3 = "#5A505A"
let s:gray2 = "#473B47"
let s:gray1 = "#352835"
let s:gray0 = "#282028"

let Fg = {str -> empty(str) ? "" : "guifg=" .. str}
let Bg = {str -> empty(str) ? "" : "guibg=" .. str}
let Attr = {str -> empty(str) ? "" : "gui=" .. str .. " cterm=" .. str}
let Cterm = {str -> empty(str) ? "" : "cterm=" .. str}

" Basics

execute "hi Bold" Attr("bold")
execute "hi Cursor" Fg(s:black) Bg(s:blue) Cterm("NONE")
execute "hi CursorLine" Bg(s:black) Cterm("NONE")
execute "hi CursorLineNr" Fg(s:gray4) Attr("bold")
execute "hi IncSearch" Fg(s:black) Bg(s:red) Attr("NONE")
execute "hi Italic" Attr("italic")
execute "hi LineNr" Fg(s:gray4) Attr("bold")
execute "hi MatchParen" Fg(s:yellow) Bg("bg") Attr("underline,bold")
execute "hi NonText" Fg(s:gray6) Bg("bg")
execute "hi Normal" Fg(s:gray7) Bg(s:gray0) Attr("NONE")
execute "hi Pmenu" Fg(s:white) Bg(s:gray3)
execute "hi PmenuSel" Fg(s:black) Bg(s:yellow) Attr("NONE")
execute "hi PmenuThumb" Fg(s:gray2) Bg(s:gray7)
execute "hi PmenuSbar" Fg(s:orange) Bg(s:orange)
execute "hi CurSearch" Fg(s:black) Bg(s:gray7) Attr("NONE")
execute "hi Search" Fg("fg") Bg(s:gray3) Attr("NONE")
execute "hi StatusLine" Fg(s:white) Bg(s:gray4) Attr("NONE")
execute "hi StatusLineNC" Fg(s:gray9) Bg(s:gray2) Attr("NONE")
execute "hi StatusLineTerm" Fg(s:white) Bg(s:orange) Attr("NONE")
execute "hi Terminal" Fg(s:yellow) Bg(s:black)
execute "hi User1" Fg(s:black) Bg(s:gray8) Attr("bold")
execute "hi User2" Fg(s:black) Bg(s:white)
execute "hi VertSplit" Fg(s:gray2) Bg(s:gray2) Attr("NONE")
execute "hi Visual" Fg(s:black) Bg(s:gray5)

highlight! link CursorColumn CursorLine
highlight! link FoldColumn LineNr
highlight! link Folded Comment
highlight! link Ignore Comment
highlight! link SignColumn LineNr
highlight! link StatusLineTermNC StatusLineNC
highlight! link TabLine Pmenu
highlight! link TabLineFill Normal
highlight! link TabLineSel PmenuSel
highlight! link WildMenu PmenuSel
highlight! link qfSeparator Normal

" Code
execute "hi Comment" Fg(s:gray5) Attr("NONE")
execute "hi Conditional" Fg(s:orange)  Attr("NONE")
execute "hi Constant" Fg(s:yellow)
execute "hi Directory" Fg(s:yellow) Attr("underline")
execute "hi Error" Fg(s:orange) Bg("bg") Attr("underline")
execute "hi ErrorMsg" Fg(s:white) Bg(s:orange) Attr("NONE")
execute "hi Function" Fg(s:yellow)
execute "hi Identifier" Fg(s:orange) Attr("NONE")
execute "hi ModeMsg" Fg(s:black) Bg(s:yellow) Attr("NONE")
execute "hi Number" Fg(s:yellow)
execute "hi PreCondit" Fg(s:yellow)  Attr("bold")
execute "hi PreProc" Fg(s:yellow) Attr("NONE")
execute "hi Question" Fg(s:yellow) Bg("bg")
execute "hi QuickFixLine" Fg(s:yellow) Bg(s:gray2) Attr("bold")
execute "hi Special" Fg(s:yellow)
execute "hi SpecialKey" Fg(s:yellow)
execute "hi Statement" Fg(s:orange)  Attr("NONE")
execute "hi StorageClass" Fg(s:orange)
execute "hi String" Fg(s:gray7)
execute "hi Structure" Fg(s:orange) Attr("NONE")
execute "hi Title" Fg(s:black)  Attr("bold")
execute "hi Todo" Fg(s:yellow) Bg("bg") Attr("bold,italic")
execute "hi Type" Fg(s:red) Attr("NONE")
execute "hi WarningMsg" Fg(s:yellow)
execute "hi qfFileName" Fg(s:yellow)
execute "hi qfLineNr" Fg(s:orange)

" Filetype VIM

execute "hi vimCommentTitle" Fg(s:yellow)  Attr("bold")

" Filetype C

execute "hi cCppOut" Bg(s:gray3) Attr("NONE")
execute "hi cCppOutIf2" Bg(s:gray3) Attr("NONE")
execute "hi cParen" Fg(s:gray7)
execute "hi cBlock" Fg(s:gray7)

" Filetype HTML

execute "hi htmlH1" Fg(s:orange)  Attr("bold")
execute "hi htmlH2" Fg(s:orange)  Attr("bold")
execute "hi htmlH3" Fg(s:orange)  Attr("bold")

" Some markup flavours

execute "hi markdownCode" Fg(s:gray6) Bg(s:gray2)
execute "hi markdownCodeBlock" Fg(s:gray6)
execute "hi rstEmphasis" Fg(s:yellow)
execute "hi rstStrongEmphasis" Fg(s:yellow)  Attr("bold")

" Diffs

execute "hi DiffChange" Fg(s:yellow) Bg(s:gray2)
execute "hi DiffText" Fg(s:yellow) Bg(s:gray2)
execute "hi DiffDelete" Fg(s:orange) Bg(s:gray2)
execute "hi DiffAdd" Fg(s:gray7) Bg(s:gray2)

unlet Fg
unlet Bg
unlet Attr
unlet Cterm
