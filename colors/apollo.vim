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
let s:green1  = '#357365'
let s:green2  = '#50A860'
let s:green3  = '#20D025'
let s:green4  = '#47FF47'
let s:blue1   = '#7080A8'
let s:blue2   = '#A0A0E0'
let s:blue3   = '#B0C0F0'
let s:red1    = '#C85012'
let s:red2    = '#F86020'

" Basics
call color#Hi('Normal', s:silver3, s:bg1, 'NONE', '')
call color#Hi('Bold',   s:silver2, '', 'bold', '')
call color#Hi('Italic', s:silver2, '', 'italic', '')
call color#Hi('NonText', s:blue1, s:bg2, '', '')
call color#Hi('Visual', s:white, s:blue1, '', '')
call color#Hi('Terminal', s:blue2, s:bg2, '', '')
call color#Hi('StatusLine', s:white, s:bg5, '', '')
call color#Hi('StatusLineNC', s:silver3, s:bg4, '',  '')
call color#Hi('VertSplit', s:bg5, s:bg2, 'NONE', '')
call color#Hi('IncSearch', s:black, s:silver4, '', '')
call color#Hi('Search', s:white, s:silver1, '', '')
call color#Hi('MatchParen', s:green3, '', 'underline', '')
call color#Hi('QuickFixLine', '', s:black, 'bold', '')
call color#Hi('Cursor', s:black, s:silver3, '', '')
call color#Hi('CursorLine', 'skip', s:bg3, '', '')
call color#Hi('CursorLineNr', s:green2, s:bg4, 'bold', '')
call color#Hi('LineNr', s:silver3, '', '', '')

call color#Hi("PMenuSel", s:white, s:blue2, "NONE", "")
call color#Hi("PMenu", s:white, s:blue1, "NONE", "")
call color#Hi("PMenuSbar", s:silver3, s:bg3, "", "")
call color#Hi("PMenuThumb", s:blue2, s:bg4, "", "")
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
call color#Hi('BlendDown', s:white, s:bg2, '', '')

" Code
call color#Hi('Statement', s:silver2, '', '', '')
call color#Hi('Conditional', s:silver3, '', 'bold', '')
call color#Hi('Type', s:white, 'skip', '', '')
call color#Hi('Structure', s:green2, '', '', '')
call color#Hi('StorageClass', s:blue1, '', '', '')
call color#Hi('PreProc', s:blue2, 'skip', 'bold', '')
call color#Hi('PreCondit', s:blue1, '', 'bold', '')
call color#Hi('Comment', s:green2, 'skip', '', '')
call color#Hi('Function', s:green3, '', '', '')
call color#Hi('Identifier', s:green4, 'skip', '', '')
call color#Hi('Special', s:green3, 'skip', '', '')
call color#Hi('Constant', s:blue3, 'skip', '', '')
call color#Hi('Number', s:blue2, '', '', '')
call color#Hi('Title', s:green3, '', '', '')
call color#Hi('Todo', s:silver2, s:bg3, '', '')
call color#Hi('Error', s:red1, s:bg3, '', '')
call color#Hi('Directory', s:silver4, '', 'underline', '')
call color#Hi('ErrorMsg', s:red1, 'bg', '', '')
call color#Hi('WarningMsg', s:blue1, 'bg', '', '')
call color#Hi('ModeMsg', s:silver2, 'bg', '', '')
call color#Hi('Question', s:green2, 'bg', '', '')
call color#Hi('qfFileName', s:blue2, '', '', '')
call color#Hi('qfSeparator', 'fg', '', '', '')
highlight! link qfLineNr    LineNr

" Filetype VIM
call color#Hi('vimCommentTitle', s:white, '', 'bold', '')

" Filetype C
call color#Hi('cCppOut', s:silver3, '', '', '')
call color#Hi('cCppOutIf2', s:silver3, '', '', '')
call color#Hi('cParen', s:silver3, '', '', '')
call color#Hi('cBlock', s:silver3, '', '', '')

" filetype HTML
call color#Hi('htmlH1', s:green4, '', 'bold', '')
call color#Hi('htmlH2', s:green3, '', 'bold', '')
call color#Hi('htmlH3', s:green2, '', 'bold', '')

" markdown
call color#Hi('markdownCode', s:silver2, s:bg3, '', '')
call color#Hi('markdownCodeBlock', s:silver2, '', '', '')
call color#Hi('markdownUrl', s:silver2, s:bg3, 'underline', '')
call color#Hi('markdownLinkText', s:blue2, '', 'none', '')

" restructured text
call color#Hi('rstEmphasis', s:green2, '', '', '')
call color#Hi('rstStrongEmphasis', s:green2, '', 'bold', '')

" Diffs
call color#Hi('DiffChange', s:white, s:bg4, '', '')
call color#Hi('DiffText', s:blue2, s:bg4, 'bold', '')
call color#Hi('DiffDelete', s:red1, s:bg4, '', '')
call color#Hi('DiffAdd', s:green2, s:bg3, 'bold', '')
