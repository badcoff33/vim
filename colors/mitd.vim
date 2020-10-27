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

let s:frostWorkbench  = "#171c28"
let s:frostBackground = "#1d2433"
let s:frostForeground = "#a2aabc"
let s:frostUi_grey    = "#6679a4"
let s:frostAccent     = "#ffcc66"
let s:frostRed        = "#ef6b73"
let s:frostGreen      = "#bae67e"
let s:frostYellow     = "#ffd580"
let s:frostOrange     = "#ffae57"
let s:frostBlue       = "#5ccfe6"
let s:frostPurple     = "#c3a6ff"
let s:frostForeground = "#d7dce2"
let s:frostLight_grey = "#8695b7"
let s:frostGrey       = "#2f3b54"
let s:frostDark_grey  = "#1d2433"

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
call s:Hi("ColorColumn", "", s:frostLight_grey, "", "")
call s:Hi("Cursor", s:frostBackground, s:frostPurple, "NONE", "")
call s:Hi("CursorLine", "", s:frostLight_grey, "NONE", "")
call s:Hi("Error", s:frostRed, "bg", "", "")
call s:Hi("iCursor", s:frostLight_grey, s:frostGrey, "", "")
call s:Hi("LineNr", s:frostGrey, s:frostLight_grey, "", "")
call s:Hi("MatchParen", s:frostBlue, s:frostGrey, "", "")
call s:Hi("NonText", s:frostRed, s:frostGrey, "", "")
call s:Hi("Normal", s:frostForeground, s:frostWorkbench, "", "")
call s:Hi("PMenu", s:frostDark_grey, s:frostLight_grey, "NONE", "")
call s:Hi("PmenuSbar", s:frostGrey, s:frostLight_grey, "", "")
call s:Hi("PmenuThumb", s:frostBlue, s:frostGrey, "", "")
call s:Hi("SpecialKey", s:frostGrey, "", "", "")
call s:Hi("SpellBad", s:frostRed, s:frostLight_grey, "undercurl", "")
call s:Hi("SpellCap", s:frostYellow, s:frostLight_grey, "undercurl", "")
call s:Hi("SpellLocal", s:frostDark_grey, s:frostLight_grey, "undercurl", "")
call s:Hi("SpellRare", s:frostDark_grey, s:frostLight_grey, "undercurl", "")
call s:Hi("Visual", "", s:frostAccent, "", "")
call s:Hi("VisualNOS", "", s:frostLight_grey, "", "")
call s:Hi("Whitespace", s:frostGrey, "", "", "")
hi! link PMenuSel IncSearch

" Frost specific
call s:Hi('BlendDown', "", s:frostUi_grey, '', '')

" Neovim Support
call s:Hi("healthError", s:frostRed, s:frostLight_grey, "", "")
call s:Hi("healthSuccess", s:frostGreen, s:frostLight_grey, "", "")
call s:Hi("healthWarning", s:frostYellow, s:frostLight_grey, "", "")
call s:Hi("TermCursorNC", "", s:frostLight_grey, "", "")

" Gutter
call s:Hi("CursorColumn", "", s:frostLight_grey, "", "")
call s:Hi("CursorLineNr", s:frostGrey, s:frostLight_grey, "NONE", "")
call s:Hi("FoldColumn", s:frostGrey, s:frostLight_grey, "", "")
call s:Hi("Folded", s:frostGrey, s:frostLight_grey, "bold", "")
call s:Hi("SignColumn", s:frostLight_grey, s:frostBackground, "", "")

" Navigation
call s:Hi("Directory", s:frostBlue, "", "", "")

" Prompt/Status
call s:Hi("EndOfBuffer", s:frostLight_grey, "", "", "")
call s:Hi("ErrorMsg", s:frostBackground, s:frostRed, "", "")
call s:Hi("ModeMsg", s:frostGreen, "", "" , "")
call s:Hi("MoreMsg", s:frostYellow, "", "" , "")
call s:Hi("Question", s:frostGrey, "", "", "")
call s:Hi("StatusLine", s:frostDark_grey, s:frostLight_grey, "NONE", "")
call s:Hi("StatusLineNC", s:frostLight_grey, s:frostGrey, "NONE", "")
call s:Hi("StatusLineTerm", s:frostBlue, s:frostGrey, "NONE", "")
call s:Hi("StatusLineTermNC", s:frostGrey, s:frostLight_grey, "NONE", "")
call s:Hi("VertSplit", s:frostLight_grey, s:frostBackground, "NONE", "")
call s:Hi("WarningMsg", s:frostBackground, s:frostYellow, "", "")
hi! link WildMenu IncSearch

