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
    fg:        "#404040",
    bg:        "#FAFAFA",
    cl_bg:     "#E5FCEF",
    shadow_bg: "#F6F6F6",
    shadow_fg: "#C0C0C0",
    black:     "#000000",
    white:     "#FFFFFF",
    blue_dk:   "#4341AF",
    blue:      "#6581BF",
    blue_lt:   "#C4CFFB",
    blue_bg:   "#D8EFFF",
    red_bg:    "#FBE9EB",
    red_lt:    "#FFCACC",
    red:       "#FB8A9C",
    red_dk:    "#BC6D76",
    green_bg:  "#DCFDE0",
    green_lt:  "#C3EBCE",
    green:     "#7FCA7C",
    green_dk:  "#55A85F",
    gray_0:    "#2e3436",
    gray_1:    "#555753",
    gray_2:    "#888a85",
    gray_3:    "#babdb6",
    gray_4:    "#d3d7cf",
    gray_5:    "#eeeeec"
})

# Basics

hi Bold           gui=bold
hi CurSearch      guifg=blue_dk  guibg=blue_bg   gui=NONE
hi Cursor         guibg=black    cterm=NONE
hi CursorLine     guibg=green_bg cterm=NONE
hi CursorLineNr   guifg=gray_2   guibg=gray_5    gui=bold
hi Folded         guifg=blue     guibg=bg        gui=NONE
hi IncSearch      guifg=white    guibg=gray_0    gui=NONE
hi Italic         gui=italic
hi Label          guifg=black    gui=bold
hi LineNrAbove    guifg=red      gui=bold
hi LineNr         guifg=gray_2   gui=bold
hi LineNrBelow    guifg=blue     gui=bold
hi MatchParen     guifg=green_dk guibg=bg        gui=underline
hi NonText        guifg=gray_3   guibg=bg
hi Normal         guifg=fg       guibg=bg        gui=NONE
hi Operator       guifg=green    gui=NONE
hi Pmenu          guifg=black    guibg=green_bg
hi PmenuSbar      guifg=gray_4   guibg=gray_4
hi PmenuSel       guifg=black    guibg=green_lt  gui=NONE
hi PmenuMatchSel  guifg=white    guibg=green_dk  gui=bold
hi PmenuThumb     guifg=green    guibg=green
hi Search         guifg=green_dk guibg=green_bg  gui=NONE
hi StatusLine     guifg=blue_bg  guibg=blue_dk   gui=bold
hi StatusLineNC   guifg=gray_2   guibg=gray_5    gui=NONE
hi StatusLineTerm guifg=white    guibg=blue      gui=NONE
hi TabLine        guifg=gray_2   guibg=shadow_bg gui=NONE
hi TabLineFill    guifg=black    guibg=shadow_bg gui=NONE
hi TabLineSel     guifg=blue_bg  guibg=blue_dk   gui=bold
hi Terminal       guifg=fg       guibg=bg
hi User1          guifg=white    guibg=gray_4    gui=NONE
hi User2          guifg=blue_lt  guibg=blue_dk   gui=italic
hi VertSplit      guifg=gray_4   guibg=gray_5    gui=NONE
hi Visual         guifg=black    guibg=blue_bg

highlight! link CursorColumn CursorLine
highlight! link FoldColumn LineNr
highlight! link PopupNotification StatusLine
highlight! link SignColumn LineNr
highlight! link StatusLineTermNC StatusLineNC
highlight! link WildMenu PmenuSel
highlight! link qfSeparator gui=NONE

# Code

hi Comment guifg=green_dk gui=NONE
hi Conditional guifg=red  gui=NONE
hi Constant guifg=blue
hi Directory guifg=blue_dk gui=underline
hi Error guifg=red_dk guibg=red_bg gui=NONE
hi ErrorMsg guifg=red_dk guibg=red_bg gui=NONE
hi Function guifg=blue
hi Identifier guifg=green_dk gui=NONE
hi Ignore guifg=gray_3 gui=italic
hi ModeMsg guifg=black guibg=green gui=NONE
hi Number guifg=blue
hi PreCondit guifg=blue  gui=bold
hi PreProc guifg=blue gui=NONE
hi Question guifg=gray_2 guibg=bg
hi QuickFixLine guifg=blue guibg=bg gui=bold
hi Special guifg=blue_lt
hi SpecialKey guifg=blue
hi Statement guifg=blue_dk  gui=NONE
hi StorageClass guifg=red
hi String guifg=green_dk
hi Structure guifg=red gui=NONE
hi Title guifg=blue_dk  gui=bold
hi Todo guifg=red guibg=bg gui=bold,underline
hi Type guifg=red_dk gui=NONE
hi WarningMsg guifg=white guibg=green_dk
hi qfFileName guifg=blue_lt
hi qfLineNr guifg=red

# Filetype VIM

hi vimCommentTitle guifg=blue  gui=bold

# Filetype C

hi cCppOut guibg=gray_4 gui=NONE
hi cCppOutIf guifg=gray_3 gui=italic
hi cCppOutIf2 guifg=gray_4 gui=italic
hi cParen guifg=gray_2
hi cBlock guifg=gray_2

# Filetype HTML

hi htmlH1 guifg=blue_dk gui=bold
hi htmlH2 guifg=blue    gui=bold
hi htmlH3 guifg=blue    gui=NONE
hi htmlItalic guifg=shadow_fg gui=italic

# Filetype Markdown

hi markdownCode guifg=gray_2 guibg=gray_5
hi markdownCodeBlock guifg=gray_2 gui=italic

# Filetype ReStructuredTExt

hi rstEmphasis guifg=gray_2
hi rstStrongEmphasis guifg=gray_2  gui=bold

# Diffs

hi DiffChange guifg=black guibg=blue_bg
hi DiffText guifg=white guibg=black gui=bold
hi DiffDelete guifg=red_dk guibg=red_bg
hi DiffAdd guifg=black guibg=green_bg gui=bold

# Signify

hi SignifySignAdd             guifg=green
hi SignifySignDelete          guifg=red
hi SignifySignDeleteFirstLine guifg=red
hi SignifySignChange          guifg=blue
hi SignifySignChangeDelete    guifg=blue

