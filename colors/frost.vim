" Colorscheme: Frost

let g:colors_name = "frost"
set background=dark

if exists('&wincolor')
  augroup Wincolor
    au!
    " Low-key colors for non-file buffers
    autocmd BufWinEnter,WinEnter * if (&buftype!='' && &buftype!='nofile')
          \ | set wincolor=BlendDown | else | set wincolor= | endif
  augroup END
elseif exists('&winhighlight')
  augroup Winhighlight
    au!
    " Low-key colors for non-file buffers
    autocmd BufWinEnter,WinEnter * if (&buftype!='' && &buftype!='nofile')
          \ | set winhighlight=Normal:BlendDown | set winhighlight= | endif
  augroup END
endif

let s:frostBlack   = "#121518"
let s:frostWhite   = "#CFD7E3"
let s:frost0       = "#2E3440"
let s:frost1       = "#3B4252"
let s:frost2       = "#434C5E"
let s:frost3       = "#4C566A"
let s:frost4       = "#516779"
let s:frost5       = "#7589A0"
let s:frost6       = "#A3B7D3"
let s:frostBlue1   = "#8194AB"
let s:frostBlue2   = "#81A1C1"
let s:frostBlue3   = "#88C0D0"
let s:frostRed     = "#BF616A"
let s:frostPumpkin = "#D08770"
let s:frostYellow  = "#EBCB8B"
let s:frostGreen   = "#A3BE8C"
let s:frostViolet  = "#B48EAD"

function! s:Hi(group, guifg, guibg, attr, guisp)
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

" Editor
call s:Hi("ColorColumn", "", s:frost1, "", "")
call s:Hi("Cursor", s:frost0, s:frostViolet, "NONE", "")
call s:Hi("CursorLine", "", s:frost1, "NONE", "")
call s:Hi("Error", s:frostRed, "bg", "", "")
call s:Hi("iCursor", s:frost0, s:frost4, "", "")
call s:Hi("LineNr", s:frost3, s:frost0, "", "")
call s:Hi("MatchParen", s:frostBlue2, s:frost3, "", "")
call s:Hi("NonText", s:frost2, "", "", "")
call s:Hi("Normal", s:frostWhite, s:frost0, "", "")
call s:Hi("PMenu", s:frostBlue1, s:frost2, "NONE", "")
call s:Hi("PmenuSbar", s:frost4, s:frost2, "", "")
call s:Hi("PMenuSel", s:frostBlue2, s:frost3, "", "")
call s:Hi("PmenuThumb", s:frostBlue2, s:frost3, "", "")
call s:Hi("SpecialKey", s:frost3, "", "", "")
call s:Hi("SpellBad", s:frostRed, s:frost0, "undercurl", "")
call s:Hi("SpellCap", s:frostYellow, s:frost0, "undercurl", "")
call s:Hi("SpellLocal", s:frost5, s:frost0, "undercurl", "")
call s:Hi("SpellRare", s:frost6, s:frost0, "undercurl", "")
call s:Hi("Visual", s:frost6, s:frost3, "", "")
call s:Hi("VisualNOS", "", s:frost2, "", "")
call s:Hi("Whitespace", s:frost3, "", "", "")

" Frost specific
call s:Hi('BlendDown', "", s:frost1, '', '')

" Neovim Support
call s:Hi("healthError", s:frostRed, s:frost1, "", "")
call s:Hi("healthSuccess", s:frostGreen, s:frost1, "", "")
call s:Hi("healthWarning", s:frostYellow, s:frost1, "", "")
call s:Hi("TermCursorNC", "", s:frost1, "", "")

" Gutter
call s:Hi("CursorColumn", "", s:frost1, "", "")
call s:Hi("CursorLineNr", s:frost4, s:frost0, "NONE", "")
call s:Hi("Folded", s:frost3, s:frost1, "bold", "")
call s:Hi("FoldColumn", s:frost3, s:frost0, "", "")
call s:Hi("SignColumn", s:frost1, s:frost0, "", "")

" Navigation
call s:Hi("Directory", s:frostBlue2, "", "", "")

" Prompt/Status
call s:Hi("EndOfBuffer", s:frost1, "", "", "")
call s:Hi("WarningMsg", s:frostBlack, s:frostYellow, "", "")
call s:Hi("ErrorMsg", s:frostBlack, s:frostRed, "", "")
call s:Hi("ModeMsg", s:frostBlack, s:frostGreen, "", "")
call s:Hi("MoreMsg", s:frostBlack, s:frostYellow, "", "")
call s:Hi("Question", s:frost4, "", "", "")
call s:Hi("StatusLine", s:frost6, s:frost3, "NONE", "")
call s:Hi("StatusLineNC", s:frost5, s:frost1, "NONE", "")
call s:Hi("StatusLineTerm", s:frostBlue2, s:frost3, "NONE", "")
call s:Hi("StatusLineTermNC", s:frost4, s:frost1, "NONE", "")
call s:Hi("VertSplit", s:frost2, s:frost0, "NONE", "")
hi! link WildMenu IncSearch

