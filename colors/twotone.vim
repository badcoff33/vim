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

let s:silver9 = "#F8F5F8"
let s:silver8 = "#E7E1E7"
let s:silver7 = "#D5D1D5"
let s:silver6 = "#BEB5BE"
let s:silver5 = "#989598"
let s:silver4 = "#7A787A"
let s:silver3 = "#5A585A"
let s:silver2 = "#474447"
let s:silver1 = "#353335"
let s:silver0 = "#282528"

let s:Fg = {str -> empty(str) ? "":"guifg=".str}
let s:Bg = {str -> empty(str) ? "":"guibg=".str}
let s:Attr = {str -> empty(str) ? "":"gui=".str}
let s:Cterm = {str -> empty(str) ? "":"cterm="..str}

" Basics

execute "hi Bold" s:Attr("bold")
execute "hi CursorLine" s:Bg(s:silver9) s:Cterm("NONE")
execute "hi CursorLineNr" s:Fg(s:silver4) s:Attr("bold")
execute "hi IncSearch" s:Fg(s:white) s:Bg(s:black) s:Attr("NONE")
execute "hi Italic" s:Attr("italic")
execute "hi LineNr" s:Fg(s:silver4) s:Attr("bold")
execute "hi MatchParen" s:Fg(s:white) s:Bg(s:silver5) s:Attr("NONE")
execute "hi NonText" s:Fg(s:silver6) s:Bg("bg")
execute "hi Normal" s:Fg(s:silver2) s:Bg(s:white) s:Attr("NONE")
execute "hi Pmenu" s:Fg(s:white) s:Bg(s:silver4)
execute "hi PmenuSel" s:Fg(s:white) s:Bg(s:blue)
execute "hi PmenuThumb" s:Fg(s:silver2) s:Bg(s:silver7)
execute "hi Search" s:Fg(s:black) s:Bg(s:silver8) s:Attr("NONE")
execute "hi StatusLine" s:Fg(s:white) s:Bg(s:black) s:Attr("NONE")
execute "hi StatusLineNC" s:Fg(s:silver2) s:Bg(s:silver7) s:Attr("NONE")
execute "hi StatusLineTerm" s:Fg(s:white) s:Bg(s:black) s:Attr("bold")
execute "hi Terminal" s:Fg(s:black) s:Bg(s:silver8)
execute "hi User1" s:Fg(s:white) s:Bg(s:blue)
execute "hi VertSplit" s:Fg(s:silver9) s:Bg(s:silver9) s:Attr("NONE")
execute "hi Visual" s:Fg(s:white) s:Bg(s:blue)

highlight! link CursorColumn CursorLine
highlight! link FoldColumn LineNr
highlight! link Folded Comment
highlight! link PmenuSbar Pmenu
highlight! link SignColumn LineNr
highlight! link StatusLineTermNC StatusLineNC
highlight! link TabLine StatusLineNC
highlight! link TabLineFill Normal
highlight! link TabLineSel PmenuSel
highlight! link WildMenu PmenuSel
highlight! link qfSeparator Normal

" Code
execute "hi Comment" s:Fg(s:silver5) s:Attr("NONE")
execute "hi Conditional" s:Fg(s:red)  s:Attr("bold")
execute "hi Constant" s:Fg(s:blue)
execute "hi Directory" s:Fg(s:silver2)
execute "hi Error" s:Fg(s:red) s:Bg("bg") s:Attr("underline")
execute "hi ErrorMsg" s:Fg(s:white) s:Bg(s:red) s:Attr("NONE")
execute "hi Function" s:Fg(s:blue)
execute "hi Identifier" s:Fg(s:blue)
execute "hi ModeMsg" s:Fg(s:white) s:Bg(s:blue) s:Attr("NONE")
execute "hi Number" s:Fg(s:blue)
execute "hi PreCondit" s:Fg(s:blue)  s:Attr("bold")
execute "hi PreProc" s:Fg(s:blue) s:Attr("NONE")
execute "hi Question" s:Fg(s:silver1) s:Bg("bg")
execute "hi QuickFixLine" s:Fg(s:white) s:Bg(s:red) s:Attr("NONE")
execute "hi Special" s:Fg(s:blue)
execute "hi SpecialKey" s:Fg(s:blue)
execute "hi Statement" s:Fg(s:red)  s:Attr("bold")
execute "hi StorageClass" s:Fg(s:red)
execute "hi String" s:Fg(s:silver4)
execute "hi Structure" s:Fg(s:red) s:Attr("NONE")
execute "hi Title" s:Fg(s:black)  s:Attr("bold")
execute "hi Todo" s:Fg(s:silver2) s:Bg(s:silver7)
execute "hi Type" s:Fg(s:blue) s:Attr("NONE")
execute "hi WarningMsg" s:Fg(s:white) s:Bg(s:blue)
execute "hi qfFileName" s:Fg(s:blue)
execute "hi qfLineNr" s:Fg(s:red)

" Filetype VIM
execute "hi vimCommentTitle" s:Fg(s:blue)  s:Attr("bold")

" Filetype C
execute "hi cCppOut" s:Bg(s:silver9) s:Attr("NONE")
execute "hi cCppOutIf2" s:Bg(s:silver9) s:Attr("NONE")
execute "hi cParen" s:Fg(s:silver3)
execute "hi cBlock" s:Fg(s:silver3)

" filetype HTML
execute "hi htmlH1" s:Fg(s:blue)  s:Attr("bold")
execute "hi htmlH2" s:Fg(s:blue)  s:Attr("bold")
execute "hi htmlH3" s:Fg(s:blue)  s:Attr("bold")

" markdown
execute "hi markdownCode" s:Fg(s:silver3) s:Bg(s:silver9)
execute "hi markdownCodeBlock" s:Fg(s:silver2)
execute "hi rstEmphasis" s:Fg(s:silver2)
execute "hi rstStrongEmphasis" s:Fg(s:silver2)  s:Attr("bold")

" Diffs
execute "hi DiffChange" s:Fg(s:white) s:Bg(s:blue)
execute "hi DiffText" s:Fg(s:white) s:Bg(s:blue)
execute "hi DiffDelete" s:Fg(s:red) s:Bg(s:red)
execute "hi DiffAdd" s:Fg(s:silver3) s:Bg(s:silver8)
