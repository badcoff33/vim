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
let s:bg1     = '#2F2131'
let s:bg2     = '#312A3A'
let s:bg3     = '#343240'
let s:bg4     = '#434050'
let s:silver1 = '#505860'
let s:silver2 = '#9098A0'
let s:silver3 = '#C0CBD0'
let s:silver4 = '#E8E8FE'
let s:green1  = '#309840'
let s:green2  = '#20D055'
let s:green3  = '#47F058'
let s:blue1   = '#6080A8'
let s:blue2   = '#90B0E0'
let s:red1    = '#C85012'
let s:red2    = '#F86020'

" Basics
call lib#color#Hi('Normal', s:white, s:bg2, 'NONE', '')
call lib#color#Hi('Bold',   s:silver4, '', 'bold', '')
call lib#color#Hi('Italic', s:silver4, '', 'italic', '')
call lib#color#Hi('NonText', s:blue1, s:black, '', '')
call lib#color#Hi('Visual', s:black, s:silver3, '', '')
call lib#color#Hi('StatusLine', s:white, s:bg4, 'bold', '')
call lib#color#Hi('StatusLineNC', s:silver2, s:bg4, '',  '')
call lib#color#Hi('VertSplit', s:bg4, 'bg', 'NONE', '')
call lib#color#Hi('IncSearch', s:black, s:silver3, 'bold', '')
call lib#color#Hi('Search', s:blue2, s:bg4, '', '')
call lib#color#Hi('MatchParen', s:green3, '', 'underline', '')
call lib#color#Hi('QuickFixLine', '', s:black, 'bold', '')
call lib#color#Hi('CursorLine', 'skip', s:bg3, '', '')
call lib#color#Hi('CursorLineNr', '', s:bg4, 'bold', '')
call lib#color#Hi('LineNr', s:blue1, '', '', '')

highlight! link CursorColumn CursorLine
highlight! link FoldColumn LineNr
highlight! link Folded StatusLineNC
highlight! link StatusLineTerm StatusLine
highlight! link StatusLineTermNC StatusLineNC
highlight! link PmenuSel IncSearch
highlight! link Pmenu Search
highlight! link PmenuSbar Search
highlight! link PmenuThumb IncSearch
highlight! link SignColumn LineNr
highlight! link TabLineFill Normal
highlight! link TabLine StatusLineNC
highlight! link TabLineSel Statusline
highlight! link WildMenu PmenuSel

" Apollo specific
call lib#color#Hi('BlendDown', s:white, s:bg3, '', '')

" Code
call lib#color#Hi('Statement', s:silver4, '', '', '')
call lib#color#Hi('Conditional', s:silver3, '', 'bold', '')
call lib#color#Hi('Type', s:green2, 'skip', '', '')
call lib#color#Hi('Structure', s:green2, '', '', '')
call lib#color#Hi('StorageClass', s:blue1, '', '', '')
call lib#color#Hi('PreProc', s:blue2, 'skip', 'bold', '')
call lib#color#Hi('PreCondit', s:blue1, '', 'bold', '')
call lib#color#Hi('Comment', s:silver2, 'skip', '', '')
call lib#color#Hi('Function', s:silver3, '', '', '')
call lib#color#Hi('Identifier', s:green2, 'skip', '', '')
call lib#color#Hi('Special', s:green2, 'skip', '', '')
call lib#color#Hi('Constant', s:silver3, 'skip', '', '')
call lib#color#Hi('Number', s:blue2, '', '', '')
call lib#color#Hi('Title', s:green3, '', '', '')
call lib#color#Hi('Todo', s:silver2, s:bg3, '', '')
call lib#color#Hi('Error', s:red1, s:bg3, '', '')
call lib#color#Hi('Directory', s:silver4, '', 'underline', '')
call lib#color#Hi('ErrorMsg', s:red1, 'bg', '', '')
call lib#color#Hi('WarningMsg', s:blue1, 'bg', '', '')
call lib#color#Hi('ModeMsg', s:silver2, 'bg', '', '')
call lib#color#Hi('Question', s:green2, 'bg', '', '')
call lib#color#Hi('qfFileName', s:blue2, '', '', '')
call lib#color#Hi('qfSeparator', 'fg', '', '', '')
highlight! link qfLineNr    LineNr

" Filetype VIM
call lib#color#Hi('vimCommentTitle', s:white, '', 'bold', '')

" Filetype C
call lib#color#Hi('cCppOut', s:silver3, '', '', '')
call lib#color#Hi('cCppOutIf2', s:silver3, '', '', '')
call lib#color#Hi('cParen', s:silver3, '', '', '')
call lib#color#Hi('cBlock', s:silver3, '', '', '')

" filetype HTML
call lib#color#Hi('htmlH1', s:green3, '', 'bold', '')
call lib#color#Hi('htmlH2', s:green3, '', 'bold', '')
call lib#color#Hi('htmlH3', s:green3, '', 'bold,italic', '')

" markdown
call lib#color#Hi('markdownCode', s:silver2, s:bg3, '', '')
call lib#color#Hi('markdownCodeBlock', s:silver2, '', '', '')
call lib#color#Hi('markdownUrl', s:silver2, s:bg3, 'underline', '')
call lib#color#Hi('markdownLinkText', s:blue2, '', 'none', '')

" Diffs
call lib#color#Hi('DiffChange', s:white, s:bg4, '', '')
call lib#color#Hi('DiffText', s:blue2, s:bg4, 'bold', '')
call lib#color#Hi('DiffDelete', s:red1, s:bg4, 'italic', '')
call lib#color#Hi('DiffAdd', s:green2, s:bg3, 'bold', '')
