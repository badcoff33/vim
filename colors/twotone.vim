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

let s:GuiFg = {str -> empty(str) ? "":"guifg=".str}
let s:GuiBg = {str -> empty(str) ? "":"guibg=".str}
let s:GuiAttr = {str -> empty(str) ? "":"gui=".str}

" Basics

execute "hi Bold" s:GuiAttr("bold")
execute "hi CursorLine" s:GuiBg(s:silver9)
execute "hi CursorLineNr" s:GuiFg(s:silver4) s:GuiAttr("bold")
execute "hi IncSearch" s:GuiFg(s:white) s:GuiBg(s:black) s:GuiAttr("none")
execute "hi Italic" s:GuiAttr("italic")
execute "hi LineNr" s:GuiFg(s:silver8) s:GuiAttr("bold")
execute "hi MatchParen" s:GuiFg(s:blue) s:GuiBg("bg") s:GuiAttr("bold")
execute "hi NonText" s:GuiFg(s:silver6) s:GuiBg("bg")
execute "hi Normal" s:GuiFg(s:silver2) s:GuiBg(s:white) s:GuiAttr("NONE")
execute "hi Search" s:GuiFg(s:black) s:GuiBg(s:silver8) s:GuiAttr("NONE")
execute "hi StatusLine" s:GuiFg(s:white) s:GuiBg(s:black) s:GuiAttr("NONE")
execute "hi StatusLineNC" s:GuiFg(s:silver4) s:GuiBg(s:silver9) s:GuiAttr("NONE")
execute "hi StatusLineTerm" s:GuiFg(s:white) s:GuiBg(s:black) s:GuiAttr("bold")
"execute "hi TabLineSel" s:GuiAttr("underline,bold")
execute "hi Terminal" s:GuiFg(s:white) s:GuiBg(s:black)
execute "hi VertSplit" s:GuiFg(s:silver9) s:GuiBg(s:silver9) s:GuiAttr("NONE")
execute "hi Visual" s:GuiFg(s:white) s:GuiBg(s:blue)


highlight! link CursorColumn CursorLine
highlight! link FoldColumn LineNr
highlight! link Folded Comment
highlight! link Pmenu Search
highlight! link PmenuSbar Search
highlight! link PmenuSel IncSearch
highlight! link PmenuThumb IncSearch
highlight! link SignColumn LineNr
highlight! link StatusLineTermNC StatusLineNC
highlight! link TabLine Normal
highlight! link TabLineFill Normal
highlight! link TabLineSel StatusLine
highlight! link WildMenu PmenuSel

" Code
execute "hi Statement" s:GuiFg(s:red)  s:GuiAttr("bold")
execute "hi Conditional" s:GuiFg(s:red)  s:GuiAttr("bold")
execute "hi Type" s:GuiFg(s:blue) s:GuiAttr("NONE")
execute "hi Structure" s:GuiFg(s:red) s:GuiAttr("NONE")
execute "hi StorageClass" s:GuiFg(s:red)
execute "hi PreProc" s:GuiFg(s:blue) s:GuiAttr("bold")
execute "hi PreCondit" s:GuiFg(s:blue)  s:GuiAttr("bold")
execute "hi Comment" s:GuiFg(s:silver5) s:GuiAttr("NONE")
execute "hi Function" s:GuiFg(s:blue)
execute "hi Identifier" s:GuiFg(s:blue)
execute "hi Special" s:GuiFg(s:silver1)
execute "hi Constant" s:GuiFg(s:blue)
execute "hi Number" s:GuiFg(s:blue)
execute "hi String" s:GuiFg(s:silver4)
execute "hi Title" s:GuiFg(s:black)  s:GuiAttr("bold")
execute "hi Todo" s:GuiFg(s:silver2) s:GuiBg(s:silver7)
execute "hi Error" s:GuiFg(s:red) s:GuiBg("bg") s:GuiAttr("underline")
execute "hi Directory" s:GuiFg(s:silver2)
execute "hi ErrorMsg" s:GuiFg(s:red) s:GuiBg("bg")
execute "hi WarningMsg" s:GuiFg(s:silver0) s:GuiBg("bg")
execute "hi ModeMsg" s:GuiFg(s:blue) s:GuiBg("bg") s:GuiAttr("bold")
execute "hi Question" s:GuiFg(s:silver1) s:GuiBg("bg")
execute "hi QuickFixLine" s:GuiFg(s:red) s:GuiBg("bg") s:GuiAttr("bold")
execute "hi qfFileName" s:GuiFg(s:blue)
execute "hi qfLineNr" s:GuiFg(s:red)
highlight! link qfSeparator Normal

" Filetype VIM
execute "hi vimCommentTitle" s:GuiFg(s:blue)  s:GuiAttr("bold")

" Filetype C
execute "hi cCppOut" s:GuiBg(s:silver9) s:GuiAttr("NONE")
execute "hi cCppOutIf2" s:GuiBg(s:silver9) s:GuiAttr("NONE")
execute "hi cParen" s:GuiFg(s:silver3)
execute "hi cBlock" s:GuiFg(s:silver3)

" filetype HTML
execute "hi htmlH1" s:GuiFg(s:blue)  s:GuiAttr("bold")
execute "hi htmlH2" s:GuiFg(s:blue)  s:GuiAttr("bold")
execute "hi htmlH3" s:GuiFg(s:blue)  s:GuiAttr("bold")

" markdown
execute "hi markdownCode" s:GuiFg(s:silver3) s:GuiBg(s:silver9)
execute "hi markdownCodeBlock" s:GuiFg(s:silver2)
execute "hi rstEmphasis" s:GuiFg(s:silver2)
execute "hi rstStrongEmphasis" s:GuiFg(s:silver2)  s:GuiAttr("bold")

" Diffs
execute "hi DiffChange" s:GuiFg(s:white) s:GuiBg(s:blue)
execute "hi DiffText" s:GuiFg(s:white) s:GuiBg(s:blue)
execute "hi DiffDelete" s:GuiFg(s:red) s:GuiBg(s:red)
execute "hi DiffAdd" s:GuiFg(s:silver3) s:GuiBg(s:silver8)
