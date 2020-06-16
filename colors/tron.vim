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
call s:hi("ColorColumn", "", s:fg1, "", "")
call s:hi("Cursor", "#ffffff", s:magenta, "NONE", "")
call s:hi("CursorLine", "", s:hl_line, "NONE", "")
call s:hi("Error", s:red, "bg", "", "")
call s:hi("iCursor", s:fg0, s:fg4, "", "")
call s:hi("LineNr", s:fg3, s:bg2, "", "")
call s:hi("MatchParen", s:green, s:bg3, "", "")
call s:hi("NonText", s:fg2, "", "", "")
call s:hi("Normal", s:fg0, s:bg1, "", "")
call s:hi("SpecialKey", s:fg3, "", "", "")
call s:hi("SpellBad", s:red, s:bg0, "undercurl", s:red)
call s:hi("SpellCap", s:yellow, s:bg0, "undercurl", s:yellow)
call s:hi("SpellLocal", s:fg4, s:bg0, "undercurl", s:red)
call s:hi("SpellRare", s:fg4, s:bg0, "undercurl", s:red)
call s:hi("Visual", "", s:bg_hl, "", "")
call s:hi("VisualNOS", "", s:bg_hl, "", "")

" - Neovim Support -
call s:hi("healthError", s:red, s:fg1, "", "")
call s:hi("healthSuccess", s:green, s:fg1, "", "")
call s:hi("healthWarning", s:yellow, s:fg1, "", "")
call s:hi("TermCursorNC", "", s:fg1, "", "")

" --- Gutter ---
call s:hi("CursorColumn", "", s:fg1, "", "")
call s:hi("CursorLineNr", s:line_num, "", "NONE", "")
call s:hi("Folded", s:fg3, s:fg1, "bold", "")
call s:hi("FoldColumn", s:fg3, s:fg0, "", "")
call s:hi("SignColumn", s:fg1, s:fg0, "", "")

" --- Navigation ---
call s:hi("Directory", s:blue, "", "underline", "")

" --- Prompt/Status ---
call s:hi("EndOfBuffer", s:fg1, "", "", "")
call s:hi("WarningMsg", s:bg0, s:yellow, "", "")
call s:hi("ErrorMsg", s:bg0, s:red, "", "")
call s:hi("ModeMsg", s:bg0, s:green, "", "")
call s:hi("MoreMsg", s:bg0, s:yellow, "", "")
call s:hi("Question", s:fg4, "", "", "")

" --- Decorations ---
call s:hi("StatusLine", s:fg4, s:mode_line_bg, "NONE", "")
call s:hi("StatusLineNC", s:fg0, s:bg2, "NONE", "")
call s:hi("StatusLineTerm", s:blue, s:fg3, "NONE", "")
call s:hi("IncSearch", s:yellow, s:bg3, "bold", "")
call s:hi("Search", s:green, s:bg4, "NONE", "")

hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link WildMenu IncSearch
hi! link VertSplit StatusLineNC

call s:hi("PmenuSbar", s:fg3, s:bg2, "", "")
call s:hi("PmenuThumb", s:fg4, s:bg3, "", "")
hi! link PMenuSel IncSearch
hi! link PMenu    Search

call s:hi("TabLine", s:fg4, s:fg1, "NONE", "")
call s:hi("TabLineFill", s:fg4, s:fg1, "NONE", "")
call s:hi("TabLineSel", s:red, s:fg4, "", "")

" --- Window ---
call s:hi("Title", s:fg4, "", "NONE", "")
call s:hi("Bold", "", "", "bold", "")
call s:hi("Italic", "", "", "italic", "")
call s:hi("Boolean", s:yellow, "", "", "")
call s:hi("Character", s:yellow, "", "", "")
call s:hi("Comment", s:fg1, "", "italic", "")
call s:hi("Conditional", s:lightred, "", "", "")
call s:hi("Constant", s:bluegreen, "", "", "")
call s:hi("Exception", s:blue, "", "", "")
call s:hi("Float", s:bluegreen, "", "", "")
call s:hi("Function", s:yellow, "", "", "")
call s:hi("Identifier", s:green, "", "NONE", "")
call s:hi("Keyword", s:lightred, "", "", "")
call s:hi("Label", s:blue, "", "", "")
call s:hi("Number", s:magenta, "", "", "")
call s:hi("Operator", s:yellow, "", "NONE", "")
call s:hi("Repeat", s:red, "", "", "")
call s:hi("Special", s:fg4, "", "", "")
call s:hi("SpecialChar", s:yellow, "", "", "")
call s:hi("SpecialComment", s:blue, "", "italic", "")
call s:hi("Statement", s:lightred, "", "", "")
call s:hi("StorageClass", s:blue, "", "", "")
call s:hi("String", s:fg3, "", "", "")
call s:hi("Structure", s:magenta, "", "", "")
call s:hi("Tag", s:fg4, "", "", "")
call s:hi("Todo", s:fg3, s:red, "NONE", "")
call s:hi("Type", s:red, "", "NONE", "")
call s:hi("Typedef", s:blue, "", "", "")
call s:hi("Delimiter", s:fg4, "", "", "")

call s:hi("PreProc", s:yellow, "", "bold", "")
call s:hi("Include", s:yellow, "", "", "")
hi! link Macro Define
hi! link PreCondit PreProc
hi! link Define PreProc

call s:hi("DiffAdd", s:green, s:fg1, "", "")
call s:hi("DiffChange", s:yellow, s:fg1, "", "")
call s:hi("DiffDelete", s:red, s:fg1, "", "")
call s:hi("DiffText", s:blue, s:fg1, "", "")

call s:hi("cIncluded", s:blue, "", "", "")
hi! link cOperator Operator
hi! link cPreCondit PreCondit

call s:hi("htmlArg", s:blue, "", "", "")
call s:hi("htmlLink", s:fg4, "", "NONE", "NONE")
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

call s:hi("vimCommentTitle", s:blue, "", "bold", "")

call s:hi("markdownBlockquote", s:blue, "", "", "")
call s:hi("markdownCode", s:fg4, "bg", "", "")
call s:hi("markdownCodeBlock", s:fg4, "bg", "", "")
call s:hi("markdownCodeDelimiter", s:green, "bg", "", "")
call s:hi("markdownFootnote", s:blue, "", "", "")
call s:hi("markdownId", s:blue, "", "", "")
call s:hi("markdownIdDeclaration", s:blue, "", "", "")
call s:hi("markdownH1", s:yellow, "", "", "")
call s:hi("markdownLinkText", s:blue, "", "", "")
call s:hi("markdownUrl", s:fg4, "", "underline", "")
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
