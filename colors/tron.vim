" Vim color theme
" Name:        Angry Bee
" Maintainer:  Markus Prepens
" Colors taken from https://github.com/ianpan870102/tron-legacy-emacs-theme.
" Thanks!

if exists("syntax_on")
   syntax reset
endif

hi clear
let g:colors_name = "frost"
set background=dark

let s:fg0              ="#90ACBC"
let s:fg1              ="#5A7387"
let s:fg2              ="#BBCCDD"
let s:fg3              ="#BBF0EF"
let s:fg4              ="#CBECFF"
let s:bg0              ="#000000"
let s:bg1              ="#17181b"
let s:bg2              ="#192533"
let s:bg3              ="#1B324B"
let s:bg4              ="#2B4255"
let s:hl_line          ="#0E2638" " hl_line
let s:bg_hl            ="#2B4255" " region, selection
let s:vc_r             ="#B62D66"
let s:vc_g             ="#4BB5BE"
let s:vc_b             ="#387AAA"
let s:key2             ="#9BBDD6"
let s:key3             ="#AAAAAA"
let s:accent           ="#FFFFFF"
let s:mode_line_bg     ="#3D5666"
let s:line_num         ="#5A7387"

" standardized palette
let s:yellow       = "#DEB45B"
let s:bluegreen    = "#4BB5BE"
let s:magenta      = "#B62D66"
let s:orange       = "#DEB45B"
let s:red          = "#B62D66"
let s:blue         = "#8Fd4FF"
let s:green        = "#4BB5AE"
let s:lightred     = "#FF7DBB"
let s:lightblue    = "#A0DCFF"
let s:lightgreen   = "#BBF0EF"
let s:red_bg       = "#361016"
let s:blue_bg      = "#040E3F"
let s:green_bg     = "#03353E"
let s:red_bghl     = "#462026"
let s:blue_bghl    = "#141E4F"
let s:green_bghl   = "#13454E"

let GuiFg = {str -> empty(str) ? "":"guifg=".str}
let GuiBg = {str -> empty(str) ? "":"guibg=".str}
let GuiAttr = {str -> empty(str) ? "":"gui=".str}

" --- Editor ---
execute "hi ColorColumn"  GuiBg(s:fg1)
execute "hi Cursor" GuiFg("#ffffff") GuiBg(s:magenta) GuiAttr("NONE")
execute "hi CursorLine"  GuiBg(s:hl_line) GuiAttr("NONE")
execute "hi Error" GuiFg(s:red) GuiBg("bg")
execute "hi iCursor" GuiFg(s:fg0) GuiBg(s:fg4)
execute "hi LineNr" GuiFg(s:fg3) GuiBg(s:bg2)
execute "hi MatchParen" GuiFg(s:green) GuiBg(s:bg3)
execute "hi NonText" GuiFg(s:fg2)
execute "hi Normal" GuiFg(s:fg0) GuiBg(s:bg1)
execute "hi SpecialKey" GuiFg(s:fg3)
execute "hi SpellBad" GuiFg(s:red) GuiBg(s:bg0) GuiAttr("undercurl")
execute "hi SpellCap" GuiFg(s:yellow) GuiBg(s:bg0) GuiAttr("undercurl")
execute "hi SpellLocal" GuiFg(s:fg4) GuiBg(s:bg0) GuiAttr("undercurl")
execute "hi SpellRare" GuiFg(s:fg4) GuiBg(s:bg0) GuiAttr("undercurl")
execute "hi Visual"  GuiBg(s:bg_hl)
execute "hi VisualNOS"  GuiBg(s:bg_hl)

" - Neovim Support -
execute "hi healthError" GuiFg(s:red) GuiBg(s:fg1)
execute "hi healthSuccess" GuiFg(s:green) GuiBg(s:fg1)
execute "hi healthWarning" GuiFg(s:yellow) GuiBg(s:fg1)
execute "hi TermCursorNC"  GuiBg(s:fg1)

" --- Gutter ---
execute "hi CursorColumn"  GuiBg(s:fg1)
execute "hi CursorLineNr" GuiFg(s:line_num)  GuiAttr("NONE")
execute "hi Folded" GuiFg(s:fg3) GuiBg(s:fg1) GuiAttr("bold")
execute "hi FoldColumn" GuiFg(s:fg3) GuiBg(s:bg0)
execute "hi SignColumn" GuiFg(s:fg1) GuiBg(s:bg0)

" --- Navigation ---
execute "hi Directory" GuiFg(s:blue)  GuiAttr("underline")

" --- Prompt/Status ---
execute "hi EndOfBuffer" GuiFg(s:fg1)
execute "hi WarningMsg" GuiFg(s:bg0) GuiBg(s:yellow)
execute "hi ErrorMsg" GuiFg(s:bg0) GuiBg(s:red)
execute "hi ModeMsg" GuiFg(s:bg0) GuiBg(s:green)
execute "hi MoreMsg" GuiFg(s:bg0) GuiBg(s:yellow)
execute "hi Question" GuiFg(s:fg4)

" --- Decorations ---
execute "hi StatusLine" GuiFg(s:fg4) GuiBg(s:mode_line_bg) GuiAttr("NONE")
execute "hi StatusLineNC" GuiFg(s:fg0) GuiBg(s:bg2) GuiAttr("NONE")
execute "hi StatusLineTerm" GuiFg(s:blue) GuiBg(s:fg3) GuiAttr("NONE")
execute "hi IncSearch" GuiFg(s:yellow) GuiBg(s:bg3) GuiAttr("bold")
execute "hi Search" GuiFg(s:green) GuiBg(s:bg4) GuiAttr("NONE")

hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link WildMenu IncSearch
hi! link VertSplit StatusLineNC

execute "hi PmenuSbar" GuiFg(s:fg3) GuiBg(s:bg2)
execute "hi PmenuThumb" GuiFg(s:fg4) GuiBg(s:bg3)
hi! link PMenuSel IncSearch
hi! link PMenu    Search

execute "hi TabLine" GuiFg(s:fg4) GuiBg(s:fg1) GuiAttr("NONE")
execute "hi TabLineFill" GuiFg(s:fg4) GuiBg(s:fg1) GuiAttr("NONE")
execute "hi TabLineSel" GuiFg(s:red) GuiBg(s:fg4)

" --- Window ---
execute "hi Title" GuiFg(s:fg4)  GuiAttr("NONE")
execute "hi Bold"   GuiAttr("bold")
execute "hi Italic"   GuiAttr("italic")
execute "hi Boolean" GuiFg(s:yellow)
execute "hi Character" GuiFg(s:yellow)
execute "hi Comment" GuiFg(s:fg1)  GuiAttr("italic")
execute "hi Conditional" GuiFg(s:lightred)
execute "hi Constant" GuiFg(s:bluegreen)
execute "hi Exception" GuiFg(s:blue)
execute "hi Float" GuiFg(s:bluegreen)
execute "hi Function" GuiFg(s:yellow)
execute "hi Identifier" GuiFg(s:green)  GuiAttr("NONE")
execute "hi Keyword" GuiFg(s:lightred)
execute "hi Label" GuiFg(s:blue)
execute "hi Number" GuiFg(s:magenta)
execute "hi Operator" GuiFg(s:yellow)  GuiAttr("NONE")
execute "hi Repeat" GuiFg(s:red)
execute "hi Special" GuiFg(s:fg4)
execute "hi SpecialChar" GuiFg(s:yellow)
execute "hi SpecialComment" GuiFg(s:blue)  GuiAttr("italic")
execute "hi Statement" GuiFg(s:lightred)
execute "hi StorageClass" GuiFg(s:blue)
execute "hi String" GuiFg(s:fg3)
execute "hi Structure" GuiFg(s:magenta)
execute "hi Tag" GuiFg(s:fg4)
execute "hi Todo" GuiFg(s:fg3) GuiBg(s:red) GuiAttr("NONE")
execute "hi Type" GuiFg(s:red)  GuiAttr("NONE")
execute "hi Typedef" GuiFg(s:blue)
execute "hi Delimiter" GuiFg(s:fg4)

execute "hi PreProc" GuiFg(s:yellow)  GuiAttr("bold")
execute "hi Include" GuiFg(s:yellow)
hi! link Macro Define
hi! link PreCondit PreProc
hi! link Define PreProc

execute "hi DiffAdd" GuiFg(s:green) GuiBg(s:fg1)
execute "hi DiffChange" GuiFg(s:yellow) GuiBg(s:fg1)
execute "hi DiffDelete" GuiFg(s:red) GuiBg(s:fg1)
execute "hi DiffText" GuiFg(s:blue) GuiBg(s:fg1)

execute "hi cIncluded" GuiFg(s:blue)
hi! link cOperator Operator
hi! link cPreCondit PreCondit

execute "hi htmlArg" GuiFg(s:blue)
execute "hi htmlLink" GuiFg(s:fg4)  GuiAttr("NONE")
hi! link htmlBold Bold
hi! link htmlEndTag htmlTag
hi! link htmlItalic Italic
hi! link htmlH1 markdownH1
hi! link htmlH2 markdownH1
hi! link htmlH3 markdownH1
hi! link htmlH4 markdownH1
hi! link htmlH5 markdownH1
hi! link htmlH6 markdownH1
hi! link htmlSpecialChar SpecialChar
hi! link htmlTag Keyword
hi! link htmlTagN htmlTag

execute "hi vimCommentTitle" GuiFg(s:blue)  GuiAttr("bold")

execute "hi markdownBlockquote" GuiFg(s:blue)
execute "hi markdownCode" GuiFg(s:fg4) GuiBg("bg")
execute "hi markdownCodeBlock" GuiFg(s:fg4) GuiBg("bg")
execute "hi markdownCodeDelimiter" GuiFg(s:green) GuiBg("bg")
execute "hi markdownFootnote" GuiFg(s:blue)
execute "hi markdownId" GuiFg(s:blue)
execute "hi markdownIdDeclaration" GuiFg(s:blue)
execute "hi markdownH1" GuiFg(s:yellow)
execute "hi markdownLinkText" GuiFg(s:blue)
execute "hi markdownUrl" GuiFg(s:fg4)  GuiAttr("underline")
hi! link markdownBold Bold
hi! link markdownItalic Italic
hi! link markdownItalicDelimiter Keyword
hi! link markdownBoldDelimiter Keyword
hi! link markdownFootnoteDefinition markdownFootnote
hi! link markdownH2 markdownH1
hi! link markdownH3 markdownH1
hi! link markdownH4 markdownH1
hi! link markdownH5 markdownH1
hi! link markdownH6 markdownH1
hi! link markdownIdDelimiter Keyword
hi! link markdownLinkDelimiter Keyword
hi! link markdownLinkTextDelimiter Keyword
hi! link markdownListMarker Keyword
hi! link markdownRule Keyword
hi! link markdownHeadingDelimiter Keyword
