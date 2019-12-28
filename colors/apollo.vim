" Vim color theme
" Name:        Apollo
" Maintainer:  Markus Prepens
"  >> (inspired by https://github.com/tomasiser/vim-code-dark and https://github.com/chriskempson/base16-vim)
fun! <sid>hi(group, fg, bg, attr)
  if !empty(a:fg)
    exec "hi " . a:group . " guifg=" . a:fg.gui . " ctermfg=" .  a:fg.cterm256
  endif
  if !empty(a:bg)
    exec "hi " . a:group . " guibg=" . a:bg.gui . " ctermbg=" .  a:bg.cterm256
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  endif
endfun
if exists("syntax_on")
   syntax reset
endif

hi clear
set background=dark
let g:colors_name = "apollo"

highlight apolloHighlightLK guifg=#B0F0B0 guibg=#50B330 ctermfg=237
highlight apolloHighlightHK guifg=#BFFFBF guibg=#309020 ctermfg=237
highlight apolloHighlightWeak guifg=#60A060 guibg=#50B330 ctermfg=237

highlight apolloBase0  guibg=#151E25 guifg=#C0C0F0 ctermfg=237  
highlight apolloBase1  guibg=#181F28 guifg=#B0B0F0 ctermfg=239  
highlight apolloBase1_ guibg=#202830 guifg=#202830 ctermfg=239  
highlight apolloBase2  guibg=#33383F guifg=#A0A3E4 ctermfg=239  

highlight apolloBlack0 guifg=#181818 guibg=bg ctermfg=235  
highlight apolloBlack1 guifg=#20282b guibg=bg ctermfg=233  
highlight apolloGray0  guifg=#40404C guibg=bg ctermfg=237  
highlight apolloGray1  guifg=#60606C guibg=bg ctermfg=239  
highlight apolloGray2  guifg=#80808C guibg=bg ctermfg=242  
highlight apolloGray3  guifg=#A0A0AC guibg=bg ctermfg=249  
highlight apolloWhite  guifg=#F8F8F8 guibg=bg ctermfg=231  
highlight apolloBlue   guifg=#7080B0 guibg=bg ctermfg=110  
highlight apolloBlue2  guifg=#A0A8D0 guibg=bg ctermfg=111  
highlight apolloGreen  guifg=#57BA37 guibg=bg ctermfg=71   
highlight apolloGreen2 guifg=#67CF47 guibg=bg ctermfg=71   
highlight apolloGoo    guifg=#D8FA3B guibg=bg ctermfg=191  
highlight apolloGold   guifg=#F0D50C guibg=bg ctermfg=220  
highlight apolloOrange guifg=#F86000 guibg=bg ctermfg=202  
highlight apolloRed    guifg=#902020 guibg=bg ctermfg=1    
highlight apolloRed2   guifg=#C04040 guibg=bg ctermfg=196  

" (basics)
highlight! link Normal       apolloBlack1
highlight! link StatusLine   apolloBase0
highlight! link StatusLineNC apolloBase1
highlight! link VertSplit    apolloBase1_
highlight! link IncSearch  apolloHighlightHK
highlight! link Search     apolloHighlightLK 
highlight! link MatchParen   apolloBase1
highlight! link QuickFixLine apolloBase1

highlight! link NonText apolloGray2
highlight Cursor    guifg=#000000  guibg=#ffffff gui=none
highlight! link Visual apolloBase2

" used if Nvim's option 'winhighlight' exists (Nvim)
if has ('nvim')
  highlight NormalFloat   guifg=#aad0b8 guibg=#28202f 
  highlight NormalFocus   guibg=#2d2d3a
  highlight NormalNoFocus guibg=#18242e
  "set winhighlight=Normal:Normal,NormalNC:NormalNoFocus
endif

" Decoration
highlight LineNr        guifg=#405060   guibg=bg       gui=none
highlight CursorLineNr  guifg=#506575   guibg=#303540  gui=bold
highlight CursorLine                    guibg=#31313f
highlight! link FoldColumn Normal
highlight Folded        guifg=fg        guibg=bg       gui=none
highlight SignColumn    guifg=#e0e0e0   guibg=bg       gui=none
highlight! link PmenuSel         apolloHighlightHK
highlight! link Pmenu            apolloHighlightLK
highlight! link PmenuSbar        apolloGreen
highlight! link PmenuThumb       apolloGreen2
highlight! link StatusLineTerm   StatusLine
highlight! link StatusLineTermNC StatusLineNC
highlight! link CursorColumn     CursorLine
highlight! link WildMenu         PmenuSel
highlight! link TabLineFill      Normal
highlight! link TabLine          StatusLineNC
highlight! link TabLineSel       StatusLine

" Search

" Structure
highlight! link Statement     apolloGold
highlight! link Conditional   apolloGoo 
highlight! link Type          apolloGray4
highlight! link Structure     apolloGreen2
highlight! link StorageClass  apolloBlue
highlight! link PreProc       apolloOrange 
highlight! link PreCondit     apolloGray2
highlight! link Comment       apolloGray1
highlight! link Function      apolloGreen 
highlight! link Identifier    apolloGray2
highlight! link Special       apolloGray2
highlight! link Constant      apolloGray2
highlight! link Number        apolloGray2

highlight! link Title         apolloGray2
highlight! link Todo          apolloGray2
highlight! link Error         apolloRed2
highlight! link Directory     apolloGray2

highlight! link ErrorMsg      apolloGray2
highlight! link WarningMsg    apolloGray2
highlight! link ModeMsg       apolloGray2
highlight! link Question      apolloGray2

highlight! link qfFileName  apolloGray1
highlight! link qfSeparator apolloGray1
highlight! link qfLineNr LineNr

highlight! link vimCommentTitle apolloOrange

" Filetype C
highlight cCppOut       guifg=#00c0c0
highlight cCppOutIf2    guifg=#00c0c0
highlight cParen        guifg=#00c0c0
highlight cBlock        guifg=#00c0c0

" Vimdiff
highlight DiffChange    guifg=fg guibg=bg gui=none
highlight DiffText      guifg=fg guibg=bg gui=none
highlight DiffAdd       guifg=fg guibg=bg gui=none
highlight DiffDelete    guifg=fg guibg=bg gui=none

" Diff buffer
highlight diffOldFile   guifg=fg
highlight diffNewFile   guifg=yellow2
highlight diffFile      guifg=yellow2
highlight diffOnly      guifg=yellow2
highlight diffIdentical guifg=fg
highlight diffDiffer    guifg=fg
highlight diffBDiffer   guifg=fg
highlight diffIsA       guifg=fg
highlight diffNoEOL     guifg=fg
highlight diffCommon    guifg=fg
highlight diffRemoved   guifg=fg      gui=italic
highlight diffChanged   guifg=fg
highlight diffAdded     guifg=white   gui=bold
highlight diffLine      guifg=yellow1
highlight diffSubname   guifg=fg
highlight diffComment   guifg=fg

" netrw
highlight netrwMarkFile          gui=inverse

" filetype html
highlight htmlH1 guifg=skyblue1  gui=bold
highlight htmlH2 guifg=skyblue3  gui=bold
highlight htmlH3 guifg=skyblue3  gui=bold
highlight htmlBold               gui=bold
highlight htmlItalic             gui=italic

" markdown
highlight! link markdownCode String
highlight! link markdownCodeBlock Comment
