" A Vim color theme
" Intro: Apollo tries to be a less-is-more color theme. It uses less colors to
" gain better readability and colorful clutter. But the temptation was too
" strong: I added some blueish and greenish colors to make thins not too
" boring. Enjoy!
" Name: Apollo
" Maintainer: Markus Prepens
"

if exists('syntax_on')
   syntax reset
endif

hi clear
set background=dark
let g:colors_name = 'apollo'

let s:white   = '#FFFFFF'
let s:black   = '#000000'

let s:bg1      = "#132443"
let s:bg2      = "#263154"
let s:bg3      = "#344468"
let s:bg4      = "#48506F"
let s:silver1  = "#505860"
let s:silver2  = "#9098A0"
let s:silver3  = "#C0CBDF"
let s:silver4  = "#E0E8FE"
let s:green_bg = "#206358"
let s:green1   = "#02B360"
let s:green2   = "#07C168"
let s:green3   = "#07E070"
let s:green4   = "#07F88F"
let s:blue_bg  = "#2E4388"
let s:blue1    = "#5088D0"
let s:blue2    = "#60A0E8"
let s:blue3    = "#70B0F8"
let s:red1     = "#B82042"
let s:red2     = "#E84070"
let s:amber    = "#D0CF20"

let s:Fg = {str -> empty(str) ? "":"guifg=".str}
let s:Bg = {str -> empty(str) ? "":"guibg="..str}
let s:Attr = {str -> empty(str) ? "":"gui="..str}
let s:Cterm = {str -> empty(str) ? "":"cterm="..str}

" Basics
execute 'hi Bold' s:Fg(s:silver2)  s:Attr('bold')
execute 'hi Cursor' s:Fg(s:black) s:Bg(s:white)
execute 'hi CursorLine'  s:Bg(s:bg3) s:Cterm('NONE')
execute 'hi CursorLineNr' s:Fg(s:green3) s:Bg(s:bg3) s:Attr('bold')
execute 'hi ErrorMsg' s:Fg(s:red2) s:Bg('bg')
execute 'hi IncSearch' s:Fg(s:black) s:Bg(s:white) s:Attr('bold')
execute 'hi Italic' s:Fg(s:silver2)  s:Attr('NONE')
execute 'hi LineNr' s:Fg(s:blue3) s:Bg(s:bg2)
execute 'hi LineNrAbove' s:Fg(s:bg4) s:Bg('bg') s:Attr('bold')
execute 'hi LineNrBelow' s:Fg(s:bg4) s:Bg('bg') s:Attr('bold')
execute 'hi MatchParen' s:Fg(s:green3) s:Bg('bg') s:Attr('underline')
execute 'hi ModeMsg' s:Fg(s:silver2) s:Bg('bg')
execute 'hi NonText' s:Fg(s:blue1) s:Bg(s:bg1)
execute 'hi Normal' s:Fg(s:silver4) s:Bg(s:bg1) s:Attr('NONE')
execute 'hi Pmenu' s:Fg(s:white) s:Bg(s:blue_bg) s:Attr('NONE')
execute 'hi PmenuSbar' s:Fg(s:silver3) s:Bg(s:bg3)
execute 'hi PmenuSel' s:Fg(s:white) s:Bg(s:blue1) s:Attr('NONE')
execute 'hi PmenuThumb' s:Fg(s:blue2) s:Bg(s:bg4)
execute 'hi Question' s:Fg(s:green2) s:Bg('bg')
execute 'hi QuickFixLine'  s:Fg(s:amber) s:Bg("bg") s:Attr('bold')
execute 'hi Search' s:Fg(s:white) s:Bg(s:blue2) s:Attr('NONE')
execute 'hi StatusLine' s:Fg(s:white) s:Bg(s:bg4) s:Attr('NONE')
execute 'hi StatusLineNC' s:Fg(s:silver3) s:Bg(s:bg2) s:Attr('NONE')
execute 'hi Terminal' s:Fg(s:green2) s:Bg(s:green_bg)
execute 'hi Title' s:Fg(s:green3)
execute 'hi VertSplit' s:Fg(s:bg2) s:Bg(s:bg2) s:Attr('NONE')
execute 'hi Visual' s:Fg(s:white) s:Bg(s:blue_bg)
execute 'hi WarningMsg' s:Fg(s:blue1) s:Bg('bg')
execute 'hi qfFileName' s:Fg(s:blue2)
execute 'hi qfSeparator' s:Fg('fg')
highlight! link CursorColumn CursorLine
highlight! link FoldColumn Normal
highlight! link Folded StatusLineNC
highlight! link SignColumn Normal
highlight! link StatusLineTerm StatusLine
highlight! link StatusLineTermNC StatusLineNC
highlight! link TabLineSel StatusLine
highlight! link TabLine StatusLineNC
highlight! link TabLineFill StatusLineNC
highlight! link User1 StatusLine
highlight! link User2 StatusLine
highlight! link User3 StatusLine
highlight! link User4 StatusLine
highlight! link WildMenu IncSearch
highlight! link qfLineNr    LineNr
" Code
execute 'hi Statement' s:Fg(s:blue3)
execute 'hi Conditional' s:Fg(s:blue3)  s:Attr('bold')
execute 'hi Type' s:Fg(s:blue2)  s:Attr('NONE')
execute 'hi Structure' s:Fg(s:blue2)
execute 'hi StorageClass' s:Fg(s:blue3)
execute 'hi PreProc' s:Fg(s:white)  s:Attr('bold')
execute 'hi PreCondit' s:Fg(s:blue1)  s:Attr('bold')
execute 'hi Define' s:Fg(s:blue2)  s:Attr('NONE')
execute 'hi Comment' s:Fg(s:green3)
execute 'hi Function' s:Fg(s:blue3) s:Attr('bold')
execute 'hi Identifier' s:Fg(s:silver3)
execute 'hi Special' s:Fg(s:green2)
execute 'hi Constant' s:Fg(s:white)
execute 'hi Number' s:Fg(s:white)
execute 'hi Todo' s:Fg(s:silver2) s:Bg(s:bg3)
execute 'hi Error' s:Fg(s:red2) s:Bg(s:bg3)
execute 'hi Directory' s:Fg(s:silver4)  s:Attr('underline')

