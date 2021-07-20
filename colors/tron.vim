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

"       ;; standardized palette
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

function! s:hi(group, guifg, guibg, attr, guisp)
  if a:guifg != ""
    exec "hi " . a:group . " guifg=" . a:guifg
  endif
  if a:guibg != ""
    exec "hi " . a:group . " guibg=" . a:guibg
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr
  endif
  if a:guisp != ""
    exec "hi " . a:group . " guisp=" . a:guisp
  endif
endfunction

" --- Editor ---
call lib#color#Hi("ColorColumn", "", s:fg1, "", "")
call lib#color#Hi("Cursor", "#ffffff", s:magenta, "NONE", "")
call lib#color#Hi("CursorLine", "", s:hl_line, "NONE", "")
call lib#color#Hi("Error", s:red, "bg", "", "")
call lib#color#Hi("iCursor", s:fg0, s:fg4, "", "")
call lib#color#Hi("LineNr", s:fg3, s:bg2, "", "")
call lib#color#Hi("MatchParen", s:green, s:bg3, "", "")
call lib#color#Hi("NonText", s:fg0, s:blue, "", "")
call lib#color#Hi("Normal", s:fg0, s:bg1, "", "")
call lib#color#Hi("SpecialKey", s:fg3, "", "", "")
call lib#color#Hi("SpellBad", s:red, s:bg0, "undercurl", s:red)
call lib#color#Hi("SpellCap", s:yellow, s:bg0, "undercurl", s:yellow)
call lib#color#Hi("SpellLocal", s:fg4, s:bg0, "undercurl", s:red)
call lib#color#Hi("SpellRare", s:fg4, s:bg0, "undercurl", s:red)
call lib#color#Hi("Visual", "", s:bg_hl, "", "")
call lib#color#Hi("VisualNOS", "", s:bg_hl, "", "")

" --- Gutter ---
call lib#color#Hi("CursorColumn", "", s:fg1, "", "")
call lib#color#Hi("CursorLineNr", s:line_num, "", "NONE", "")
call lib#color#Hi("Folded", s:fg3, s:fg1, "bold", "")
call lib#color#Hi("FoldColumn", s:fg3, s:bg0, "", "")
call lib#color#Hi("SignColumn", s:fg1, s:bg0, "", "")

" --- Navigation ---
call lib#color#Hi("Directory", s:blue, "", "underline", "")

" --- Prompt/Status ---
call lib#color#Hi("EndOfBuffer", s:fg1, "", "", "")
call lib#color#Hi("WarningMsg", s:bg0, s:yellow, "", "")
call lib#color#Hi("ErrorMsg", s:bg0, s:red, "", "")
call lib#color#Hi("ModeMsg", s:bg0, s:green, "", "")
call lib#color#Hi("MoreMsg", s:bg0, s:yellow, "", "")
call lib#color#Hi("Question", s:fg4, "", "", "")

" --- Decorations ---
call lib#color#Hi("StatusLine", s:fg4, s:mode_line_bg, "NONE", "")
call lib#color#Hi("StatusLineNC", s:fg0, s:bg2, "NONE", "")
call lib#color#Hi("StatusLineTerm", s:blue, s:fg3, "NONE", "")
call lib#color#Hi("IncSearch", s:yellow, s:bg3, "bold", "")
call lib#color#Hi("Search", s:green, s:bg4, "NONE", "")

hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link WildMenu IncSearch
hi! link VertSplit StatusLineNC

call lib#color#Hi("PmenuSbar", s:fg3, s:bg2, "", "")
call lib#color#Hi("PmenuThumb", s:fg4, s:bg3, "", "")
hi! link PMenuSel IncSearch
hi! link PMenu    Search

call lib#color#Hi("TabLine", s:fg4, s:fg1, "NONE", "")
call lib#color#Hi("TabLineFill", s:fg4, s:fg1, "NONE", "")
call lib#color#Hi("TabLineSel", s:red, s:fg4, "", "")

" --- Window ---
call lib#color#Hi("Title", s:fg4, "", "NONE", "")
call lib#color#Hi("Bold", "", "", "bold", "")
call lib#color#Hi("Italic", "", "", "italic", "")
call lib#color#Hi("Boolean", s:yellow, "", "", "")
call lib#color#Hi("Character", s:yellow, "", "", "")
call lib#color#Hi("Comment", s:fg1, "", "italic", "")
call lib#color#Hi("Conditional", s:lightred, "", "", "")
call lib#color#Hi("Constant", s:bluegreen, "", "", "")
call lib#color#Hi("Delimiter", s:fg4, "", "", "")
call lib#color#Hi("Exception", s:blue, "", "", "")
call lib#color#Hi("Float", s:bluegreen, "", "", "")
call lib#color#Hi("Function", s:yellow, "", "", "")
call lib#color#Hi("Identifier", s:green, "", "NONE", "")
call lib#color#Hi("Keyword", s:lightred, "", "", "")
call lib#color#Hi("Label", s:blue, "", "", "")
call lib#color#Hi("Number", s:magenta, "", "", "")
call lib#color#Hi("Operator", s:yellow, "", "NONE", "")
call lib#color#Hi("Repeat", s:red, "", "", "")
call lib#color#Hi("Special", s:fg4, "", "", "")
call lib#color#Hi("SpecialChar", s:yellow, "", "", "")
call lib#color#Hi("SpecialComment", s:blue, "", "italic", "")
call lib#color#Hi("Statement", s:lightred, "", "", "")
call lib#color#Hi("StorageClass", s:blue, "", "", "")
call lib#color#Hi("String", s:fg3, "", "", "")
call lib#color#Hi("Structure", s:magenta, "", "", "")
call lib#color#Hi("Tag", s:fg4, "", "", "")
call lib#color#Hi("Todo", s:fg3, s:red, "NONE", "")
call lib#color#Hi("Type", s:red, "", "NONE", "")
call lib#color#Hi("Typedef", s:blue, "", "", "")

call lib#color#Hi("PreProc", s:yellow, "", "bold", "")
call lib#color#Hi("Include", s:yellow, "", "", "")
hi! link Macro Define
hi! link PreCondit PreProc
hi! link Define PreProc

call lib#color#Hi("DiffAdd", s:green, s:bg2, "", "")
call lib#color#Hi("DiffChange", s:yellow, s:bg2, "", "")
call lib#color#Hi("DiffDelete", s:red, s:bg2, "", "")
call lib#color#Hi("DiffText", s:blue, s:bg2, "", "")

call lib#color#Hi("cIncluded", s:blue, "", "", "")
hi! link cOperator Operator
hi! link cPreCondit PreCondit

call lib#color#Hi("htmlArg", s:blue, "", "", "")
call lib#color#Hi("htmlLink", s:fg4, "", "NONE", "NONE")
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

call lib#color#Hi("vimCommentTitle", s:blue, "", "bold", "")

call lib#color#Hi("markdownBlockquote", s:blue, "", "", "")
call lib#color#Hi("markdownCode", s:fg4, "bg", "", "")
call lib#color#Hi("markdownCodeBlock", s:fg4, "bg", "", "")
call lib#color#Hi("markdownCodeDelimiter", s:green, "bg", "", "")
call lib#color#Hi("markdownFootnote", s:blue, "", "", "")
call lib#color#Hi("markdownId", s:blue, "", "", "")
call lib#color#Hi("markdownIdDeclaration", s:blue, "", "", "")
call lib#color#Hi("markdownH1", s:yellow, "", "", "")
call lib#color#Hi("markdownLinkText", s:blue, "", "", "")
call lib#color#Hi("markdownUrl", s:fg4, "", "underline", "")
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
