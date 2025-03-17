vim9script
# Vim color theme
#
# Description: Four base colors in four flavours.

if exists("g:syntax_on")
  syntax reset
endif

hi clear
set background=light
g:colors_name = "blaubeere"

extend(v:colornames, {
    cFg:        "#787072",
    cBg:        "#FFFFFF",
    cShadowBg:  "#F6F6F6",
    cShadowFg:  "#C0C0C0",
    cHighlight: "#FFE070",
    cBlueDk:    "#4341AF",
    cBlue:      "#6581BF",
    cBlueLt:    "#C4CFFB",
    cBlueBg:    "#D8EFFF",
    cRedBg:     "#FBE9EB",
    cRedLt:     "#FFCACC",
    cRed:       "#FB8A9C",
    cRedDk:     "#BC6D76",
    cGreenBg:   "#DCFDE0",
    cGreenLt:   "#C3EBCE",
    cGreen:     "#7FCA7C",
    cGreenDk:   "#45984F",
    cBrownBg:   "#E7E0CF",
    cBrownLt:   "#B36E5C",
    cBrown:     "#A37E4C",
    cBrownDk:   "#7E7668",
    cGray_0:    "#2e3436",
    cGray_1:    "#555753",
    cGray_2:    "#888a85",
    cGray_3:    "#babdb6",
    cGray_4:    "#d3d7cf",
    cGray_5:    "#eeeeec"
})

# Basics

highlight Bold              gui=bold
highlight CurSearch         guifg=cBlueDk  guibg=cBlueBg   gui=NONE
highlight Cursor            guibg=black    cterm=NONE
highlight CursorLine        guibg=cGreenBg cterm=NONE
highlight CursorLineNr      guifg=cGray_2   guibg=cGray_5    gui=bold
highlight Folded            guifg=cBlue     guibg=cBg        gui=NONE
highlight IncSearch         guifg=white    guibg=cGray_0    gui=NONE
highlight Italic            gui=italic
highlight Label             guifg=black    gui=bold
highlight LineNrAbove       guifg=cRed      gui=bold
highlight LineNr            guifg=cGray_2   gui=bold
highlight LineNrBelow       guifg=cBlue     gui=bold
highlight MatchParen        guifg=cGreenDk guibg=cBg        gui=underline
highlight NonText           guifg=cGray_3   guibg=cBg
highlight Normal            guifg=cFg       guibg=cBg        gui=NONE
highlight Operator          guifg=cGreenDk gui=NONE
highlight Pmenu             guifg=black    guibg=cBrownBg
highlight PmenuSbar         guifg=cGray_4   guibg=cGray_4
highlight PmenuSel          guifg=black    guibg=cgreen  gui=NONE
highlight PmenuMatchSel     guifg=white    guibg=cGreenDk  gui=bold
highlight PmenuThumb        guifg=cGreenDk    guibg=cGreenDk
highlight Search            guifg=black guibg=cBrownBg  gui=NONE
highlight StatusLine        guifg=white  guibg=cGray_1   gui=NONE
highlight StatusLineNC      guifg=cGray_2   guibg=cGray_5    gui=NONE
highlight StatusLineTerm    guifg=white    guibg=cBlue      gui=NONE
highlight TabLine           guifg=cGray_2   guibg=cShadowBg gui=NONE
highlight TabLineFill       guifg=black    guibg=cShadowBg gui=NONE
highlight TabLineSel        guifg=cBlueBg  guibg=cBlueDk   gui=bold
highlight Terminal          guifg=cFg       guibg=cBg
highlight User1             guifg=white    guibg=cGray_4    gui=NONE
highlight User2             guifg=cBlueLt  guibg=cBlueDk   gui=italic
highlight VertSplit         guifg=cGray_4   guibg=cGray_5    gui=NONE
highlight Visual            guifg=black    guibg=cBlueBg
highlight PopupNotification guifg=black guibg=cHighlight

highlight! link CursorColumn CursorLine
highlight! link FoldColumn LineNr
highlight! link SignColumn LineNr
highlight! link StatusLineTermNC StatusLineNC
highlight! link WildMenu PmenuSel
highlight! link qfSeparator gui=NONE

# Code

hi Comment guifg=cBrownDk gui=NONE
hi Conditional guifg=cRed  gui=NONE
hi Constant guifg=cBlue
hi Directory guifg=cBlueDk gui=underline
hi Error guifg=cRedDk guibg=cRedBg gui=NONE
hi ErrorMsg guifg=cRedDk guibg=cRedBg gui=NONE
hi Function guifg=cBlue
hi Identifier guifg=cGreenDk gui=NONE
hi Ignore guifg=cGray_3 gui=italic
hi ModeMsg guifg=black guibg=cBrownBg gui=NONE
hi Number guifg=cBlue
hi PreCondit guifg=cRedDk  gui=bold
hi PreProc guifg=black gui=bold
hi Question guifg=cGray_2 guibg=cBg
hi QuickFixLine guifg=cBlue guibg=cBg gui=bold
hi Special guifg=black
hi SpecialKey guifg=cBlue
hi Statement guifg=cBlueDk  gui=NONE
hi StorageClass guifg=cRed
hi String guifg=cBrownLt
hi Structure guifg=cRed gui=NONE
hi Title guifg=cBlueDk  gui=bold
hi Todo guifg=cRed guibg=cBg gui=bold,underline
hi Type guifg=cRedDk gui=NONE
hi WarningMsg guifg=white guibg=cGreenDk
hi qfFileName guifg=cBlueLt
hi qfLineNr guifg=cRed

# Filetype VIM

hi vimCommentTitle guifg=cBrownDk  gui=bold
hi vimHiKeyList    guifg=cBlue

# Filetype C

hi cCppOut guibg=cGray_4 gui=NONE
hi cCppOutIf guifg=cGray_3 gui=italic
hi cCppOutIf2 guifg=cGray_4 gui=italic
hi cParen guifg=cGray_2
hi cBlock guifg=cGray_2

# Filetype HTML

hi htmlH1 guifg=cBlueDk gui=bold
hi htmlH2 guifg=cBlue    gui=bold
hi htmlH3 guifg=cBlue    gui=NONE
hi htmlItalic guifg=cShadowFg gui=italic

# Filetype Markdown

hi markdownCode guifg=cGray_2 guibg=cGray_5
hi markdownCodeBlock guifg=cGray_2 gui=italic

# Filetype ReStructuredTExt

hi rstEmphasis guifg=cGray_2
hi rstStrongEmphasis guifg=cGray_2  gui=bold

# Diffs

hi DiffChange guifg=black guibg=cBlueBg
hi DiffText guifg=white guibg=black gui=bold
hi DiffDelete guifg=cRedDk guibg=cRedBg
hi DiffAdd guifg=black guibg=cGreenBg gui=bold

# Signify

hi SignifySignAdd             guifg=cGreen
hi SignifySignDelete          guifg=cRed
hi SignifySignDeleteFirstLine guifg=cRed
hi SignifySignChange          guifg=cBlue
hi SignifySignChangeDelete    guifg=cBlue