" Filetype VIM
execute 'hi vimCommentTitle' s:Fg(s:white)  s:Attr('bold')

" Filetype C
execute 'hi cCppOut' s:Fg(s:silver3)
execute 'hi cCppOutIf2' s:Fg(s:silver3)
execute 'hi cParen' s:Fg(s:silver3)
execute 'hi cBlock' s:Fg(s:silver3)

" filetype HTML
execute 'hi htmlH1' s:Fg(s:green4)  s:Attr('bold')
execute 'hi htmlH2' s:Fg(s:green3)  s:Attr('bold')
execute 'hi htmlH3' s:Fg(s:green2)  s:Attr('bold')

" markdown
execute 'hi markdownCode' s:Fg(s:silver3) s:Bg(s:bg3)
execute 'hi markdownCodeBlock' s:Fg(s:silver2)
execute 'hi markdownUrl' s:Fg(s:silver2) s:Bg(s:bg3) s:Attr('underline')
execute 'hi markdownLinkText' s:Fg(s:blue2)  s:Attr('NONE')

" restructured text
execute 'hi rstEmphasis' s:Fg(s:green2)
execute 'hi rstStrongEmphasis' s:Fg(s:green2)  s:Attr('bold')

" Diffs
execute 'hi DiffChange' s:Fg(s:white) s:Bg(s:bg4)
execute 'hi DiffText' s:Fg(s:blue2) s:Bg(s:bg4) s:Attr('bold')
execute 'hi DiffDelete' s:Fg(s:red1) s:Bg(s:red1)
execute 'hi DiffAdd' s:Fg(s:green2) s:Bg(s:bg3) s:Attr('bold')

" clean up
unlet s:Fg s:Bg s:Attr s:Cterm
unlet s:white s:black s:bg1 s:bg2 s:bg3 s:bg4 s:silver1 s:silver2 s:silver3 s:silver4
unlet s:green_bg s:green1 s:green2 s:green3 s:green4
unlet s:blue_bg s:blue1 s:blue2 s:blue3 s:red1 s:red2 s:amber
