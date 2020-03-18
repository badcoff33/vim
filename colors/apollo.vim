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
highlight apolloWhiteUnderline guifg=#FFFFFF gui=underline
highlight apolloBg          guibg=#201C23 guifg=#F0F0FF gui=none
highlight apolloBg1                       guibg=#2F232D gui=none
highlight apolloBg2                       guibg=#323848 gui=none
highlight apolloPopLowKey   guifg=#D0D0D8 guibg=#585058
highlight apolloPopHighKey  guifg=#101010 guibg=#C0C0FF gui=bold
highlight apolloDeco        guifg=#B8B0B8 guibg=#382838
highlight apolloDeco1       guifg=#C0C0FF guibg=#382F38
highlight apolloDeco1Blind  guifg=#202830 guibg=#202830
highlight apolloSilverfish  guifg=#FFFFFF guibg=#9090B0

highlight apolloGray0      guifg=#40404C guibg=bg
highlight apolloGray1      guifg=#60606C guibg=bg
highlight apolloGray2      guifg=#90909C guibg=bg
highlight apolloGray3      guifg=#C0C0C0 guibg=bg
highlight apolloGreen      guifg=#78CF40 guibg=bg
highlight apolloGreen2     guifg=#68CF47 guibg=bg
highlight apolloGreenBold  guifg=#379A17 guibg=bg gui=bold
highlight apolloGreen2Bold guifg=#67CF47 guibg=bg gui=bold
highlight apolloWhite      guifg=#F8F8F8 guibg=bg
highlight apolloBlue       guifg=#8090C0 guibg=bg
highlight apolloBlue2      guifg=#A0A8D8 guibg=bg
highlight apolloRed        guifg=#D02050 guibg=bg

highlight Cursor           guifg=fg guibg=bg gui=inverse

" Basics
highlight Normal guibg=#201C23 guifg=#F0F0FF gui=none
highlight Visual guibg=#68AF47 guifg=#F0FFF0 gui=none
highlight! link NonText      apolloGray2
highlight! link NormalFloat  apolloBg2
highlight! link StatusLine   apolloDeco1
highlight! link StatusLineNC apolloDeco
highlight! link VertSplit    apolloDeco1Blind
highlight! link IncSearch    apolloPopHighKey
highlight! link Search       apolloSilverfish
highlight! link MatchParen   apolloGreen2
highlight  QuickFixLine gui=bold

" Decoration
highlight! link LineNr           apolloBg1
highlight! link CursorLineNr     apolloBg
highlight! link CursorLine       apolloBg1
highlight! link FoldColumn       Normal
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
highlight! link TabLineSel       Statusline

" Code
highlight! link Statement    apolloGreen2Bold
highlight! link Conditional  apolloGreen2Bold
highlight! link Type         apolloGray3
highlight! link Structure    apolloGreen
highlight! link StorageClass apolloBlue
highlight! link PreProc      apolloWhite
highlight! link PreCondit    apolloWhiteBold
highlight! link Comment      apolloGray2
highlight! link Function     apolloGreen1
highlight! link Identifier   apolloGreen
highlight! link Special      apolloGreen2
highlight! link Constant     apolloBlue2
highlight! link Number       apolloBlue2

highlight! link Title        apolloGray2
highlight! link Todo         apolloGray2
highlight! link Error        apolloRed
highlight! link Directory    apolloGray2

highlight! link ErrorMsg     apolloRed
highlight! link WarningMsg   apolloGray2
highlight! link ModeMsg      apolloGray2
highlight! link Question     apolloGreen

highlight! link qfFileName  apolloBlue2
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
highlight! link htmlH1     apolloWhiteBold
highlight! link htmlH2     apolloWhiteBold
highlight! link htmlH3     apolloWhiteBold
highlight! link htmlBold   apolloWhiteBold
highlight! link htmlItalic apolloWhiteItalic

" markdown
highlight! link markdownCode      String
highlight! link markdownCodeBlock Comment

" Diffs
hi! link DiffChange apolloBg2
hi! link DiffText   apolloDeco1
hi! link DiffDelete apolloRed
hi! link DiffAdd    apolloGreen
