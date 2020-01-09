" A Vim color theme
" Name:        Apollo
" Maintainer:  Markus Prepens
"
if exists("syntax_on")
   syntax reset
endif

hi clear
set background=dark
let g:colors_name = "apollo"

highlight apolloWhite       guifg=#FFFFFF
highlight apolloWhiteBold   guifg=#FFFFFF gui=bold
highlight apolloWhiteItalic guifg=#FFFFFF gui=italic
highlight apolloBg          guibg=#18181B guifg=#F0F0FF gui=none
highlight apolloBg1         guibg=#18252B               gui=none
highlight apolloBg2         guibg=#18283f               gui=none
highlight apolloPopLowKey   guifg=#A0FFE0 guibg=#108E12 ctermfg=237
highlight apolloPopHighKey  guifg=#DFFFDF guibg=#28BE72 gui=bold ctermfg=237
highlight apolloDeco        guibg=#151E25 guifg=#C0C0F0 ctermfg=237
highlight apolloDeco1       guibg=#282F38 guifg=#C0C0FF ctermfg=239
highlight apolloDeco1Blind  guibg=#202830 guifg=#202830 ctermfg=239
highlight apolloDeco2       guibg=#33383F guifg=#A0A3E4 ctermfg=239

highlight apolloGray0       guifg=#40404C guibg=bg ctermfg=237
highlight apolloGray1       guifg=#60606C guibg=bg ctermfg=239
highlight apolloGray2       guifg=#80808C guibg=bg ctermfg=242
highlight apolloGray3       guifg=#A0A0AC guibg=bg ctermfg=249
highlight apolloWhite       guifg=#F8F8F8 guibg=bg ctermfg=231
highlight apolloBlue        guifg=#7080B0 guibg=bg ctermfg=110
highlight apolloBlue2       guifg=#A0A8D0 guibg=bg ctermfg=111
highlight apolloGreen       guifg=#379A17 guibg=bg ctermfg=71
highlight apolloGreen2      guifg=#67CF47 guibg=bg ctermfg=71
highlight apolloOrange      guifg=#F86000 guibg=bg ctermfg=202
highlight apolloOrangeBold  guifg=#F86000 guibg=bg gui=bold ctermfg=202
highlight apolloRed         guifg=#902020 guibg=bg ctermfg=1
highlight apolloRed2        guifg=#C04040 guibg=bg ctermfg=196

highlight Cursor            guifg=fg guibg=bg gui=inverse

" (basics)
highlight! link Normal       apolloBg
highlight! link NormalNC     apolloBg
highlight! link NormalFloat  apolloBg2
highlight! link StatusLine   apolloDeco1
highlight! link StatusLineNC apolloDeco
highlight! link VertSplit    apolloDeco1Blind
highlight! link IncSearch    apolloPopHighKey
highlight! link Search       apolloPopLowKey
highlight! link MatchParen   apolloWhiteBold
highlight! link QuickFixLine apolloBg1

highlight! link NonText apolloGray2
highlight! link Visual apolloDeco2

" Decoration
highlight! link LineNr       apolloBg1
highlight! link CursorLineNr apolloBg
highlight! link CursorLine   apolloBg1
highlight! link FoldColumn   apolloBg
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

" Code
highlight! link Statement    apolloGreen2
highlight! link Conditional  apolloGreen
highlight! link Type         apolloGray4
highlight! link Structure    apolloGreen2
highlight! link StorageClass apolloBlue
highlight! link PreProc      apolloWhiteBold
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

" Filetype VIM
highlight! link vimCommentTitle apolloWhiteBold

" Filetype C
highlight! link cCppOut    apolloGray3
highlight! link cCppOutIf2 apolloGray3
highlight! link cParen     apolloGray3
highlight! link cBlock     apolloGray3

" filetype HTML
highlight! link htmlH1     apolloWhite
highlight! link htmlH2     apolloWhite
highlight! link htmlH3     apolloWhite
highlight! link htmlBold   apolloWhiteBold
highlight! link htmlItalic apolloWhiteItalic

" markdown
highlight! link markdownCode      String
highlight! link markdownCodeBlock Comment
