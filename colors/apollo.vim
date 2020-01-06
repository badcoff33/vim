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
hide
highlight apolloPopLowKey     guifg=#C0f0C0 guibg=#286E42 ctermfg=237
highlight apolloPopHighKey    guifg=#DFFFEF guibg=#387E42 ctermfg=237
highlight apolloHighlightWeak guifg=#60A060 guibg=#50B330 ctermfg=237

highlight apolloDeco0  guibg=#151E25 guifg=#C0C0F0 ctermfg=237
highlight apolloDeco1  guibg=#181F28 guifg=#B0B0F0 ctermfg=239
highlight apolloDeco1_ guibg=#202830 guifg=#202830 ctermfg=239
highlight apolloDeco2  guibg=#33383F guifg=#A0A3E4 ctermfg=239

highlight apolloBg     guibg=#18181B
highlight apolloBg1    guibg=#20282b
highlight apolloGray0  guifg=#40404C guibg=bg ctermfg=237
highlight apolloGray1  guifg=#60606C guibg=bg ctermfg=239
highlight apolloGray2  guifg=#80808C guibg=bg ctermfg=242
highlight apolloGray3  guifg=#A0A0AC guibg=bg ctermfg=249
highlight apolloWhite  guifg=#F8F8F8 guibg=bg ctermfg=231
highlight apolloBlue   guifg=#7080B0 guibg=bg ctermfg=110
highlight apolloBlue2  guifg=#A0A8D0 guibg=bg ctermfg=111
highlight apolloGreen  guifg=#379A17 guibg=bg ctermfg=71
highlight apolloGreen2 guifg=#67CF47 guibg=bg ctermfg=71
highlight apolloGoo    guifg=#D8FA3B guibg=bg ctermfg=191
highlight apolloGold   guifg=#F0D50C guibg=bg ctermfg=220
highlight apolloOrange guifg=#F86000 guibg=bg ctermfg=202
highlight apolloRed    guifg=#902020 guibg=bg ctermfg=1
highlight apolloRed2   guifg=#C04040 guibg=bg ctermfg=196

" (basics)
highlight! link Normal       apolloBg1
highlight! link NormalNC     apolloBg1
highlight! link NormalFloat  apolloPopHighKey
highlight! link StatusLine   apolloDeco0
highlight! link StatusLineNC apolloDeco1
highlight! link VertSplit    apolloDeco1_
highlight! link IncSearch    apolloPopHighKey
highlight! link Search       apolloPopLowKey
highlight! link MatchParen   apolloDeco1
highlight! link QuickFixLine apolloDeco1

highlight! link NonText apolloGray2
highlight Cursor    guifg=#000000  guibg=#ffffff gui=none
highlight! link Visual apolloDeco2

" Decoration
highlight! link LineNr       apolloBg1
highlight! link CursorLineNr apolloBg
highlight! link CursorLine   apolloBg
highlight! link FoldColumn Normal
highlight! link PmenuSel         apolloPopHighKey
highlight! link Pmenu            apolloPopLowKey
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
highlight! link Statement    apolloGreen2
highlight! link Conditional  apolloGreen
highlight! link Type         apolloGray4
highlight! link Structure    apolloGreen2
highlight! link StorageClass apolloBlue
highlight! link PreProc      apolloOrange
highlight! link PreCondit    apolloGray2
highlight! link Comment      apolloGray1
highlight! link Function     apolloGreen
highlight! link Identifier   apolloGray2
highlight! link Special      apolloGray2
highlight! link Constant     apolloBlue
highlight! link Number       apolloBlue

highlight! link Title        apolloGray2
highlight! link Todo         apolloGray2
highlight! link Error        apolloRed2
highlight! link Directory    apolloGray2

highlight! link ErrorMsg     apolloGray2
highlight! link WarningMsg   apolloGray2
highlight! link ModeMsg      apolloGray2
highlight! link Question     apolloGray2

highlight! link qfFileName  apolloGray1
highlight! link qfSeparator apolloGray1
highlight! link qfLineNr    LineNr

highlight! link vimCommentTitle apolloOrange

" Filetype C
highlight cCppOut       guifg=#00c0c0
highlight cCppOutIf2    guifg=#00c0c0
highlight cParen        guifg=#00c0c0
highlight cBlock        guifg=#00c0c0

" filetype html
highlight htmlH1     gui=bold
highlight htmlH2     gui=bold
highlight htmlH3     gui=bold
highlight htmlBold   gui=bold
highlight htmlItalic gui=italic

" markdown
highlight! link markdownCode      String
highlight! link markdownCodeBlock Comment
