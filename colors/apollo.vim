" A Vim color theme
" Name:        Apollo
" Maintainer:  Markus Prepens

if exists('syntax_on')
   syntax reset
endif

hi clear
set background=dark
let g:colors_name = 'apollo'

augroup Colorscheme
  au!
  if exists('&wincolor')
    " Low-key colors for non-file buffers
    autocmd BufWinEnter,WinEnter * if (&buftype!='' && &buftype!='nofile')
          \ | set wincolor=BlendDown | else | set wincolor= | endif
  endif
augroup END

function! s:Hi(group, guifg, guibg, attr, guisp)
  if a:guifg != ''
    exec 'hi ' . a:group . ' guifg=' . a:guifg
  endif
  if a:guibg != ''
    exec 'hi ' . a:group . ' guibg=' . a:guibg
  endif
  if a:attr != ''
    exec 'hi ' . a:group . ' gui=' . a:attr
  endif
  if a:guisp != ''
    exec 'hi ' . a:group . ' guisp=' . a:guisp
  endif
endfunction

let s:apolloSearch         = '#FFFFFF'
let s:apolloWhite          = '#F8F8FF'
let s:apolloBlack          = '#18181F'
let s:apolloBg1            = '#2F2131'
let s:apolloBg2            = '#343240'
let s:apolloBg3            = '#484555'
let s:apolloSilver1        = '#505860'
let s:apolloSilver2        = '#9098A0'
let s:apolloSilver3        = '#C0CBD0'
let s:apolloGreen1         = '#20A040'
let s:apolloGreen2         = '#47E058'
let s:apolloWhite          = '#F8F8F8'
let s:apolloBlue1          = '#6898A0'
let s:apolloBlue2          = '#A0D0F0'
let s:apolloRed1           = '#C85012'
let s:apolloRed2           = '#F86020'

" Basics
call s:Hi('Normal', s:apolloWhite, s:apolloBg1, 'NONE', '')
call s:Hi('NonText', '', s:apolloBg2, '', '')
call s:Hi('Visual', s:apolloWhite, s:apolloSilver2, '', '')
call s:Hi('StatusLine', s:apolloBlue2, s:apolloBg3, 'bold', '')
call s:Hi('StatusLineNC', s:apolloSilver1, s:apolloBg2, 'bold',  '')
call s:Hi('VertSplit', s:apolloBg3, 'bg', 'NONE', '')
call s:Hi('IncSearch', s:apolloWhite, s:apolloBlue1, 'bold', '')
call s:Hi('Search', s:apolloWhite, s:apolloBg3, 'bold', '')
call s:Hi('MatchParen', s:apolloGreen2, '', 'underline', '')
call s:Hi('QuickFixLine', '', '', 'bold', '')
call s:Hi('CursorLine', '', s:apolloBg2, '', '')
call s:Hi('LineNr', s:apolloBlue1, '', '', '')

highlight! link CursorColumn CursorLine
highlight! link CursorLineNr CursorLine
highlight! link FoldColumn LineNr
highlight! link Folded StatusLineNC
highlight! link StatusLineTerm StatusLine
highlight! link StatusLineTermNC StatusLineNC
highlight! link PmenuSel IncSearch
highlight! link Pmenu Search
highlight! link PmenuSbar Search
highlight! link PmenuThumb IncSearch
highlight! link TabLineFill Normal
highlight! link TabLine StatusLineNC
highlight! link TabLineSel Statusline
highlight! link WildMenu PmenuSel

" Apollo specific
call s:Hi('BlendDown', s:apolloWhite, s:apolloBg3, '', '')

" Code
call s:Hi('Statement', s:apolloGreen2, '', 'bold', '')
call s:Hi('Conditional', s:apolloGreen2, '', 'bold', '')
call s:Hi('Type', s:apolloSilver3, '', '', '')
call s:Hi('Structure', s:apolloGreen1, '', '', '')
call s:Hi('StorageClass', s:apolloBlue1, '', '', '')
call s:Hi('PreProc', s:apolloWhite, '', '', '')
call s:Hi('PreCondit', s:apolloWhite, '', 'bold', '')
call s:Hi('Comment', s:apolloSilver2, '', '', '')
call s:Hi('Function', s:apolloGreen1, '', '', '')
call s:Hi('Identifier', s:apolloGreen1, '', '', '')
call s:Hi('Special', s:apolloGreen2, '', '', '')
call s:Hi('Constant', s:apolloBlue2, '', '', '')
call s:Hi('Number', s:apolloBlue2, '', '', '')
call s:Hi('Title', s:apolloSilver2, '', '', '')
call s:Hi('Todo', s:apolloSilver2, '', '', '')
call s:Hi('Error', s:apolloRed1, '', '', '')
call s:Hi('Directory', s:apolloSilver2, '', '', '')
call s:Hi('ErrorMsg', s:apolloRed1, 'bg', '', '')
call s:Hi('WarningMsg', s:apolloBlue1, 'bg', '', '')
call s:Hi('ModeMsg', s:apolloSilver2, 'bg', '', '')
call s:Hi('Question', s:apolloGreen1, 'bg', '', '')
call s:Hi('qfFileName', s:apolloBlue2, '', '', '')
call s:Hi('qfSeparator', s:apolloSilver1, '', '', '')
highlight! link qfLineNr    LineNr

" Filetype VIM
call s:Hi('vimCommentTitle', s:apolloWhite, '', 'bold', '')

" Filetype C
call s:Hi('cCppOut', s:apolloSilver3, '', '', '')
call s:Hi('cCppOutIf2', s:apolloSilver3, '', '', '')
call s:Hi('cParen', s:apolloSilver3, '', '', '')
call s:Hi('cBlock', s:apolloSilver3, '', '', '')

" filetype HTML
call s:Hi('htmlH1', s:apolloWhite, '', 'bold', '')
call s:Hi('htmlH2', s:apolloWhite, '', 'bold', '')
call s:Hi('htmlH3', s:apolloWhite, '', 'bold,italic', '')
call s:Hi('htmlBold', s:apolloWhite, '', 'bold', '')
call s:Hi('htmlItalic', s:apolloWhite, '', 'italic', '')

" markdown
call s:Hi('markdownCode', s:apolloSilver2, s:apolloBg2, '', '')
call s:Hi('markdownCodeBlock', s:apolloSilver2, '', '', '')

" Diffs
call s:Hi('DiffChange', '', s:apolloBg2, '', '')
call s:Hi('DiffText', s:apolloBlue2, s:apolloBg2, '', '')
call s:Hi('DiffDelete', s:apolloRed1, s:apolloBg2, 'bold', '')
call s:Hi('DiffAdd', s:apolloGreen1, s:apolloBg2, 'bold', '')
