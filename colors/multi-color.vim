" A Vim color theme
" Maintainer: Markus Prepens

if exists("syntax_on")
   syntax reset
endif

hi clear
set background=dark
let g:colors_name = "multi-color"


let s:black   = "#1b1f23"
let s:white   = "#ffffff"
let s:gray    = ["#fafbfc", "#f6f8fa", "#e1e4e8", "#d1d5da", "#959da5", "#6a737d", "#586069", "#444d56", "#2f363d", "#24292e"]
let s:blue    = ["#f1f8ff", "#dbedff", "#c8e1ff", "#79b8ff", "#2188ff", "#0366d6", "#005cc5", "#044289", "#032f62", "#05264c"]
let s:green   = ["#f0fff4", "#dcffe4", "#bef5cb", "#85e89d", "#34d058", "#28a745", "#22863a", "#176f2c", "#165c26", "#144620"]
let s:yellow  = ["#fffdef", "#fffbdd", "#fff5b1", "#ffea7f", "#ffdf5d", "#ffd33d", "#f9c513", "#dbab09", "#b08800", "#735c0f"]
let s:orange  = ["#fff8f2", "#ffebda", "#ffd1ac", "#ffab70", "#fb8532", "#f66a0a", "#e36209", "#d15704", "#c24e00", "#a04100"]
let s:red     = ["#ffeef0", "#ffdce0", "#fdaeb7", "#f97583", "#ea4a5a", "#d73a49", "#cb2431", "#b31d28", "#9e1c23", "#86181d"]
let s:purple  = ["#f5f0ff", "#e6dcfd", "#d1bcf9", "#b392f0", "#8a63d2", "#6f42c1", "#5a32a3", "#4c2889", "#3a1d6e", "#29134e"]
let s:pink    = ["#ffeef8", "#fedbf0", "#f9b3dd", "#f692ce", "#ec6cb9", "#ea4aaa", "#d03592", "#b93a86", "#99306f", "#6d224f"]

let Fg = { str -> empty(str) ? "" : "guifg=" .. str }
let Bg = { str -> empty(str) ? "" : "guibg=" .. str }
let Attr = { str -> empty(str) ? "" : "gui=" .. str }
let Cterm = { str -> empty(str) ? "" : "cterm=" .. str }

" Basics
execute "hi Bold" Fg(s:gray[2])  Attr("bold")
execute "hi Cursor" Fg(s:black) Bg(s:white)
execute "hi CursorLine"  Bg(s:gray[0]) Cterm("NONE")
execute "hi CursorLineNr" Fg(s:green[3]) Bg(s:gray[0]) Attr("bold")
execute "hi ErrorMsg" Fg(s:red[3]) Bg(s:red[8])
execute "hi IncSearch" Fg(s:black) Bg(s:green[2]) Attr("NONE") Cterm("NONE")
execute "hi Italic" Fg(s:gray[2])  Attr("NONE")
execute "hi LineNr" Fg(s:blue[3]) Bg(s:gray[0])
execute "hi LineNrAbove" Fg(s:gray[0]) Bg("bg") Attr("bold")
execute "hi LineNrBelow" Fg(s:gray[0]) Bg("bg") Attr("bold")
execute "hi MatchParen" Fg(s:green[3]) Bg("bg") Attr("underline")
execute "hi ModeMsg" Fg(s:gray[2]) Bg("bg")
execute "hi NonText" Fg(s:blue[1]) Bg(s:gray[0])
execute "hi Normal" Fg(s:blue[1]) Bg(s:black) Attr("NONE")
execute "hi Pmenu" Fg(s:purple[3]) Bg(s:purple[7]) Attr("NONE")
execute "hi PmenuSbar" Fg(s:gray[3]) Bg(s:gray[8])
execute "hi PmenuSel" Fg(s:purple[1]) Bg(s:purple[9]) Attr("NONE")
execute "hi PmenuThumb" Fg(s:blue[2]) Bg(s:gray[0])
execute "hi Question" Fg(s:green[2]) Bg("bg")
execute "hi QuickFixLine" Fg(s:blue[3]) Bg(s:gray[2]) Attr("NONE")
execute "hi Search" Fg(s:green[9]) Bg(s:green[5]) Attr("bold")
execute "hi StatusLine" Fg(s:black) Bg(s:blue[3]) Attr("NONE") Cterm("NONE")
execute "hi StatusLineNC" Fg(s:gray[4]) Bg(s:gray[0]) Attr("NONE") Cterm("NONE")
execute "hi Terminal" Fg(s:green[3]) Bg(s:black)
execute "hi Title" Fg(s:green[3])
execute "hi User1" Fg(s:black) Bg(s:green[2])
execute "hi User2" Fg(s:black) Bg(s:orange[5])
execute "hi VertSplit" Fg(s:gray[0]) Bg(s:gray[0]) Attr("NONE")
execute "hi Visual" Fg(s:white) Bg(s:pink[9])
execute "hi WarningMsg" Fg(s:white) Bg(s:blue[1])
execute "hi qfFileName" Fg(s:blue[2])
execute "hi qfSeparator" Fg("fg")