" Search
call s:Hi("IncSearch", s:frostBlack, s:frostGreen, "bold", "")
call s:Hi("Search", s:frostBlack, s:frostYellow, "NONE", "")

 " QuickFix
hi! link qfFileName Directory
hi! link qfLineNr Directory
call s:Hi("qfSeparator", "fg", "bg", "", "")
call s:Hi("QuickFixLine", "fg", "bg", "bold", "")

" Tabs
call s:Hi("TabLine", s:frost5, s:frost1, "NONE", "")
call s:Hi("TabLineFill", s:frost4, s:frost1, "NONE", "")
call s:Hi("TabLineSel", s:frostYellow, s:frost4, "underline", "")

" Window
call s:Hi("Title", s:frost4, "", "NONE", "")
call s:Hi("Bold", "", "", "bold", "")
call s:Hi("Italic", "", "", "italic", "")
call s:Hi("Boolean", s:frostBlue3, "", "", "")
call s:Hi("Character", s:frostYellow, "", "", "")
call s:Hi("Comment", s:frostGreen, "", "italic", "")
call s:Hi("Conditional", s:frostBlue3, "", "", "")
call s:Hi("Constant", s:frostPumpkin, "", "", "")
call s:Hi("Define", s:frostBlue3, "", "", "")
call s:Hi("Delimiter", s:frost6, "", "", "")
call s:Hi("Exception", s:frostBlue3, "", "", "")
call s:Hi("Float", s:frostViolet, "", "", "")
call s:Hi("Function", s:frostBlue2, "", "", "")
call s:Hi("Identifier", s:frostGreen, "", "NONE", "")
call s:Hi("Include", s:frostBlue3, "", "", "")
call s:Hi("Keyword", s:frostBlue3, "", "", "")
call s:Hi("Label", s:frostBlue3, "", "", "")
call s:Hi("Number", s:frostViolet, "", "", "")
call s:Hi("Operator", s:frostYellow, "", "NONE", "")
call s:Hi("PreProc", s:frostBlue3, "", "NONE", "")
call s:Hi("Repeat", s:frostBlue3, "", "", "")
call s:Hi("Special", s:frost5, "", "", "")
call s:Hi("SpecialChar", s:frostYellow, "", "", "")
call s:Hi("SpecialComment", s:frostBlue2, "", "italic", "")
call s:Hi("Statement", s:frostBlue3, "", "", "")
call s:Hi("StorageClass", s:frostBlue3, "", "", "")
call s:Hi("String", s:frostViolet, "", "", "")
call s:Hi("Structure", s:frostBlue3, "", "", "")
call s:Hi("Tag", s:frost4, "", "", "")
call s:Hi("Todo", s:frostYellow, "NONE", "", "")
call s:Hi("Type", s:frostBlue3, "", "NONE", "")
call s:Hi("Typedef", s:frostBlue3, "", "", "")
hi! link Macro Define
hi! link PreCondit PreProc

call s:Hi("DiffAdd", s:frostGreen, s:frost1, "", "")
call s:Hi("DiffChange", s:frostYellow, s:frost2, "bold", "")
call s:Hi("DiffDelete", s:frostRed, s:frost1, "", "")
call s:Hi("DiffText", s:frostBlue3, s:frost1, "", "")

call s:Hi("cIncluded", s:frostBlue1, "", "", "")
hi! link cOperator Operator
hi! link cPreCondit PreCondit

call s:Hi("htmlArg", s:frostBlue1, "", "", "")
call s:Hi("htmlLink", s:frost4, "", "NONE", "NONE")
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

call s:Hi("markdownBlockquote", s:frostBlue1, "", "", "")
call s:Hi("markdownCode", s:frost6, "bg", "", "")
call s:Hi("markdownCodeBlock", s:frost5, "bg", "", "")
call s:Hi("markdownCodeDelimiter", s:frostGreen, "bg", "", "")
call s:Hi("markdownFootnote", s:frostBlue1, "", "", "")
call s:Hi("markdownId", s:frostBlue1, "", "", "")
call s:Hi("markdownIdDeclaration", s:frostBlue1, "", "", "")
call s:Hi("markdownH1", s:frostYellow, "", "", "")
call s:Hi("markdownLinkText", s:frostBlue2, "", "", "")
call s:Hi("markdownUrl", s:frost4, "", "underline", "")
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
