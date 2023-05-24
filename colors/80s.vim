" Vim color theme
"
" Description: A dark color theme with blue/red/gray-scale colors.

if exists("g:syntax_on")
  syntax reset
endif

hi clear
set background=dark
let g:colors_name = "80s"

let s:black    = "#000000"
let s:white    = "#FFFFFF"

let s:blue     = "#21A8FF"
let s:red      = "#FF23A2"

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
let Attr = {str -> empty(str) ? "" : "gui=" .. str}
let Cterm = {str -> empty(str) ? "" : "cterm=" .. str}

" Basics

execute "hi Bold" Attr("bold")
execute "hi CursorLine" Bg(s:gray1) Cterm("NONE")
execute "hi CursorLineNr" Fg(s:gray4) Attr("bold")
execute "hi IncSearch" Fg(s:white) Bg(s:red) Attr("NONE")
execute "hi Italic" Attr("italic")
execute "hi LineNr" Fg(s:gray4) Attr("bold")
execute "hi MatchParen" Fg(s:blue) Bg("bg") Attr("underline,bold")
execute "hi NonText" Fg(s:gray6) Bg("bg")
execute "hi Normal" Fg(s:gray7) Bg(s:black) Attr("NONE")
execute "hi Pmenu" Fg(s:white) Bg(s:gray3)
execute "hi PmenuSel" Fg(s:white) Bg(s:blue) Attr("NONE")
execute "hi PmenuThumb" Fg(s:gray2) Bg(s:gray7)
execute "hi PmenuSbar" Fg(s:red) Bg(s:red)
execute "hi CurSearch" Fg(s:black) Bg(s:gray7) Attr("NONE")
execute "hi Search" Fg(s:white) Bg(s:gray3) Attr("NONE")
execute "hi StatusLine" Fg(s:black) Bg(s:gray9) Attr("NONE")
execute "hi StatusLineNC" Fg(s:gray9) Bg(s:gray2) Attr("NONE")
execute "hi StatusLineTerm" Fg(s:white) Bg(s:red) Attr("NONE")
execute "hi Terminal" Fg(s:blue) Bg(s:black)
execute "hi User1" Fg(s:black) Bg(s:gray8) Attr("bold")
execute "hi User2" Fg(s:black) Bg(s:white)
execute "hi VertSplit" Fg(s:gray6) Bg("bg") Attr("NONE")
execute "hi Visual" Fg(s:white) Bg(s:blue)

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
execute "hi Conditional" Fg(s:red)  Attr("NONE")
execute "hi Constant" Fg(s:blue)
execute "hi Directory" Fg(s:blue) Attr("underline")
execute "hi Error" Fg(s:red) Bg("bg") Attr("underline")
execute "hi ErrorMsg" Fg(s:white) Bg(s:red) Attr("NONE")
execute "hi Function" Fg(s:blue)
execute "hi Identifier" Fg(s:red) Attr("NONE")
execute "hi ModeMsg" Fg(s:white) Bg(s:blue) Attr("NONE")
execute "hi Number" Fg(s:blue)
execute "hi PreCondit" Fg(s:blue)  Attr("bold")
execute "hi PreProc" Fg(s:blue) Attr("NONE")
execute "hi Question" Fg(s:blue) Bg("bg")
execute "hi QuickFixLine" Fg(s:blue) Bg(s:gray2) Attr("bold")
execute "hi Special" Fg(s:blue)
execute "hi SpecialKey" Fg(s:blue)
execute "hi Statement" Fg(s:red)  Attr("NONE")
execute "hi StorageClass" Fg(s:red)
execute "hi String" Fg(s:gray7)
execute "hi Structure" Fg(s:red) Attr("NONE")
execute "hi Title" Fg(s:black)  Attr("bold")
execute "hi Todo" Fg(s:blue) Bg("bg") Attr("bold,italic")
execute "hi Type" Fg(s:blue) Attr("NONE")
execute "hi WarningMsg" Fg(s:white) Bg(s:blue)
execute "hi qfFileName" Fg(s:blue)
execute "hi qfLineNr" Fg(s:red)

" Filetype VIM

execute "hi vimCommentTitle" Fg(s:blue)  Attr("bold")

" Filetype C

execute "hi cCppOut" Bg(s:gray3) Attr("NONE")
execute "hi cCppOutIf2" Bg(s:gray3) Attr("NONE")
execute "hi cParen" Fg(s:gray7)
execute "hi cBlock" Fg(s:gray7)

" Filetype HTML

execute "hi htmlH1" Fg(s:red)  Attr("bold")
execute "hi htmlH2" Fg(s:red)  Attr("bold")
execute "hi htmlH3" Fg(s:red)  Attr("bold")

" Some markup flavours

execute "hi markdownCode" Fg(s:gray6) Bg(s:gray2)
execute "hi markdownCodeBlock" Fg(s:gray6)
execute "hi rstEmphasis" Fg(s:blue)
execute "hi rstStrongEmphasis" Fg(s:blue)  Attr("bold")

" Diffs

execute "hi DiffChange" Fg(s:blue) Bg(s:gray2)
execute "hi DiffText" Fg(s:blue) Bg(s:gray2)
execute "hi DiffDelete" Fg(s:red) Bg(s:gray2)
execute "hi DiffAdd" Fg(s:gray7) Bg(s:gray2)

unlet Fg
unlet Bg
unlet Attr
unlet Cterm
