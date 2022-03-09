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

let s:GuiFg = {str -> empty(str) ? "":"guifg=".str}
let s:GuiBg = {str -> empty(str) ? "":"guibg=".str}
let s:GuiAttr = {str -> empty(str) ? "":"gui=".str}

" --- Editor ---
execute "hi ColorColumn"  s:GuiBg(s:fg1)
execute "hi Cursor" s:GuiFg("#ffffff") s:GuiBg(s:magenta) s:GuiAttr("NONE")
execute "hi CursorLine"  s:GuiBg(s:hl_line) s:GuiAttr("NONE")
execute "hi Error" s:GuiFg(s:red) s:GuiBg("bg")
execute "hi iCursor" s:GuiFg(s:fg0) s:GuiBg(s:fg4)
execute "hi MatchParen" s:GuiFg(s:green) s:GuiBg(s:bg3)
execute "hi NonText" s:GuiFg(s:fg2)
execute "hi Normal" s:GuiFg(s:fg0) s:GuiBg(s:bg1)
execute "hi SpecialKey" s:GuiFg(s:fg3)
execute "hi SpellBad" s:GuiFg(s:red) s:GuiBg(s:bg0) s:GuiAttr("undercurl")
execute "hi SpellCap" s:GuiFg(s:yellow) s:GuiBg(s:bg0) s:GuiAttr("undercurl")
execute "hi SpellLocal" s:GuiFg(s:fg4) s:GuiBg(s:bg0) s:GuiAttr("undercurl")
execute "hi SpellRare" s:GuiFg(s:fg4) s:GuiBg(s:bg0) s:GuiAttr("undercurl")
execute "hi Visual"  s:GuiBg(s:bg_hl)
execute "hi VisualNOS"  s:GuiBg(s:bg_hl)

execute 'hi QuickFixLine'  s:GuiFg(s:lightred) s:GuiBg('bg') s:GuiAttr('bold')

" --- Gutter ---
execute "hi LineNr" s:GuiFg(s:fg2) s:GuiBg(s:bg2) s:GuiAttr("bold")
execute 'hi LineNrAbove' s:GuiFg(s:fg1) s:GuiBg(s:bg0) s:GuiAttr("bold")
execute 'hi LineNrBelow' s:GuiFg(s:fg1) s:GuiBg(s:bg0) s:GuiAttr("bold")
execute "hi CursorColumn"  s:GuiBg(s:fg1)
execute "hi CursorLineNr" s:GuiFg(s:line_num)  s:GuiAttr("NONE")
execute "hi Folded" s:GuiFg(s:fg3) s:GuiBg(s:fg1) s:GuiAttr("bold")
execute "hi FoldColumn" s:GuiFg(s:fg3) s:GuiBg(s:bg0) s:GuiAttr("bold")
execute "hi SignColumn" s:GuiFg(s:fg1) s:GuiBg(s:bg0) s:GuiAttr("bold")

" --- Navigation ---
execute "hi Directory" s:GuiFg(s:blue)  s:GuiAttr("underline")

" --- Prompt/Status ---
execute "hi EndOfBuffer" s:GuiFg(s:fg1)
execute "hi WarningMsg" s:GuiFg(s:bg0) s:GuiBg(s:yellow)
execute "hi ErrorMsg" s:GuiFg(s:bg0) s:GuiBg(s:red)
execute "hi ModeMsg" s:GuiFg(s:bg0) s:GuiBg(s:green)
execute "hi MoreMsg" s:GuiFg(s:bg0) s:GuiBg(s:yellow)
execute "hi Question" s:GuiFg(s:fg4)

" --- Decorations ---
execute "hi StatusLine" s:GuiFg(s:fg4) s:GuiBg(s:mode_line_bg) s:GuiAttr("NONE")
execute "hi StatusLineNC" s:GuiFg(s:fg0) s:GuiBg(s:bg2) s:GuiAttr("NONE")
execute "hi StatusLineTerm" s:GuiFg(s:blue) s:GuiBg(s:fg3) s:GuiAttr("NONE")
execute "hi IncSearch" s:GuiFg(s:bg3) s:GuiBg(s:yellow) s:GuiAttr("bold")
execute "hi Search" s:GuiFg(s:blue) s:GuiBg(s:blue_bghl) s:GuiAttr("bold")

hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link WildMenu IncSearch
hi! link VertSplit StatusLineNC

