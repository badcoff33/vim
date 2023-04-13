" A Vim color theme
" Maintainer: Markus Prepens

if exists("syntax_on")
   syntax reset
endif

hi clear
set background=light
let g:colors_name = "multicolor"


let s:black   = "#1b1f23"
let s:white   = "#ffffff"
let s:gray    = ["#24292e", "#2f363d", "#444d56", "#586069", "#6a737d", "#959da5", "#d1d5da", "#e1e4e8", "#f6f8fa", "#fafbfc", ]
let s:blue    = ["#05264c", "#032f62", "#044289", "#005cc5", "#0366d6", "#2188ff", "#79b8ff", "#c8e1ff", "#dbedff", "#f1f8ff", ]
let s:green   = ["#144620", "#165c26", "#176f2c", "#22863a", "#28a745", "#34d058", "#85e89d", "#bef5cb", "#dcffe4", "#f0fff4", ]
let s:yellow  = ["#735c0f", "#b08800", "#dbab09", "#f9c513", "#ffd33d", "#ffdf5d", "#ffea7f", "#fff5b1", "#fffbdd", "#fffdef", ]
let s:orange  = ["#a04100", "#c24e00", "#d15704", "#e36209", "#f66a0a", "#fb8532", "#ffab70", "#ffd1ac", "#ffebda", "#fff8f2", ]
let s:red     = ["#86181d", "#9e1c23", "#b31d28", "#cb2431", "#d73a49", "#ea4a5a", "#f97583", "#fdaeb7", "#ffdce0", "#ffeef0", ]
let s:purple  = ["#29134e", "#3a1d6e", "#4c2889", "#5a32a3", "#6f42c1", "#8a63d2", "#b392f0", "#d1bcf9", "#e6dcfd", "#f5f0ff", ]
let s:pink    = ["#6d224f", "#99306f", "#b93a86", "#d03592", "#ea4aaa", "#ec6cb9", "#f692ce", "#f9b3dd", "#fedbf0", "#ffeef8", ]

let Fg = { str -> empty(str) ? "" : "guifg=" .. str }
let Bg = { str -> empty(str) ? "" : "guibg=" .. str }
let Attr = { str -> empty(str) ? "" : "gui=" .. str }
let Cterm = { str -> empty(str) ? "" : "cterm=" .. str }

" Basics
execute "hi Bold" Fg(s:gray[2])  Attr("bold")
execute "hi CurSearch" Bg(s:yellow[6]) Attr("NONE")
execute "hi Cursor" Fg(s:black) Bg(s:purple[7])
execute "hi CursorLine" Bg(s:gray[8]) Cterm("NONE")
execute "hi CursorLineNr" Fg(s:green[3]) Bg(s:gray[7]) Attr("bold")
execute "hi ErrorMsg" Fg(s:red[3]) Bg(s:red[8])
execute "hi IncSearch" Fg(s:black) Bg(s:blue[7]) Attr("NONE") Cterm("NONE")
execute "hi Italic" Fg(s:gray[2])  Attr("NONE")
execute "hi LineNr" Fg(s:blue[3]) Bg(s:gray[9]) Attr("bold")
execute "hi LineNrAbove" Fg(s:gray[6]) Bg("bg") Attr("bold")
execute "hi LineNrBelow" Fg(s:gray[6]) Bg("bg") Attr("bold")
execute "hi MatchParen" Fg(s:black) Bg(s:yellow[8]) Attr("bold")
execute "hi ModeMsg" Fg(s:orange[0]) Bg(s:orange[7])
execute "hi NonText" Fg(s:blue[6]) Bg(s:white)
execute "hi Normal" Fg(s:gray[3]) Bg(s:white) Attr("NONE")
execute "hi Pmenu" Fg(s:purple[3]) Bg(s:purple[7]) Attr("NONE")
execute "hi PmenuSbar" Fg(s:gray[3]) Bg(s:gray[8])
execute "hi PmenuSel" Fg(s:purple[8]) Bg(s:purple[4]) Attr("NONE")
execute "hi PmenuThumb" Fg(s:blue[2]) Bg(s:gray[0])
execute "hi Question" Fg(s:orange[3]) Bg(s:orange[8])
execute "hi QuickFixLine" Fg(s:blue[3]) Bg(s:white) Attr("bold")
execute "hi Search" Bg(s:yellow[8]) Attr("NONE")
execute "hi StatusLine" Fg(s:white) Bg(s:purple[1]) Attr("NONE") Cterm("NONE")
execute "hi StatusLineNC" Fg(s:gray[2]) Bg(s:gray[6]) Attr("NONE") Cterm("NONE")
execute "hi Terminal" Fg(s:gray[0]) Bg(s:gray[8])
execute "hi Title" Fg(s:green[3])
execute "hi User1" Fg(s:white) Bg(s:blue[5])
execute "hi User2" Fg(s:white) Bg(s:blue[4])
execute "hi VertSplit" Fg(s:gray[7]) Bg(s:gray[6]) Attr("NONE")
execute "hi Visual" Fg(s:black) Bg(s:blue[8])
execute "hi WarningMsg" Fg(s:green[3]) Bg(s:green[8])
execute "hi qfFileName" Fg(s:blue[4])
execute "hi qfSeparator" Fg("fg")

