" A Vim color theme
" Intro: Great movie -- nice theme
" Name: Tron
" Maintainer: Markus Prepens
"

if exists("syntax_on")
   syntax reset
endif

hi clear
set background=dark
let g:colors_name = "tron"

let s:white        = '#FFFFFF'
let s:black        = '#000000'
let s:fg0          = "#90ACBC"
let s:fg1          = "#5A7387"
let s:fg2          = "#AACCDD"
let s:fg3          = "#BBF0EF"
let s:fg4          = "#CBECFF"
let s:bg0          = "#0A0F11"
let s:bg1          = "#17181b"
let s:bg2          = "#192533"
let s:bg3          = "#1B324B"
let s:bg4          = "#2B4255"
let s:hl_line      = "#101A1F"
let s:bg_hl        = "#2B4255"
let s:vc_r         = "#B62D66"
let s:vc_g         = "#4BB5BE"
let s:vc_b         = "#387AAA"
let s:key2         = "#9BBDD6"
let s:key3         = "#AAAAAA"
let s:accent       = "#FFFFFF"
let s:mode_line_bg = "#2B4255"
let s:line_num     = "#5A7387"
" TRON palette
let s:yellow       = "#DEB45B"
let s:bluegreen    = "#4BB5BE"
let s:magenta      = "#B62D66"
let s:orange       = "#DEB45B"
let s:red          = "#B62D66"
let s:blue         = "#8Fd4FF"
let s:green        = "#4BB5AE"
let s:lightred     = "#FF7DBB"
let s:lightblue    = "#A0DCFF"
let s:lightgreen   = "#AAF0CF"
let s:red_bg       = "#361016"
let s:blue_bg      = "#040E3F"
let s:green_bg     = "#03353E"
let s:red_bghl     = "#462026"
let s:blue_bghl    = "#243E4F"
let s:green_bghl   = "#23483E"

let s:Fg = {str -> empty(str) ? "":"guifg=" .. str}
let s:Bg = {str -> empty(str) ? "":"guibg=" .. str}
let s:Attr = {str -> empty(str) ? "":"gui=" .. str}
let s:Special = {str -> empty(str) ? "":"guisp=" .. str}

" Basics
execute "hi Bold" s:Fg(s:fg2)  s:Attr("bold")
execute "hi Cursor" s:Fg(s:black) s:Bg(s:white)
execute "hi CursorLine"  s:Bg(s:hl_line)
execute "hi CursorLineNr" s:Fg(s:bluegreen) s:Bg(s:bg3) s:Attr("bold")
execute "hi CurSearch" s:Fg(s:green) s:Bg(s:green_bg) s:Attr("inverse")
execute "hi ErrorMsg" s:Fg(s:orange) s:Bg("bg")
execute "hi IncSearch" s:Fg(s:green_bg) s:Bg(s:yellow) s:Attr("bold")
execute "hi NONE" s:Fg(s:fg2)  s:Attr("NONE")
execute "hi LineNr" s:Fg(s:lightgreen) s:Bg(s:bg2)
execute "hi LineNrAbove" s:Fg(s:bg4) s:Bg("bg") s:Attr("bold")
execute "hi LineNrBelow" s:Fg(s:bg4) s:Bg("bg") s:Attr("bold")
execute "hi MatchParen" s:Fg(s:bluegreen) s:Bg("bg") s:Attr("underline")
execute "hi ModeMsg" s:Fg(s:fg2) s:Bg("bg")
execute "hi NonText" s:Fg(s:magenta) s:Bg(s:bg1)
execute "hi Normal" s:Fg(s:fg4) s:Bg(s:bg1) s:Attr("NONE")
execute "hi NormalFloat" s:Fg(s:yellow) s:Bg(s:green_bg) s:Attr("NONE")
execute "hi NormalNC" s:Fg(s:fg4) s:Bg(s:bg0) s:Attr("NONE")
execute 'hi Pmenu' s:Fg(s:white) s:Bg(s:blue_bg) s:Attr('NONE')
execute 'hi PmenuSbar' s:Fg(s:fg3) s:Bg(s:bg3)
execute 'hi PmenuSel' s:Fg(s:white) s:Bg(s:magenta) s:Attr('NONE')
execute 'hi PmenuThumb' s:Fg(s:blue) s:Bg(s:bg4)
execute "hi Question" s:Fg(s:green) s:Bg("bg")
execute "hi QuickFixLine"  s:Fg(s:yellow) s:Bg("bg") s:Attr("bold")
execute "hi Search" s:Fg(s:green) s:Bg(s:green_bg) s:Attr("none")
execute 'hi StatusLine' s:Fg(s:fg4) s:Bg(s:blue_bghl) s:Attr('NONE')
execute 'hi User1' s:Fg(s:bg1) s:Bg(s:yellow) s:Attr('NONE')
execute 'hi StatusLineNC' s:Fg(s:fg4) s:Bg(s:bg2) s:Attr('NONE')
execute "hi Terminal" s:Fg(s:blue) s:Bg(s:bg2)
execute "hi Title" s:Fg(s:bluegreen)
execute "hi VertSplit" s:Fg(s:bg1) s:Bg(s:bg1) s:Attr("NONE")
execute 'hi Visual' s:Fg(s:blue_bg) s:Bg(s:blue)
execute "hi WarningMsg" s:Fg(s:magenta) s:Bg("bg")
execute "hi qfFileName" s:Fg(s:blue)
execute "hi qfSeparator" s:Fg("fg")

