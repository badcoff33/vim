" A Vim color theme
" Intro: Apollo tries to be a less-is-more color theme. It uses less colors to
" gain better readability and colorful clutter. But the temptation was too
" strong: I added some blueish and greenish colors to make thins not too
" boring. Enjoy!
" Name: Apollo
" Maintainer: Markus Prepens

if exists("syntax_on")
   syntax reset
endif

hi clear
set background=dark
let g:colors_name = "apollo"

let s:white   = '#FFFFFF'
let s:black   = '#000000'

let s:bg1      = "#132443"
let s:bg2      = "#263154"
let s:bg3      = "#344468"
let s:bg4      = "#48506F"
let s:silver1  = "#A0A0A8"
let s:silver2  = "#B8B8BE"
let s:silver3  = "#D0D0D8"
let s:silver4  = "#E0E0E8"
let s:green_bg = "#1D683C"
let s:green1   = "#22A358"
let s:green2   = "#27C168"
let s:green3   = "#27F070"
let s:blue_bg  = "#1B507F"
let s:blue1    = "#3068B8"
let s:blue2    = "#4090D8"
let s:blue3    = "#70B0F8"
let s:red1     = "#B82042"
let s:red2     = "#E84070"
let s:sun    = "#B0BF40"

let Fg = { str -> empty(str) ? "" : "guifg=" .. str }
let Bg = { str -> empty(str) ? "" : "guibg=" .. str }
let Attr = { str -> empty(str) ? "" : "gui=" .. str }
let Cterm = { str -> empty(str) ? "" : "cterm=" .. str }

" Basics
execute "hi Bold" Fg(s:silver2)  Attr("bold")
execute "hi Cursor" Fg(s:black) Bg(s:green3)
execute "hi CursorLine"  Bg(s:bg2) Cterm("NONE")
execute "hi CursorLineNr" Fg(s:green3) Bg(s:bg3) Attr("bold")
execute "hi ErrorMsg" Fg(s:white) Bg(s:red2)
execute "hi IncSearch" Fg(s:black) Bg(s:green1) Attr("NONE") Cterm("NONE")
execute "hi Italic" Fg(s:silver2)  Attr("NONE")
execute "hi LineNr" Fg(s:blue3) Bg(s:bg2)
execute "hi LineNrAbove" Fg(s:bg4) Bg("bg") Attr("bold")
execute "hi LineNrBelow" Fg(s:bg4) Bg("bg") Attr("bold")
execute "hi MatchParen" Fg(s:green3) Bg("bg") Attr("underline")
execute "hi ModeMsg" Fg(s:silver2) Bg("bg")
execute "hi NonText" Fg(s:blue1) Bg(s:bg1)
execute "hi Normal" Fg(s:silver4) Bg(s:bg1) Attr("NONE")
execute "hi Pmenu" Fg(s:white) Bg(s:blue1) Attr("NONE")
execute "hi PmenuSbar" Fg(s:silver3) Bg(s:bg3)
execute "hi PmenuSel" Fg(s:white) Bg(s:green1) Attr("NONE")
execute "hi PmenuThumb" Fg(s:blue2) Bg(s:bg4)
execute "hi Question" Fg(s:green2) Bg("bg")
execute "hi QuickFixLine" Fg(s:blue3) Bg("bg") Attr("bold")
execute "hi Search" Fg(s:silver4) Bg(s:bg4) Attr("NONE")
execute "hi StatusLine" Fg(s:black) Bg(s:blue3) Attr("NONE") Cterm("NONE")
execute "hi StatusLineNC" Fg(s:silver4) Bg(s:bg3) Attr("NONE") Cterm("NONE")
execute "hi Terminal" Fg(s:green3) Bg(s:bg1)
execute "hi Title" Fg(s:green3)
execute "hi User1" Fg(s:sun) Bg(s:blue_bg) Attr("bold")
execute "hi User2" Fg(s:black) Bg(s:sun)
execute "hi VertSplit" Fg(s:bg2) Bg(s:bg2) Attr("NONE")
execute "hi Visual" Bg(s:bg3)
execute "hi WarningMsg" Fg(s:white) Bg(s:blue1)
execute "hi qfFileName" Fg(s:blue2)
execute "hi qfSeparator" Fg("fg")

highlight! link CursorColumn CursorLine
highlight! link FoldColumn Normal
highlight! link Folded Normal
highlight! link SignColumn Normal
highlight! link StatusLineTerm StatusLine
highlight! link StatusLineTermNC StatusLineNC
highlight! link TabLineSel StatusLine
highlight! link TabLine StatusLineNC
highlight! link TabLineFill StatusLineNC
highlight! link User3 StatusLine
highlight! link User4 StatusLine
highlight! link WildMenu IncSearch
highlight! link qfLineNr LineNr
highlight! link CurSearch IncSearch

" Code
execute "hi Statement" Fg(s:blue3)
execute "hi Conditional" Fg(s:blue3)  Attr("bold")
execute "hi Type" Fg(s:green3)  Attr("NONE")
execute "hi Structure" Fg(s:blue2)
execute "hi StorageClass" Fg(s:blue3)
execute "hi PreProc" Fg(s:white)  Attr("bold")
execute "hi PreCondit" Fg(s:blue1)  Attr("bold")
execute "hi Define" Fg(s:blue2)  Attr("NONE")
execute "hi Comment" Fg(s:green3)
execute "hi Function" Fg(s:blue3) Attr("bold")
execute "hi Identifier" Fg(s:green3)
execute "hi Special" Fg(s:green2)
execute "hi Constant" Fg(s:white)
execute "hi Number" Fg(s:white)
execute "hi Todo" Fg(s:silver2) Bg(s:bg3)
execute "hi Error" Fg(s:red2) Bg(s:bg3)
execute "hi Directory" Fg(s:blue3)  Attr("underline")

" Filetype VIM
execute "hi vimCommentTitle" Fg(s:white)  Attr("bold")

" Filetype C
execute "hi cCppOut" Fg(s:silver3)
execute "hi cCppOutIf2" Fg(s:silver3)
execute "hi cParen" Fg(s:silver3)
execute "hi cBlock" Fg(s:silver3)

" filetype HTML
execute "hi htmlH1" Fg(s:green3)  Attr("bold")
execute "hi htmlH2" Fg(s:green3)  Attr("bold")
execute "hi htmlH3" Fg(s:green2)  Attr("bold")

" markdown
execute "hi markdownCode" Fg(s:silver3) Bg(s:bg3)
execute "hi markdownCodeBlock" Fg(s:silver2)
execute "hi markdownUrl" Fg(s:silver2) Bg(s:bg3) Attr("underline")
execute "hi markdownLinkText" Fg(s:blue2)  Attr("NONE")

" restructured text
execute "hi rstEmphasis" Fg(s:green2)
execute "hi rstStrongEmphasis" Fg(s:green2)  Attr("bold")

" Diffs
execute "hi DiffChange" Fg(s:white) Bg(s:bg4)
execute "hi DiffText" Fg(s:blue2) Bg(s:bg4) Attr("bold")
execute "hi DiffDelete" Fg(s:red1) Bg(s:red1)
execute "hi DiffAdd" Fg(s:green2) Bg(s:bg3) Attr("bold")

unlet Fg
unlet Bg
unlet Attr
unlet Cterm