highlight! link CursorColumn CursorLine
highlight! link FoldColumn Normal
highlight! link Folded Normal
highlight! link SignColumn Normal
highlight! link StatusLineTerm StatusLine
highlight! link StatusLineTermNC StatusLineNC
highlight! link TabLineSel User1
highlight! link TabLine CursorLine
highlight! link TabLineFill Normal
highlight! link User3 StatusLine
highlight! link User4 StatusLine
highlight! link WildMenu IncSearch
highlight! link qfLineNr LineNr

" Code
execute "hi Character" Fg(s:purple[6]) Attr("bold")
execute "hi Comment" Fg(s:green[4])
execute "hi Conditional" Fg(s:pink[3])  Attr("bold")
execute "hi Constant" Fg(s:purple[4])
execute "hi Define" Fg(s:blue[8])  Attr("bold")
execute "hi Directory" Fg(s:blue[3])  Attr("underline")
execute "hi Error" Fg(s:red[3]) Bg(s:red[8])
execute "hi Function" Fg(s:blue[4]) Attr("bold")
execute "hi Identifier" Fg(s:purple[5])
execute "hi Number" Fg(s:purple[4])
execute "hi PreCondit" Fg(s:blue[6])  Attr("bold,italic")
execute "hi PreProc" Fg(s:blue[3])  Attr("bold")
execute "hi Special" Fg(s:green[4])
execute "hi Statement" Fg(s:blue[6])
execute "hi StorageClass" Fg(s:blue[5])
execute "hi String" Fg(s:purple[3])
execute "hi Structure" Fg(s:blue[6])
execute "hi Todo" Fg(s:red[4]) Bg(s:red[9])
execute "hi Type" Fg(s:purple[5])  Attr("NONE")

" Filetype VIM
execute "hi vimCommentTitle" Fg(s:green[1])  Attr("bold")

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
execute "hi markdownCode" Fg(s:gray[5]) Bg(s:gray[8])
execute "hi markdownCodeBlock" Fg(s:gray[5])
execute "hi markdownUrl" Fg(s:gray[2]) Bg(s:gray[0]) Attr("underline")
execute "hi markdownLinkText" Fg(s:blue[2])  Attr("NONE")

" restructured text
execute "hi rstEmphasis" Fg(s:green[2])
execute "hi rstStrongEmphasis" Fg(s:green[2])  Attr("bold")

" Diffs
execute "hi DiffChange" Fg(s:blue[3]) Bg(s:blue[9])
execute "hi DiffText" Fg(s:blue[5]) Bg(s:blue[9]) Attr("bold")
execute "hi DiffDelete" Fg(s:red[5]) Bg(s:red[9])
execute "hi DiffAdd" Fg(s:green[5]) Bg(s:green[9]) Attr("none")

unlet Fg
unlet Bg
unlet Attr
unlet Cterm