highlight! link CursorColumn CursorLine
highlight! link FoldColumn Normal
highlight! link Folded StatusLineNC
highlight! link SignColumn Normal
highlight! link StatusLineTerm StatusLine
highlight! link StatusLineTermNC StatusLineNC
highlight! link TabLineSel StatusLine
highlight! link TabLine StatusLineNC
highlight! link TabLineFill StatusLineNC
highlight! link User3 StatusLine
highlight! link User4 StatusLine
highlight! link WildMenu IncSearch
highlight! link qfLineNr    LineNr

" Code
execute "hi Statement" Fg(s:blue[3])
execute "hi Conditional" Fg(s:blue[3])  Attr("bold")
execute "hi Type" Fg(s:blue[2])  Attr("NONE")
execute "hi Structure" Fg(s:blue[2])
execute "hi StorageClass" Fg(s:blue[3])
execute "hi PreProc" Fg(s:white)  Attr("bold")
execute "hi PreCondit" Fg(s:blue[1])  Attr("bold")
execute "hi Define" Fg(s:blue[2])  Attr("NONE")
execute "hi Comment" Fg(s:green[3])
execute "hi Function" Fg(s:blue[3]) Attr("bold")
execute "hi Identifier" Fg(s:gray[3])
execute "hi Special" Fg(s:green[2])
execute "hi Constant" Fg(s:pink[2])
execute "hi Number" Fg(s:white)
execute "hi Todo" Fg(s:gray[2]) Bg(s:gray[0])
execute "hi Error" Fg(s:red[8]) Bg(s:red[4])
execute "hi Directory" Fg(s:blue[3])  Attr("underline")

" Filetype VIM
execute "hi vimCommentTitle" Fg(s:white)  Attr("bold")

" Filetype C
execute "hi cCppOut" Fg(s:gray[3])
execute "hi cCppOutIf2" Fg(s:gray[3])
execute "hi cParen" Fg(s:gray[3])
execute "hi cBlock" Fg(s:gray[3])

" filetype HTML
execute "hi htmlH1" Fg(s:green[3])  Attr("bold")
execute "hi htmlH2" Fg(s:green[3])  Attr("bold")
execute "hi htmlH3" Fg(s:green[2])  Attr("bold")

" markdown
execute "hi markdownCode" Fg(s:gray[3]) Bg(s:gray[0])
execute "hi markdownCodeBlock" Fg(s:gray[2])
execute "hi markdownUrl" Fg(s:gray[2]) Bg(s:gray[0]) Attr("underline")
execute "hi markdownLinkText" Fg(s:blue[2])  Attr("NONE")

" restructured text
execute "hi rstEmphasis" Fg(s:green[2])
execute "hi rstStrongEmphasis" Fg(s:green[2])  Attr("bold")

" Diffs
execute "hi DiffChange" Fg(s:white) Bg(s:gray[0])
execute "hi DiffText" Fg(s:blue[2]) Bg(s:gray[0]) Attr("bold")
execute "hi DiffDelete" Fg(s:red[1]) Bg(s:red[1])
execute "hi DiffAdd" Fg(s:green[2]) Bg(s:gray[0]) Attr("bold")

unlet Fg
unlet Bg
unlet Attr
unlet Cterm

