" Colorscheme: Frost

let g:colors_name = "little_monster"
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
    autocmd BufWinEnter,WinEnter * if &readonly
          \ | set winhighlight=Normal:BlendDown | set winhighlight= | endif
  augroup END
endif

let s:Workbench  = "#171c28"
let s:Background = "#1d2433"
let s:Pencil     = "#a2aab2"
let s:Ui_grey    = "#6679a4"
let s:Accent     = "#ffcc66"
let s:Red        = "#ef6b73"
let s:Green      = "#bae67e"
let s:Yellow     = "#ffd580"
let s:Orange     = "#ffae57"
let s:Blue       = "#5ccfe6"
let s:Purple     = "#c3a6ff"
let s:Foreground = "#d7dce2"
let s:Light_grey = "#8695b7"
let s:Grey       = "#2f3b54"
let s:Dark_grey  = "#1d2433"

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
call s:Hi("ColorColumn", "", s:Light_grey, "", "")
call s:Hi("Cursor", s:Background, s:Purple, "NONE", "")
call s:Hi("CursorLine", "", s:Grey, "NONE", "")
call s:Hi("Error", s:Red, "bg", "", "")
call s:Hi("iCursor", s:Light_grey, s:Grey, "", "")
call s:Hi("LineNr", s:Light_grey, "bg", "", "")
call s:Hi("MatchParen", s:Blue, s:Grey, "", "")
call s:Hi("NonText", s:Red, s:Grey, "", "")
call s:Hi("Normal", s:Foreground, s:Background, "", "")
call s:Hi("PMenu", s:Dark_grey, s:Light_grey, "NONE", "")
call s:Hi("PmenuSbar", s:Grey, s:Light_grey, "", "")
call s:Hi("PmenuThumb", s:Blue, s:Grey, "", "")
call s:Hi("SpecialKey", s:Grey, "", "", "")
call s:Hi("SpellBad", s:Red, "bg", "undercurl", "")
call s:Hi("SpellCap", s:Yellow, "bg", "undercurl", "")
call s:Hi("SpellLocal", s:Red, "bg", "undercurl", "")
call s:Hi("SpellRare", s:Red, "bg", "undercurl", "")
call s:Hi("Visual", s:Light_grey, s:Grey, "", "")
call s:Hi("VisualNOS", "", s:Light_grey, "", "")
call s:Hi("Whitespace", s:Grey, "", "", "")
hi! link PMenuSel IncSearch

" Frost specific
call s:Hi('BlendDown', s:Pencil, s:Workbench, '', '')

" Neovim Support
call s:Hi("healthError", s:Red, s:Light_grey, "", "")
call s:Hi("healthSuccess", s:Green, s:Light_grey, "", "")
call s:Hi("healthWarning", s:Yellow, s:Light_grey, "", "")
call s:Hi("TermCursorNC", "", s:Light_grey, "", "")

" Gutter
call s:Hi("CursorColumn", "", s:Light_grey, "", "")
call s:Hi("CursorLineNr", s:Purple, s:Ui_grey, "NONE", "")
call s:Hi("FoldColumn", s:Grey, s:Light_grey, "", "")
call s:Hi("Folded", s:Grey, s:Light_grey, "bold", "")
call s:Hi("SignColumn", s:Light_grey, s:Background, "", "")

" Navigation
call s:Hi("Directory", s:Blue, "", "", "")

" Prompt/Status
call s:Hi("EndOfBuffer", s:Light_grey, "bg", "", "")
call s:Hi("ErrorMsg", s:Red, "bg", "", "")
call s:Hi("ModeMsg", s:Green, "bg", "" , "")
call s:Hi("MoreMsg", s:Yellow, "bg", "" , "")
call s:Hi("Question", s:Accent, "bg", "", "")
call s:Hi("StatusLine", s:Yellow, s:Grey, "NONE", "")
call s:Hi("StatusLineNC", s:Light_grey, s:Workbench, "NONE", "")
call s:Hi("VertSplit", s:Grey, "bg", "NONE", "")
call s:Hi("WarningMsg", s:Accent, "bg", "", "")
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link WildMenu IncSearch