" Search
call s:Hi("IncSearch", s:frostBackground, s:frostGreen, "bold", "")
call s:Hi("Search", s:frostBackground, s:frostYellow, "NONE", "")

 " QuickFix
hi! link qfFileName Directory
hi! link qfLineNr Directory
call s:Hi("qfSeparator", "fg", "bg", "", "")
call s:Hi("QuickFixLine", "fg", "bg", "bold", "")

" Tabs
call s:Hi("TabLineSel", s:frostYellow, s:frostLight_grey, "bold", "")
call s:Hi("TabLine", s:frostYellow, s:frostGrey, "none", "")
hi! link TabLineSel StatusLine
hi! link TabLineFill Normal

" Window
call s:Hi("Title", s:frostGrey, "", "NONE", "")
call s:Hi("Bold", "", "", "bold", "")
call s:Hi("Italic", "", "", "italic", "")
call s:Hi("Boolean", s:frostBlue, "", "", "")
call s:Hi("Character", s:frostYellow, "", "", "")
call s:Hi("Comment", s:frostGreen, "", "italic", "")
call s:Hi("Conditional", s:frostOrange, "", "", "")
call s:Hi("Constant", s:frostAccent, "", "", "")
call s:Hi("Define", s:frostOrange, "", "", "")
call s:Hi("Delimiter", s:frostBlue, "", "", "")
call s:Hi("Exception", s:frostBlue, "", "", "")
call s:Hi("Float", s:frostPurple, "", "", "")
call s:Hi("Function", s:frostBlue, "", "", "")
call s:Hi("Identifier", s:frostGreen, "", "NONE", "")
call s:Hi("Include", s:frostBlue, "", "", "")
call s:Hi("Keyword", s:frostBlue, "", "", "")
call s:Hi("Label", s:frostBlue, "", "", "")
call s:Hi("Number", s:frostPurple, "", "", "")
call s:Hi("Operator", s:frostYellow, "", "NONE", "")
call s:Hi("PreProc", s:frostBlue, "", "NONE", "")
call s:Hi("Repeat", s:frostBlue, "", "", "")
call s:Hi("Special", s:frostAccent, "", "", "")
call s:Hi("SpecialChar", s:frostYellow, "", "", "")
call s:Hi("SpecialComment", s:frostBlue, "", "italic", "")
call s:Hi("Statement", s:frostOrange, "", "", "")
call s:Hi("StorageClass", s:frostBlue, "", "", "")
call s:Hi("String", s:frostPurple, "", "", "")
call s:Hi("Structure", s:frostBlue, "", "", "")
call s:Hi("Tag", s:frostGrey, "", "", "")
call s:Hi("Todo", s:frostYellow, "NONE", "", "")
call s:Hi("Type", s:frostBlue, "", "NONE", "")
call s:Hi("Typedef", s:frostBlue, "", "", "")
hi! link Macro Define
hi! link PreCondit PreProc

call s:Hi("DiffAdd", s:frostGreen, s:frostWorkbench, "", "")
call s:Hi("DiffChange", s:frostYellow, s:frostWorkbench, "bold", "")
call s:Hi("DiffDelete", s:frostRed, s:frostWorkbench, "", "")
call s:Hi("DiffText", s:frostBlue, s:frostWorkbench, "", "")

call s:Hi("cIncluded", s:frostBlue, "", "", "")
hi! link cOperator Operator
hi! link cPreCondit PreCondit

call s:Hi("htmlArg", s:frostBlue, "", "", "")
call s:Hi("htmlLink", s:frostGrey, "", "NONE", "NONE")
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

call s:Hi("markdownBlockquote", s:frostBlue, "", "", "")
call s:Hi("markdownCode", s:frostDark_grey, "bg", "", "")
call s:Hi("markdownCodeBlock", s:frostDark_grey, "bg", "", "")
call s:Hi("markdownCodeDelimiter", s:frostGreen, "bg", "", "")
call s:Hi("markdownFootnote", s:frostBlue, "", "", "")
call s:Hi("markdownId", s:frostBlue, "", "", "")
call s:Hi("markdownIdDeclaration", s:frostBlue, "", "", "")
call s:Hi("markdownH1", s:frostYellow, "", "", "")
call s:Hi("markdownLinkText", s:frostBlue, "", "", "")
call s:Hi("markdownUrl", s:frostGrey, "", "underline", "")
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
