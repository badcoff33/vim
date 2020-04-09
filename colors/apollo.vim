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

let s:apolloDeco1Fg        = '#8080C0'
let s:apolloDeco1Bg        = '#302835'
let s:apolloDeco2Fg        = '#A0A0FF'
let s:apolloDeco2Bg        = '#352F43'
let s:apolloSearchFg       = '#FFFFFF'
let s:apolloSearchBg       = '#308830'
let s:apolloSearch         = '#FFFFFF'
let s:apolloPopLowFg       = '#D0D0D8'
let s:apolloPopLowBg       = '#585058'
let s:apolloPopHighFg      = '#101010'
let s:apolloPopHighBg      = '#C0C0FF'
let s:apolloWhite          = '#F8F8FF'
let s:apolloBlack          = '#18181F'
let s:apolloBg1            = '#2C222C'
let s:apolloBg2            = '#352838'
let s:apolloVisual         = '#C0F0F0'
let s:apolloPopLowKey      = '#D0D0D8'
let s:apolloPopHighKey     = '#101010'
let s:apolloGray0          = '#40404C'
let s:apolloGray1          = '#60606C'
let s:apolloGray2          = '#90909C'
let s:apolloGray3          = '#C0C0C0'
let s:apolloGreen1         = '#78CF40'
let s:apolloGreen2         = '#68CF47'
let s:apolloWhite          = '#F8F8F8'
let s:apolloBlue1          = '#8090C0'
let s:apolloBlue2          = '#A0A8D8'
let s:apolloRed            = '#E84080'

" Basics
call s:Hi('Normal', s:apolloWhite, s:apolloBg1, 'NONE', '')
call s:Hi('NonText', '', s:apolloBg2, '', '')
call s:Hi('Visual', s:apolloWhite, s:apolloGray2, '', '')
call s:Hi('StatusLine', s:apolloDeco1Fg, s:apolloDeco1Bg, 'bold', '')
call s:Hi('StatusLineNC', s:apolloDeco2Fg, s:apolloDeco2Bg, 'bold',  '')
call s:Hi('VertSplit', s:apolloDeco2Fg, 'bg', 'NONE', '')
call s:Hi('IncSearch', s:apolloPopHighFg, s:apolloPopHighBg, 'bold', '')
call s:Hi('Search', s:apolloPopLowFg, s:apolloPopLowBg, 'bold', '')
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
call s:Hi('BlendDown', s:apolloWhite, s:apolloBlack, '', '')

" Code
call s:Hi('Statement', s:apolloGreen2, '', 'bold', '')
call s:Hi('Conditional', s:apolloGreen2, '', 'bold', '')
call s:Hi('Type', s:apolloGray3, '', '', '')
call s:Hi('Structure', s:apolloGreen1, '', '', '')
call s:Hi('StorageClass', s:apolloBlue1, '', '', '')
call s:Hi('PreProc', s:apolloWhite, '', '', '')
call s:Hi('PreCondit', s:apolloWhite, '', 'bold', '')
call s:Hi('Comment', s:apolloGray2, '', '', '')
call s:Hi('Function', s:apolloGreen1, '', '', '')
call s:Hi('Identifier', s:apolloGreen1, '', '', '')
call s:Hi('Special', s:apolloGreen2, '', '', '')
call s:Hi('Constant', s:apolloBlue2, '', '', '')
call s:Hi('Number', s:apolloBlue2, '', '', '')
call s:Hi('Title', s:apolloGray2, '', '', '')
call s:Hi('Todo', s:apolloGray2, '', '', '')
call s:Hi('Error', s:apolloRed, '', '', '')
call s:Hi('Directory', s:apolloGray2, '', '', '')
call s:Hi('ErrorMsg', s:apolloRed, 'bg', '', '')
call s:Hi('WarningMsg', s:apolloBlue1, 'bg', '', '')
call s:Hi('ModeMsg', s:apolloGray2, 'bg', '', '')
call s:Hi('Question', s:apolloGreen1, 'bg', '', '')
call s:Hi('qfFileName', s:apolloBlue2, '', '', '')
call s:Hi('qfSeparator', s:apolloGray1, '', '', '')
highlight! link qfLineNr    LineNr

" Filetype VIM
call s:Hi('vimCommentTitle', s:apolloWhite, '', 'bold', '')

" Filetype C
call s:Hi('cCppOut', s:apolloGray3, '', '', '')
call s:Hi('cCppOutIf2', s:apolloGray3, '', '', '')
call s:Hi('cParen', s:apolloGray3, '', '', '')
call s:Hi('cBlock', s:apolloGray3, '', '', '')

" filetype HTML
call s:Hi('htmlH1', s:apolloWhite, '', 'bold', '')
call s:Hi('htmlH2', s:apolloWhite, '', 'bold', '')
call s:Hi('htmlH3', s:apolloWhite, '', 'bold,italic', '')
call s:Hi('htmlBold', s:apolloWhite, '', 'bold', '')
call s:Hi('htmlItalic', s:apolloWhite, '', 'italic', '')

" markdown
call s:Hi('markdownCode', s:apolloGray2, s:apolloBg2, '', '')
call s:Hi('markdownCodeBlock', s:apolloGray2, '', '', '')

" Diffs
call s:Hi('DiffChange', '', s:apolloBg2, '', '')
call s:Hi('DiffText', s:apolloBlue2, s:apolloDeco1Bg, '', '')
call s:Hi('DiffDelete', s:apolloRed, s:apolloBg2, 'bold', '')
call s:Hi('DiffAdd', s:apolloGreen1, s:apolloBg2, 'bold', '')