" Search
call s:Hi("IncSearch", s:Background, s:Green, "bold", "")
call s:Hi("Search", s:Background, s:Yellow, "NONE", "")

 " QuickFix
call s:Hi("qfSeparator", "fg", "bg", "", "")
call s:Hi("QuickFixLine", "fg", "bg", "bold", "")
hi! link qfFileName Directory
hi! link qfLineNr Directory

" Tabs
call s:Hi("TabLineSel", s:Yellow, s:Light_grey, "bold", "")
call s:Hi("TabLine", s:Yellow, s:Grey, "none", "")
hi! link TabLineSel StatusLine
hi! link TabLineFill Normal

" Window
call s:Hi("Title", s:Green, "", "bold", "")
call s:Hi("Bold", "", "", "bold", "")
call s:Hi("Italic", "", "", "italic", "")
call s:Hi("Boolean", s:Blue, "", "", "")
call s:Hi("Character", s:Yellow, "", "", "")
call s:Hi("Comment", s:Green, "", "italic", "")
call s:Hi("Conditional", s:Orange, "", "", "")
call s:Hi("Constant", s:Accent, "", "", "")
call s:Hi("Define", s:Orange, "", "", "")
call s:Hi("Delimiter", s:Blue, "", "", "")
call s:Hi("Exception", s:Blue, "", "", "")
call s:Hi("Float", s:Purple, "", "", "")
call s:Hi("Function", s:Blue, "", "", "")
call s:Hi("Identifier", s:Green, "", "NONE", "")
call s:Hi("Include", s:Blue, "", "", "")
call s:Hi("Keyword", s:Blue, "", "", "")
call s:Hi("Label", s:Blue, "", "", "")
call s:Hi("Number", s:Purple, "", "", "")
call s:Hi("Operator", s:Yellow, "", "NONE", "")
call s:Hi("PreProc", s:Blue, "", "NONE", "")
call s:Hi("Repeat", s:Blue, "", "", "")
call s:Hi("Special", s:Accent, "", "", "")
call s:Hi("SpecialChar", s:Yellow, "", "", "")
call s:Hi("SpecialComment", s:Blue, "", "italic", "")
call s:Hi("Statement", s:Orange, "", "", "")
call s:Hi("StorageClass", s:Blue, "", "", "")
call s:Hi("String", s:Purple, "", "", "")
call s:Hi("Structure", s:Blue, "", "", "")
call s:Hi("Tag", s:Grey, "", "", "")
call s:Hi("Todo", s:Yellow, "NONE", "", "")
call s:Hi("Type", s:Blue, "", "NONE", "")
call s:Hi("Typedef", s:Blue, "", "", "")
hi! link Macro Define
hi! link PreCondit PreProc

call s:Hi("DiffAdd", s:Green, s:Workbench, "", "")
call s:Hi("DiffChange", s:Yellow, s:Workbench, "bold", "")
call s:Hi("DiffDelete", s:Red, s:Workbench, "", "")
call s:Hi("DiffText", s:Blue, s:Workbench, "", "")

call s:Hi("cIncluded", s:Blue, "", "", "")
hi! link cOperator Operator
hi! link cPreCondit PreCondit

call s:Hi("htmlArg", s:Blue, "", "", "")
call s:Hi("htmlLink", s:Grey, "", "NONE", "NONE")
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

call s:Hi("markdownBlockquote", s:Blue, "", "", "")
call s:Hi("markdownCode", s:Dark_grey, "bg", "", "")
call s:Hi("markdownCodeBlock", s:Dark_grey, "bg", "", "")
call s:Hi("markdownCodeDelimiter", s:Green, "bg", "", "")
call s:Hi("markdownFootnote", s:Blue, "", "", "")
call s:Hi("markdownId", s:Blue, "", "", "")
call s:Hi("markdownIdDeclaration", s:Blue, "", "", "")
call s:Hi("markdownH1", s:Yellow, "", "", "")
call s:Hi("markdownLinkText", s:Blue, "", "", "")
call s:Hi("markdownUrl", s:Grey, "", "underline", "")
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
