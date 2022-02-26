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

let s:bg1     = '#10203F'
let s:bg2     = '#1A2B4F'
let s:bg3     = '#344468'
let s:bg4     = '#48506F'
let s:silver1 = '#505860'
let s:silver2 = '#9098A0'
let s:silver3 = '#C0CBDF'
let s:silver4 = '#E0E8FE'
let s:green1  = '#22B363'
let s:green2  = '#30C15F'
let s:green3  = '#32E060'
let s:green4  = '#37FF6F'
let s:amber   = '#C8C020'
let s:blue1   = '#5088D0'
let s:blue2   = '#60A0E8'
let s:blue3   = '#70B0F8'
let s:red1    = '#B82042'
let s:red2    = '#E84070'

let s:GuiFg = {str -> empty(str) ? "":"guifg=".str}
let s:GuiBg = {str -> empty(str) ? "":"guibg=".str}
let s:GuiAttr = {str -> empty(str) ? "":"gui=".str}

" Basics
execute 'hi Normal' s:GuiFg(s:silver3) s:GuiBg(s:bg1) s:GuiAttr('NONE')
execute 'hi Bold' s:GuiFg(s:silver2)  s:GuiAttr('bold')
execute 'hi Italic' s:GuiFg(s:silver2)  s:GuiAttr('italic')
execute 'hi NonText' s:GuiFg(s:blue1) s:GuiBg(s:bg1)
execute 'hi Visual' s:GuiFg(s:white) s:GuiBg(s:bg4)
execute 'hi Terminal' s:GuiFg(s:blue2) s:GuiBg(s:bg2)
execute 'hi StatusLine' s:GuiFg(s:white) s:GuiBg(s:blue1) s:GuiAttr('NONE')
execute 'hi StatusLineNC' s:GuiFg(s:silver3) s:GuiBg(s:bg4) s:GuiAttr('NONE')
execute 'hi VertSplit' s:GuiFg(s:bg2) s:GuiBg(s:bg2) s:GuiAttr('NONE')
execute 'hi IncSearch' s:GuiFg(s:black) s:GuiBg(s:silver4) s:GuiAttr('bold')
execute 'hi Search' s:GuiFg(s:white) s:GuiBg(s:blue1) s:GuiAttr('NONE')
execute 'hi MatchParen' s:GuiFg(s:green3) s:GuiBg('bg') s:GuiAttr('underline')
execute 'hi QuickFixLine'  s:GuiBg(s:bg3) s:GuiAttr('bold')
execute 'hi Cursor' s:GuiFg(s:black) s:GuiBg(s:amber)
execute 'hi CursorLine'  s:GuiBg(s:bg2)
execute 'hi CursorLineNr' s:GuiFg(s:green3) s:GuiBg(s:bg3) s:GuiAttr('bold')
execute 'hi LineNr' s:GuiFg(s:blue1) s:GuiBg(s:bg1)
execute 'hi LineNrAbove' s:GuiFg(s:blue1) s:GuiBg(s:bg2)

highlight! link TabLineSel Normal
highlight! link TabLineFill Normal
highlight! link TabLine Normal
execute 'hi TabLineSel' s:GuiAttr('underline,bold')

execute 'hi PMenuSel' s:GuiFg(s:white) s:GuiBg(s:green1) s:GuiAttr('NONE')
execute 'hi PMenu' s:GuiFg(s:white) s:GuiBg(s:blue3) s:GuiAttr('NONE')
execute 'hi PMenuSbar' s:GuiFg(s:silver3) s:GuiBg(s:bg3)
execute 'hi PMenuThumb' s:GuiFg(s:blue2) s:GuiBg(s:bg4)
highlight! link User1 StatusLine
highlight! link User2 StatusLine
highlight! link User3 StatusLine
highlight! link User4 StatusLine
highlight! link CursorColumn CursorLine
highlight! link FoldColumn LineNr
highlight! link Folded StatusLineNC
highlight! link StatusLineTerm StatusLine
highlight! link StatusLineTermNC StatusLineNC
highlight! link SignColumn LineNr
highlight! link WildMenu IncSearch

