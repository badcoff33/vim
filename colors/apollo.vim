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

if exists('&wincolor')
  augroup Wincolor
    au!
    " Low-key colors for non-file buffers
    autocmd BufWinEnter,WinEnter * if &readonly
          \ | set wincolor=BlendDown | else | set wincolor= | endif
  augroup END
elseif exists('&winhighlight')
  augroup Winhighlight
    au!
    " Low-key colors for non-file buffers
    autocmd BufWinEnter,WinEnter * if &readonly
          \ | set winhighlight=Normal:BlendDown | set winhighlight= | endif
  augroup END
endif

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

let GuiFg = {str -> empty(str) ? "":"guifg=".str}
let GuiBg = {str -> empty(str) ? "":"guibg=".str}
let GuiAttr = {str -> empty(str) ? "":"gui=".str}

" Basics
execute 'hi Normal' GuiFg(s:silver3) GuiBg(s:bg1) GuiAttr('NONE')
execute 'hi Bold' GuiFg(s:silver2)  GuiAttr('bold')
execute 'hi Italic' GuiFg(s:silver2)  GuiAttr('italic')
execute 'hi NonText' GuiFg(s:blue1) GuiBg(s:bg2)
execute 'hi Visual' GuiFg(s:white) GuiBg(s:blue1)
execute 'hi Terminal' GuiFg(s:blue2) GuiBg(s:bg2)
execute 'hi StatusLine' GuiFg(s:white) GuiBg(s:blue1) GuiAttr('NONE')
execute 'hi StatusLineNC' GuiFg(s:silver3) GuiBg(s:bg4)
execute 'hi VertSplit' GuiFg(s:bg5) GuiBg(s:bg2) GuiAttr('NONE')
execute 'hi IncSearch' GuiFg(s:black) GuiBg(s:silver4)
execute 'hi Search' GuiFg(s:green4) GuiBg(s:green1)
execute 'hi MatchParen' GuiFg(s:green3) GuiBg('bg') GuiAttr('underline')
execute 'hi QuickFixLine'  GuiBg(s:black) GuiAttr('bold')
execute 'hi Cursor' GuiFg(s:black) GuiBg(s:silver3)
execute 'hi CursorLine' GuiFg('skip') GuiBg(s:bg3)
execute 'hi CursorLineNr' GuiFg(s:green2) GuiBg(s:bg4) GuiAttr('bold')
execute 'hi LineNr' GuiFg(s:silver3)

execute 'hi PMenuSel' GuiFg(s:white) GuiBg(s:blue2) GuiAttr('NONE')
execute 'hi PMenu' GuiFg(s:white) GuiBg(s:blue1) GuiAttr('NONE')
execute 'hi PMenuSbar' GuiFg(s:silver3) GuiBg(s:bg3)
execute 'hi PMenuThumb' GuiFg(s:blue2) GuiBg(s:bg4)
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
execute 'hi BlendDown' GuiFg(s:white) GuiBg(s:bg2)

" Code
execute 'hi Statement' GuiFg(s:silver2)
execute 'hi Conditional' GuiFg(s:silver3)  GuiAttr('bold')
execute 'hi Type' GuiFg(s:green2) GuiBg('skip') GuiAttr('NONE')
execute 'hi Structure' GuiFg(s:green2)
execute 'hi StorageClass' GuiFg(s:blue1)
execute 'hi PreProc' GuiFg(s:blue2) GuiBg('skip') GuiAttr('bold')
execute 'hi PreCondit' GuiFg(s:blue1)  GuiAttr('bold')
execute 'hi Comment' GuiFg(s:green2) GuiBg('skip')
execute 'hi Function' GuiFg(s:green3)
execute 'hi Identifier' GuiFg(s:green4) GuiBg('skip')
execute 'hi Special' GuiFg(s:green3) GuiBg('skip')
execute 'hi Constant' GuiFg(s:blue3) GuiBg('skip')
execute 'hi Number' GuiFg(s:blue2)
execute 'hi Title' GuiFg(s:green3)
execute 'hi Todo' GuiFg(s:silver2) GuiBg(s:bg3)
execute 'hi Error' GuiFg(s:red1) GuiBg(s:bg3)
execute 'hi Directory' GuiFg(s:silver4)  GuiAttr('underline')
execute 'hi ErrorMsg' GuiFg(s:red1) GuiBg('bg')
execute 'hi WarningMsg' GuiFg(s:blue1) GuiBg('bg')
execute 'hi ModeMsg' GuiFg(s:silver2) GuiBg('bg')
execute 'hi Question' GuiFg(s:green2) GuiBg('bg')
execute 'hi qfFileName' GuiFg(s:blue2)
execute 'hi qfSeparator' GuiFg('fg')
highlight! link qfLineNr    LineNr

" Filetype VIM
execute 'hi vimCommentTitle' GuiFg(s:white)  GuiAttr('bold')

" Filetype C
execute 'hi cCppOut' GuiFg(s:silver3)
execute 'hi cCppOutIf2' GuiFg(s:silver3)
execute 'hi cParen' GuiFg(s:silver3)
execute 'hi cBlock' GuiFg(s:silver3)

" filetype HTML
execute 'hi htmlH1' GuiFg(s:green4)  GuiAttr('bold')
execute 'hi htmlH2' GuiFg(s:green3)  GuiAttr('bold')
execute 'hi htmlH3' GuiFg(s:green2)  GuiAttr('bold')

" markdown
execute 'hi markdownCode' GuiFg(s:silver2) GuiBg(s:bg3)
execute 'hi markdownCodeBlock' GuiFg(s:silver2)
execute 'hi markdownUrl' GuiFg(s:silver2) GuiBg(s:bg3) GuiAttr('underline')
execute 'hi markdownLinkText' GuiFg(s:blue2)  GuiAttr('none')

" restructured text
execute 'hi rstEmphasis' GuiFg(s:green2)
execute 'hi rstStrongEmphasis' GuiFg(s:green2)  GuiAttr('bold')

" Diffs
execute 'hi DiffChange' GuiFg(s:white) GuiBg(s:bg4)
execute 'hi DiffText' GuiFg(s:blue2) GuiBg(s:bg4) GuiAttr('bold')
execute 'hi DiffDelete' GuiFg(s:red1) GuiBg(s:bg4)
execute 'hi DiffAdd' GuiFg(s:green2) GuiBg(s:bg3) GuiAttr('bold')
