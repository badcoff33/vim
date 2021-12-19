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
let s:black   = '#18181F'
let s:bg1     = '#20202C'
let s:bg2     = '#303039'
let s:bg3     = '#343440'
let s:bg4     = '#484855'
let s:bg5     = '#505063'
let s:silver1 = '#505860'
let s:silver2 = '#9098A0'
let s:silver3 = '#C0CBD0'
let s:silver4 = '#E8E8FE'
let s:green1  = '#256325'
let s:green2  = '#30A840'
let s:green3  = '#20D025'
let s:green4  = '#47FF47'
let s:blue1   = '#7080A8'
let s:blue2   = '#A0A0E0'
let s:blue3   = '#B0C0F0'
let s:red1    = '#C85012'
let s:red2    = '#F86020'

let s:GuiFg = {str -> empty(str) ? "":"guifg=".str}
let s:GuiBg = {str -> empty(str) ? "":"guibg=".str}
let s:GuiAttr = {str -> empty(str) ? "":"gui=".str}

" Basics
execute 'hi Normal' s:GuiFg(s:silver3) s:GuiBg(s:bg1) s:GuiAttr('NONE')
execute 'hi Bold' s:GuiFg(s:silver2)  s:GuiAttr('bold')
execute 'hi Italic' s:GuiFg(s:silver2)  s:GuiAttr('italic')
execute 'hi NonText' s:GuiFg(s:blue1) s:GuiBg(s:bg2)
execute 'hi Visual' s:GuiFg(s:white) s:GuiBg(s:blue1)
execute 'hi Terminal' s:GuiFg(s:blue2) s:GuiBg(s:bg2)
execute 'hi StatusLine' s:GuiFg(s:white) s:GuiBg(s:blue1) s:GuiAttr('NONE')
execute 'hi StatusLineNC' s:GuiFg(s:silver3) s:GuiBg(s:bg4)
execute 'hi VertSplit' s:GuiFg(s:bg5) s:GuiBg(s:bg2) s:GuiAttr('NONE')
execute 'hi IncSearch' s:GuiFg(s:black) s:GuiBg(s:silver4)
execute 'hi Search' s:GuiFg(s:green4) s:GuiBg(s:green1)
execute 'hi MatchParen' s:GuiFg(s:green3) s:GuiBg('bg') s:GuiAttr('underline')
execute 'hi QuickFixLine'  s:GuiBg(s:black) s:GuiAttr('bold')
execute 'hi Cursor' s:GuiFg(s:black) s:GuiBg(s:silver3)
execute 'hi CursorLine' s:GuiFg('skip') s:GuiBg(s:bg3)
execute 'hi CursorLineNr' s:GuiFg(s:green2) s:GuiBg(s:bg4) s:GuiAttr('bold')
execute 'hi LineNr' s:GuiFg(s:silver3)

execute 'hi PMenuSel' s:GuiFg(s:white) s:GuiBg(s:blue2) s:GuiAttr('NONE')
execute 'hi PMenu' s:GuiFg(s:white) s:GuiBg(s:blue1) s:GuiAttr('NONE')
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
highlight! link TabLineFill Normal
highlight! link TabLine StatusLineNC
highlight! link TabLineSel StatusLine
highlight! link WildMenu IncSearch

" Apollo specific
execute 'hi BlendDown' s:GuiFg(s:white) s:GuiBg(s:bg2)

" Code
execute 'hi Statement' s:GuiFg(s:silver2)
execute 'hi Conditional' s:GuiFg(s:silver3)  s:GuiAttr('bold')
execute 'hi Type' s:GuiFg(s:green2) s:GuiBg('skip') s:GuiAttr('NONE')
execute 'hi Structure' s:GuiFg(s:green2)
execute 'hi StorageClass' s:GuiFg(s:blue1)
execute 'hi PreProc' s:GuiFg(s:blue2) s:GuiBg('skip') s:GuiAttr('bold')
execute 'hi PreCondit' s:GuiFg(s:blue1)  s:GuiAttr('bold')
execute 'hi Comment' s:GuiFg(s:green2) s:GuiBg('skip')
execute 'hi Function' s:GuiFg(s:green3)
execute 'hi Identifier' s:GuiFg(s:green4) s:GuiBg('skip')
execute 'hi Special' s:GuiFg(s:green3) s:GuiBg('skip')
execute 'hi Constant' s:GuiFg(s:blue3) s:GuiBg('skip')
execute 'hi Number' s:GuiFg(s:blue2)
execute 'hi Title' s:GuiFg(s:green3)
execute 'hi Todo' s:GuiFg(s:silver2) s:GuiBg(s:bg3)
execute 'hi Error' s:GuiFg(s:red1) s:GuiBg(s:bg3)
execute 'hi Directory' s:GuiFg(s:silver4)  s:GuiAttr('underline')
execute 'hi ErrorMsg' s:GuiFg(s:red1) s:GuiBg('bg')
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
execute 'hi markdownCode' s:GuiFg(s:silver2) s:GuiBg(s:bg3)
execute 'hi markdownCodeBlock' s:GuiFg(s:silver2)
execute 'hi markdownUrl' s:GuiFg(s:silver2) s:GuiBg(s:bg3) s:GuiAttr('underline')
execute 'hi markdownLinkText' s:GuiFg(s:blue2)  s:GuiAttr('none')

" restructured text
execute 'hi rstEmphasis' s:GuiFg(s:green2)
execute 'hi rstStrongEmphasis' s:GuiFg(s:green2)  s:GuiAttr('bold')

" Diffs
execute 'hi DiffChange' s:GuiFg(s:white) s:GuiBg(s:bg4)
execute 'hi DiffText' s:GuiFg(s:blue2) s:GuiBg(s:bg4) s:GuiAttr('bold')
execute 'hi DiffDelete' s:GuiFg(s:red1) s:GuiBg(s:bg4)
execute 'hi DiffAdd' s:GuiFg(s:green2) s:GuiBg(s:bg3) s:GuiAttr('bold')