" Apollo specific
execute 'hi BlendDown' s:GuiFg(s:white) s:GuiBg(s:bg2)

" Code
execute 'hi Statement' s:GuiFg(s:blue3)
execute 'hi Conditional' s:GuiFg(s:blue3)  s:GuiAttr('bold')
execute 'hi Type' s:GuiFg(s:blue2)  s:GuiAttr('italic')
execute 'hi Structure' s:GuiFg(s:blue2)
execute 'hi StorageClass' s:GuiFg(s:blue3)
execute 'hi PreProc' s:GuiFg(s:white)  s:GuiAttr('bold')
execute 'hi PreCondit' s:GuiFg(s:white)  s:GuiAttr('NONE')
execute 'hi Define' s:GuiFg(s:blue2)  s:GuiAttr('NONE')
execute 'hi Comment' s:GuiFg(s:green3)
execute 'hi Function' s:GuiFg(s:blue3) s:GuiAttr('bold')
execute 'hi Identifier' s:GuiFg(s:silver3)
execute 'hi Special' s:GuiFg(s:green2)
execute 'hi Constant' s:GuiFg(s:white)
execute 'hi Number' s:GuiFg(s:white)
execute 'hi Title' s:GuiFg(s:green3)
execute 'hi Todo' s:GuiFg(s:silver2) s:GuiBg(s:bg3)
execute 'hi Error' s:GuiFg(s:red2) s:GuiBg(s:bg3)
execute 'hi Directory' s:GuiFg(s:silver4)  s:GuiAttr('underline')
execute 'hi ErrorMsg' s:GuiFg(s:red2) s:GuiBg('bg')
execute 'hi WarningMsg' s:GuiFg(s:blue1) s:GuiBg('bg')
execute 'hi ModeMsg' s:GuiFg(s:silver2) s:GuiBg('bg')
execute 'hi Question' s:GuiFg(s:green2) s:GuiBg('bg')
execute 'hi qfFileName' s:GuiFg(s:blue2)
execute 'hi qfSeparator' s:GuiFg('fg')
highlight! link qfLineNr    LineNr

" Filetype VIM
execute 'hi vimCommentTitle' s:GuiFg(s:white)  s:GuiAttr('bold')

" Filetype C
execute 'hi cCppOut' s:GuiFg(s:silver3)
execute 'hi cCppOutIf2' s:GuiFg(s:silver3)
execute 'hi cParen' s:GuiFg(s:silver3)
execute 'hi cBlock' s:GuiFg(s:silver3)

" filetype HTML
execute 'hi htmlH1' s:GuiFg(s:green4)  s:GuiAttr('bold')
execute 'hi htmlH2' s:GuiFg(s:green3)  s:GuiAttr('bold')
execute 'hi htmlH3' s:GuiFg(s:green2)  s:GuiAttr('bold')

" markdown
execute 'hi markdownCode' s:GuiFg(s:silver3) s:GuiBg(s:bg3)
execute 'hi markdownCodeBlock' s:GuiFg(s:silver2)
execute 'hi markdownUrl' s:GuiFg(s:silver2) s:GuiBg(s:bg3) s:GuiAttr('underline')
execute 'hi markdownLinkText' s:GuiFg(s:blue2)  s:GuiAttr('none')

" restructured text
execute 'hi rstEmphasis' s:GuiFg(s:green2)
execute 'hi rstStrongEmphasis' s:GuiFg(s:green2)  s:GuiAttr('bold')

" Diffs
execute 'hi DiffChange' s:GuiFg(s:white) s:GuiBg(s:bg4)
execute 'hi DiffText' s:GuiFg(s:blue2) s:GuiBg(s:bg4) s:GuiAttr('bold')
execute 'hi DiffDelete' s:GuiFg(s:red1) s:GuiBg(s:red1)
execute 'hi DiffAdd' s:GuiFg(s:green2) s:GuiBg(s:bg3) s:GuiAttr('bold')