highlight! link CursorColumn CursorLine
highlight! link FoldColumn Normal
highlight! link Folded StatusLineNC
highlight! link SignColumn Normal
highlight! link StatusLineTerm StatusLine
highlight! link StatusLineTermNC StatusLineNC
highlight! link TabLine Normal
highlight! link TabLineFill Normal
highlight! link TabLineSel StatusLine
highlight! link User2 StatusLine
highlight! link User3 StatusLine
highlight! link User4 StatusLine
highlight! link WildMenu IncSearch
highlight! link WinBar StatusLine
highlight! link qfLineNr LineNr

" Code
execute "hi Statement" s:Fg(s:yellow) s:Attr("NONE")
execute "hi Conditional" s:Fg(s:magenta)  s:Attr("bold")
execute "hi Type" s:Fg(s:lightred)  s:Attr("NONE")
execute "hi Structure" s:Fg(s:blue)
execute "hi StorageClass" s:Fg(s:lightgreen)
execute "hi PreProc" s:Fg(s:white)  s:Attr("bold")
execute "hi PreCondit" s:Fg(s:lightgreen)  s:Attr("bold")
execute "hi Define" s:Fg(s:blue)  s:Attr("NONE")
execute "hi Comment" s:Fg(s:bluegreen)
execute "hi Function" s:Fg(s:lightgreen) s:Attr("bold")
execute "hi Identifier" s:Fg(s:fg3)
execute "hi Special" s:Fg(s:green)
execute "hi Constant" s:Fg(s:fg2)
execute "hi Number" s:Fg(s:white)
execute "hi Todo" s:Fg(s:fg2) s:Bg(s:bg3)
execute "hi Error" s:Fg(s:red) s:Bg(s:red_bg)
execute "hi Directory" s:Fg(s:lightgreen) s:Attr("underline") s:Special(s:lightgreen)

" Filetype VIM
execute "hi vimCommentTitle" s:Fg(s:white)  s:Attr("bold")

" Filetype C
execute "hi cCppOut" s:Fg(s:fg3)
execute "hi cCppOutIf2" s:Fg(s:fg3)
execute "hi cParen" s:Fg(s:fg3)
execute "hi cBlock" s:Fg(s:fg3)

" filetype HTML
execute "hi htmlH1" s:Fg(s:orange)  s:Attr("bold")
execute "hi htmlH2" s:Fg(s:orange)  s:Attr("bold")
execute "hi htmlH3" s:Fg(s:orange)  s:Attr("bold")

" markdown
execute "hi markdownCode" s:Fg(s:lightgreen)
execute "hi markdownCodeBlock" s:Fg(s:lightgreen)
execute "hi markdownUrl" s:Fg(s:blue) s:Attr("underline") s:Special(s:blue)
execute "hi markdownLinkText" s:Fg(s:blue)  s:Attr("none")

" restructured text
execute "hi rstEmphasis" s:Fg(s:green)
execute "hi rstStrongEmphasis" s:Fg(s:green)  s:Attr("bold")

" Diffs
execute "hi diffAdded" s:Fg(s:green) s:Bg(s:bg3) s:Attr("bold")
execute "hi diffChanged" s:Fg(s:white) s:Bg(s:bg4)
execute "hi diffRemoved" s:Fg(s:red) s:Bg(s:red)

" Diff Mode
execute "hi DiffText" s:Fg(s:blue) s:Bg(s:bg4) s:Attr("bold")
hi! link DiffAdd diffAdded
hi! link DiffChange diffChange
hi! link DiffDelete diffRemoved