execute "hi PmenuSbar" s:GuiFg(s:fg3) s:GuiBg(s:bg2)
execute "hi PmenuThumb" s:GuiFg(s:fg4) s:GuiBg(s:bg3)
hi! link PMenuSel IncSearch
hi! link PMenu    Search

execute "hi TabLine" s:GuiFg(s:fg4) s:GuiBg(s:fg1) s:GuiAttr("NONE")
execute "hi TabLineFill" s:GuiFg(s:fg4) s:GuiBg(s:fg1) s:GuiAttr("NONE")
execute "hi TabLineSel" s:GuiFg(s:red) s:GuiBg(s:fg4)

" --- Window ---
execute "hi Title" s:GuiFg(s:fg4)  s:GuiAttr("NONE")
execute "hi Bold"   s:GuiAttr("bold")
execute "hi Italic"   s:GuiAttr("italic")
execute "hi Boolean" s:GuiFg(s:yellow)
execute "hi Character" s:GuiFg(s:yellow)
execute "hi Comment" s:GuiFg(s:fg1)  s:GuiAttr("italic")
execute "hi Conditional" s:GuiFg(s:lightred)
execute "hi Constant" s:GuiFg(s:bluegreen)
execute "hi Exception" s:GuiFg(s:blue)
execute "hi Float" s:GuiFg(s:bluegreen)
execute "hi Function" s:GuiFg(s:yellow)
execute "hi Identifier" s:GuiFg(s:green)  s:GuiAttr("NONE")
execute "hi Keyword" s:GuiFg(s:lightred)
execute "hi Label" s:GuiFg(s:blue)
execute "hi Number" s:GuiFg(s:magenta)
execute "hi Operator" s:GuiFg(s:yellow)  s:GuiAttr("NONE")
execute "hi Repeat" s:GuiFg(s:red)
execute "hi Special" s:GuiFg(s:fg4)
execute "hi SpecialChar" s:GuiFg(s:yellow)
execute "hi SpecialComment" s:GuiFg(s:blue)  s:GuiAttr("italic")
execute "hi Statement" s:GuiFg(s:lightred)
execute "hi StorageClass" s:GuiFg(s:blue)
execute "hi String" s:GuiFg(s:fg3)
execute "hi Structure" s:GuiFg(s:magenta)
execute "hi Tag" s:GuiFg(s:fg4)
execute "hi Todo" s:GuiFg(s:fg3) s:GuiBg(s:red) s:GuiAttr("NONE")
execute "hi Type" s:GuiFg(s:red)  s:GuiAttr("NONE")
execute "hi Typedef" s:GuiFg(s:blue)
execute "hi Delimiter" s:GuiFg(s:fg4)

execute "hi PreProc" s:GuiFg(s:yellow)  s:GuiAttr("bold")
execute "hi Include" s:GuiFg(s:yellow)
hi! link Macro Define
hi! link PreCondit PreProc
hi! link Define PreProc

execute "hi DiffAdd" s:GuiFg(s:green) s:GuiBg(s:green_bg)
execute "hi DiffChange" s:GuiFg(s:blue) s:GuiBg(s:blue_bghl)
execute "hi DiffDelete" s:GuiFg(s:red_bg) s:GuiBg(s:red_bg)
execute "hi DiffText" s:GuiFg(s:blue) s:GuiBg(s:blue_bg)

execute "hi cIncluded" s:GuiFg(s:blue)
hi! link cOperator Operator
hi! link cPreCondit PreCondit

execute "hi htmlArg" s:GuiFg(s:blue)
execute "hi htmlLink" s:GuiFg(s:fg4)  s:GuiAttr("NONE")
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

execute "hi vimCommentTitle" s:GuiFg(s:blue)  s:GuiAttr("bold")

execute "hi markdownBlockquote" s:GuiFg(s:blue)
execute "hi markdownCode" s:GuiFg(s:fg4) s:GuiBg("bg")
execute "hi markdownCodeBlock" s:GuiFg(s:fg4) s:GuiBg("bg")
execute "hi markdownCodeDelimiter" s:GuiFg(s:green) s:GuiBg("bg")
execute "hi markdownFootnote" s:GuiFg(s:blue)
execute "hi markdownId" s:GuiFg(s:blue)
execute "hi markdownIdDeclaration" s:GuiFg(s:blue)
execute "hi markdownH1" s:GuiFg(s:yellow)
execute "hi markdownLinkText" s:GuiFg(s:blue)
execute "hi markdownUrl" s:GuiFg(s:fg4)  s:GuiAttr("underline")
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
